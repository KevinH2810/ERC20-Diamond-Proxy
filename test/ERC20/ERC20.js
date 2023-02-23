const { describeBehaviorOfERC20Base } = require("@solidstate/spec");
const { ethers } = require("hardhat");
const { expect } = require("chai");

describe("ERC20 Facet", () => {
	let testContract;

	const initData = {
		name: "testERC20",
		symbol: "TST",
		maxSupply: 10000,
	};

	// addresses
	let deployerAndVerifier;
	let projectOwner;
	let addr1;
	let addr2;

	beforeEach(async function () {
		[deployerAndVerifier, projectOwner, addr1, addr2] =
			await ethers.getSigners();
		testContract = await deployContract(
			initData.name,
			initData.symbol,
			initData.maxSupply,
			projectOwner
		);
		await testContract.$_setOwner(projectOwner.address);
	});

	describe("mint", () => {
		// reverted with custom error from Ownable contract
		// please refer to https://github.com/solidstate-network/solidstate-solidity/blob/master/contracts/access/ownable/IOwnableInternal.sol for more details
		it("fail - to mint not owner", async () => {
			await expect(
				testContract.connect(addr1).mint(addr1.address, 10)
			).to.be.revertedWith("Ownable__NotOwner");
		});

		it("success - to allow owner to mint", async () => {
			await testContract.connect(projectOwner).mint(addr1.address, 10);

			const balance = await testContract.balanceOf(addr1.address);
			expect(balance).to.equal(10);
		});
	});
});

const deployContract = async (name, symbol, maxSupply, owner) => {
	const contractFactory = await ethers.getContractFactory("$ERC20Facet");
	const testContract = await contractFactory
		.connect(owner)
		.deploy(name, symbol, maxSupply);
	await testContract.deployed();

	return testContract;
};
