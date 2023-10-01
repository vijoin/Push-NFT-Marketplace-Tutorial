const { expect } = require("chai");
const { loadFixture } = require("@nomicfoundation/hardhat-toolbox/network-helpers"); 
// let ethersToWei = ethers.utils.parseUnits("1", "ether");

describe("NFT Marketplace", function () {
  async function deployContractFixture() {
    const [owner] = await ethers.getSigners();

    const nftMarketplace = await ethers.deployContract("NFTMarketplace");

    return { nftMarketplace, owner }

  }

  it("Deployment should assign the sender as owner", async function () {
    const { nftMarketplace, owner } = await loadFixture(deployContractFixture);

    expect(await nftMarketplace.owner()).to.be.equal(owner.address);
  });

  it.only("Test create Token", async function(){
    const { nftMarketplace, owner } = await loadFixture(deployContractFixture);

    await nftMarketplace.createToken("URI", ethers.parseEther("0.02"), { value: ethers.parseEther("0.01") });
    
    const count = await nftMarketplace.getCurrentToken();
    expect(count.toString()).to.be.equal("1");
  });
  it("Test Sell Token");

});