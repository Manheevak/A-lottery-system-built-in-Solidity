// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract lottery{
    constructor() public {
        manager = msg.sender; // global variable
    }
    address public manager;
    address payable[] public participants;

  receive() external payable{
      require(msg.value==0.2 ether);
      participants.push(payable(msg.sender));
  }
      function getBalance() public view returns(uint){
          require(msg.sender==manager);
          return address(this).balance;
      }
      function random() public view returns(uint){
        return uint(keccak256(abi.encodePacked(block.difficulty,block.timestamp,participants.length)));

      }
      function selectwinner() public {
             require(msg.sender==manager);
             require(participants.length > 3);
            uint r = random();
            address payable winner;
           uint index = r % participants.length;
           winner = participants[index];
           winner.transfer(getBalance());
           participants = new address payable[](0);
      }
      }


