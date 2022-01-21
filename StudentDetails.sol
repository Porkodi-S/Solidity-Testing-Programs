// SPDX-License-Identifier: MIT
pragma solidity >=0.5.0 <0.7.0;
contract StudentDetails{
    address public admin;

    struct Record{
    int regno;
    string name;
    string class;
    address studAddr;
    bool isValue;
    int approvedCount;
    mapping (address => int) approved; // map student addr to regno (data type)
    }

    modifier approveOnly {
        require (msg.sender == admin); //pre-require condition(nly admin cn aprv)
        _;
    }

     constructor() public { //contract deploy msg sender is set as admin
        admin=msg.sender;
    }

    mapping (int=> Record) public Viewrecord;
    event recordSigned(int regno, string name, string class);

    function newRegisteration(int newRegno, string memory newName, string memory newClass) public {
        Record storage newRecord = Viewrecord[newRegno];
        require(!Viewrecord[newRegno].isValue, "Record Already Exsist."); //rec cn b created only once
        newRecord.regno = newRegno;
        newRecord.name = newName;
        newRecord.class = newClass;
        newRecord.studAddr = msg.sender;
        newRecord.isValue = true;
        newRecord.approvedCount = 0;

    }
    function approveRegistration(int newRegno) approveOnly public{
        Record storage signedRecord = Viewrecord[newRegno];
        require(address(0) != signedRecord.studAddr); //nly can sign rec in db
        require(msg.sender != signedRecord.studAddr); //stud cant sign
        require(signedRecord.approved[msg.sender] != 1); // can sign only once
        signedRecord.approved[msg.sender] = 1;
        signedRecord.approvedCount++;
        if(signedRecord.approvedCount == 1)
            emit  recordSigned(signedRecord.regno, signedRecord.name, signedRecord.class);

    }
}
