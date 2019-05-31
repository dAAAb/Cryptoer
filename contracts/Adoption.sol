pragma solidity ^0.5.0;

contract Adoption {
  address[36] public adopters;
  uint[36] public prices;
  address public owner;

  constructor() public {
    owner = msg.sender;
    for (uint i=0;i<36;++i) {
      prices[i] = 0.001 ether;  
    }
  }

  // Adopting a pet
  function adopt(uint petId) public payable returns (uint) {
    require(petId >= 0 && petId <= 35);
    require(msg.value >= prices[petId]);

    prices[petId] *= 200;
    prices[petId] /= 100;

    adopters[petId] = msg.sender;
    return petId;
  }

  // Retrieving the adopters
  function getAdopters() public view returns (address[36] memory, uint[36] memory) {
    return (adopters,  prices);
  }
  
  modifier onlyOwner() {
        require (msg.sender == owner);
        _;
      }
  function withdraw() public onlyOwner{
    msg.sender.transfer(address(this).balance);
  }
}