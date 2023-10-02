import { HardhatRuntimeEnvironment } from "hardhat/types";
import { DeployFunction } from "hardhat-deploy/types";
import { printDeploySuccessful, printInfo } from "../utils/utils";

const version = "v0.0.0";
const ContractName = "Reentrancy";

const func: DeployFunction = async function (hre: HardhatRuntimeEnvironment) {
    const { deployments, getNamedAccounts } = hre;
    const { deploy } = deployments;

    const { deployer } = await getNamedAccounts();

    printInfo(`\n Deploying ${ContractName} contracts...`);

    const VictimResult = await deploy("Victim", {
        args: [],
        from: deployer,
        autoMine: true,
    });

    printDeploySuccessful("Victim", VictimResult.address);

    const AttackerResult = await deploy("Attacker", {
        args: [VictimResult.address],
        from: deployer,
        autoMine: true,
    });

    printDeploySuccessful("VictimAttacker", AttackerResult.address);

    const SecureResult = await deploy("Secure", {
        args: [],
        from: deployer,
        autoMine: true,
    });

    printDeploySuccessful("Secure", SecureResult.address);

    const SecureAttackerResult = await deploy("Attacker", {
        args: [SecureResult.address],
        from: deployer,
        autoMine: true,
    });

    printDeploySuccessful("SecureAttacker", SecureAttackerResult.address);

    const SecureWithOZResult = await deploy("SecureWithOZ", {
        args: [],
        from: deployer,
        autoMine: true,
    });

    printDeploySuccessful("Secure", SecureWithOZResult.address);

    const SecureWithOZAttackerResult = await deploy("Attacker", {
        args: [SecureWithOZResult.address],
        from: deployer,
        autoMine: true,
    });

    printDeploySuccessful("SecureWithOZAttacker", SecureWithOZAttackerResult.address);

    return true;
};

export default func;
const id = ContractName + version;
func.tags = [id, version];
func.id = id;
