const { expect } = require("chai");

describe("CryptoPrimality", function() {
  it("Should be able to view the constructed private variables", async function() {
    const PrimalityTest = await ethers.getContractFactory("CryptoPrimality");
    console.log("1");
    const primalityTest = await PrimalityTest.deploy(256, 10000);
    
    console.log("2");
    await primalityTest.deployed();
    console.log("3");
    expect(await primalityTest.viewNumber()).to.equal(256);
    console.log("4");
    expect(await primalityTest.viewPrimality()).to.equal(true);

    console.log("5");
    await primalityTest.challenge(8, "TODO address");
    console.log("6");
    expect(await primalityTest.viewPrimality()).to.equal(false);
  });
});
