// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract contract2{
    bytes32 patient_key;
    bytes32 insurance_company_key;
    address owner;

    struct Profile {
        uint id;
        uint256 issueDate;
        uint256 expiredDate;
        string firstName;
        string lastName;
        string DoB;
        string insuranceInfo;
    }

    Profile profile;

    constructor(
    uint _id,
    string memory _firstName,
    string memory _lastName,
    string memory _DoB,
    string memory _insuranceInfo) {
        owner = msg.sender;
        profile.id = _id;
        profile.firstName = _firstName;
        profile.lastName = _lastName;
        profile.DoB = _DoB;
        profile.issueDate = 1647397301;
        //profile.expiredDate = 1678977930;
        profile.expiredDate = 1647397301;
        profile.insuranceInfo = _insuranceInfo;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    

    function isExpired() public view returns(bool){
        return block.timestamp <= profile.expiredDate;
    }

    function editProfile(
    string memory _firstName,
    string memory _lastName,
    string memory _DoB,
    string memory _insuranceInfo,
    uint256 _issueDate,
    uint256 _expiredDate
    )
        public 
        onlyOwner{
        profile.firstName = _firstName;
        profile.lastName = _lastName;
        profile.DoB = _DoB;
        profile.insuranceInfo = _insuranceInfo;
        profile.issueDate = _issueDate;
        profile.expiredDate = _expiredDate;
    }
}