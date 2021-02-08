//SPDX-License-Identifier: Unlicense
pragma solidity ^0.7.0;

import "hardhat/console.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract CryptoPrimality is Ownable {
  bool isPrime;
  uint number;
  uint256 expiration;

  constructor(uint _number, uint256 timeout) {
    console.log("Deploying a primality test for number:", _number);
    number = _number;
    isPrime = true;
    expiration = block.timestamp + timeout;
  }

  function viewNumber() public view returns (uint) {
    return number;
  }

  function viewPrimality() public view returns (bool) {
    return isPrime;
  }

  function depositBond() public payable returns(bool success) {
    return true;
  }

  function claimExpiredBond(address payable payee) onlyOwner public {
    require(block.timestamp >= expiration);
    selfdestruct(payee);
  }

  function challenge(uint factor, address payable recipient) public {
    if (block.timestamp < expiration) {
      console.log("challenging primality of number %d with factor %d", number, factor);
      if (number % factor == 0) {
        isPrime = false; 
        uint balance =  address(this).balance;
        console.log("Primality disproven; paying out %d...", balance);
        recipient.transfer(balance);
      }
    } else {
      console.log("bond has expired and can be claimed via `claimExpiredBond()`");
    }
  }
}
