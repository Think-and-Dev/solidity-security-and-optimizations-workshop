import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";
import "hardhat-deploy";
import dotenv from "dotenv";
dotenv.config();
import namedAccounts from "./hardhat.accounts";
import networks from "./hardhat.networks";

const config: HardhatUserConfig = {
    paths: {
        sources: "./contracts/src",
    },
    solidity: {
        compilers: [
            {
                version: "0.6.12",
            },
            {
                version: "0.8.19",
            },
        ],
    },
    namedAccounts: namedAccounts,
    networks: networks,
};

export default config;
