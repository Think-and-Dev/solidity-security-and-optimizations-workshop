import { ethers } from "hardhat";
import { expect } from "chai";
import { BalrogExample } from "../typechain-types/auth/BalrogExample";

describe("BalrogExample", function () {
    let balrogExample: BalrogExample;

    beforeEach(async function () {
        const BalrogExample = await ethers.getContractFactory("BalrogExample");
        const [, balrogAddress] = await ethers.getSigners();
        balrogExample = await BalrogExample.deploy(balrogAddress);
    });

    it("should not allow the balrog to cross the bridge", async function () {
        const [, balrog] = await ethers.getSigners();
        await expect(
            balrogExample.connect(balrog).cruzarElPuenteDeLasMinasDeMoria()
        ).to.be.revertedWith("YOU SHALL NOT PASS!!");
    });

    it("should allow Alice to cross the bridge", async function () {
        const [frodo] = await ethers.getSigners();
        await expect(balrogExample.connect(frodo).cruzarElPuenteDeLasMinasDeMoria()).to.not.be
            .reverted;
    });
});
