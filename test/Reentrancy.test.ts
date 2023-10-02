import { ethers } from "hardhat";
import { BaseContract, Signer } from "ethers";
import { expect } from "chai";

async function testAttack(
    victimContract: string,
    owner: Signer,
    attackerSigner: Signer,
    alice: Signer,
    expectedEthersInAttacker: string,
    expectedEthersInVictim: string
) {
    const Victim = await ethers.getContractFactory(victimContract);
    let victim: any = await Victim.connect(owner).deploy();
    let victimAddress = await victim.getAddress();

    const Attacker = await ethers.getContractFactory("Attacker");
    let attacker = await Attacker.connect(attackerSigner).deploy(await victim.getAddress(), {
        value: ethers.parseEther("1"),
    });
    let attackerAddress = await attacker.getAddress();
    // Call the payIn function on the victim contract to add funds
    await attacker.payIn();
    // Call the payIn function on the victim contract to add funds
    await victim.connect(alice).payIn({ value: ethers.parseEther("9") });

    // Call the withdrawAttack function on the attacker contract to initiate the attack
    await attacker.withdrawAttack();

    // Check that the attacker contract has a balance of expectedEthersInAttacker ethers
    expect(await ethers.provider.getBalance(attackerAddress)).to.equal(
        ethers.parseEther(expectedEthersInAttacker)
    );

    // Check that the victim contract has a balance of expectedEthersInVictim
    expect(await ethers.provider.getBalance(victimAddress)).to.equal(
        ethers.parseEther(expectedEthersInVictim)
    );
}

describe("Attacker", function () {
    let attacker: any;
    let victim: BaseContract;
    let owner: Signer;
    let attackerSigner: Signer;
    let alice: Signer;

    beforeEach(async function () {
        [owner, attackerSigner] = await ethers.getSigners();

        const Victim = await ethers.getContractFactory("Victim");
        victim = await Victim.connect(owner).deploy();

        const Attacker = await ethers.getContractFactory("Attacker");
        attacker = await Attacker.connect(attackerSigner).deploy(await victim.getAddress(), {
            value: ethers.parseEther("1"),
        });
    });
    it("should perform a reentrancy attack to the victim", async function () {
        [owner, attackerSigner, alice] = await ethers.getSigners();
        await testAttack("Victim", owner, attackerSigner, alice, "10", "0");
    });

    it("should fail the reentrancy attack on the Secure contract", async function () {
        [owner, attackerSigner, alice] = await ethers.getSigners();
        await testAttack("Secure", owner, attackerSigner, alice, "1", "9");
    });

    it("should fail the reentrancy attack on the ReentrancyWithOZ contract", async function () {
        [owner, attackerSigner, alice] = await ethers.getSigners();
        await testAttack("ReentrancyWithOZ", owner, attackerSigner, alice, "1", "9");
    });
});
