const dotenv = require("dotenv");
const { ethers } = require("ethers");

require("@nomicfoundation/hardhat-chai-matchers");
require("@nomicfoundation/common");
require("@nomiclabs/hardhat-web3");
require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
require("hardhat-exposed"); // to expose internal function of contracts

dotenv.config();

const generatedWallets = [...Array(10).keys()].map(() => ({
	privateKey: ethers.Wallet.createRandom().privateKey,
	balance: "10000000000000000000000",
}));

// You need to export an object to set up your config
// Go to https://hardhat.org/config/ to learn more

/**
 * @type import('hardhat/config').HardhatUserConfig
 */
module.exports = {
	solidity: {
		compilers: [
			{
				version: "0.8.13",
				settings: {
					optimizer: {
						enabled: true,
						runs: 200,
						// details: {
						//   yul: false,
						// },
					},
					viaIR: true, // to remove stack too deep issue, but will slow down compilation by a lot
				},
			},
		],
	},
	mocha: {
		timeout: 100000,
	},
	networks: {
		mumbai: {
			url: process.env.MUMBAI_URL || "",
			accounts:
				process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
		},
		goerli: {
			url: process.env.GOERLI_URL || "",
			accounts:
				process.env.PRIVATE_KEY !== undefined ? [process.env.PRIVATE_KEY] : [],
		},
		hardhat: {
			chainId: 31337, // Chain ID should match the hardhat network's chainid
			accounts:
				process.env.PRIVATE_KEY !== undefined
					? [
							{
								privateKey: process.env.PRIVATE_KEY,
								balance: "10000000000000000000000",
							},
							...generatedWallets,
					  ]
					: undefined,
		},
	},
	gasReporter: {
		enabled: process.env.REPORT_GAS !== undefined,
		currency: "USD",
	},
	etherscan: {
		apiKey: process.env.ETHERSCAN_API_KEY,
	},
	exposed: {
		exclude: ["DiamondProxyContract.sol"],
	},
};
