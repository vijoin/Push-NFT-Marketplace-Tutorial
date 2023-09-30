const { expect } = require("chai");

describe("", function () {
  it("Deployment should assign the sender as owner", async function () {
    const [owner] = await ethers.getSigners();

    const NftMarketplace = await ethers.getContractFactory("NFTMarketplace");
    const nftMarketplace = await NftMarketplace.deploy();
    await nftMarketplace.deployed();

    expect(await nftMarketplace.owner()).to.be.equal(owner.address);
  });

  it("Test create Token");
  it("Test Sell Token");

});