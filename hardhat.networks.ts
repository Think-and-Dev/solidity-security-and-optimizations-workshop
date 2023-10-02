const networks: any = {
    sepolia: {
        url: process.env.SEPOLIA_NODE_URL,
        accounts: [process.env.TESTNET_DEPLOYER_PRIVATE_KEY],
    },
    hardhat: {
        live: false,
        allowUnlimitedContractSize: true,
        initialBaseFeePerGas: 0,
        chainId: 31337,
        tags: ["test", "local"],
    },
    localhost: {
        chainId: 31337,
        url: "http://127.0.0.1:8545",
        allowUnlimitedContractSize: true,
        timeout: 1000 * 60,
    },
};

export default networks;
