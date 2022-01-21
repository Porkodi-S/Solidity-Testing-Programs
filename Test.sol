// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.7.0;
contract Test {
   address public a;

   //mapping (address => uint) public balances;
   
   //event Sent(address from, address to, uint amount);

   constructor() public {
      a = msg.sender;
      }

   function test (address b) public {
      require(msg.sender == a);
      a=b;
   } 
}
