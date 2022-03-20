// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract prescriptionUpdate{

}


contract Medical{
    

    bytes32 patient_key;
    bytes32 doctor_key;
    address owner;

    struct Patient {
        uint id;
        string firstName;
        string lastName;
        string DoB;
    }

    struct Profile {
        string prescription;
        //string latest_date;
        uint256 latest_date;
    }
    Patient patient;
    Profile profile;

    constructor(uint _id, string memory _firstName, string memory _lastName, string memory _DoB) {
        owner = msg.sender;
        patient.id = _id;
        patient.firstName = _firstName;
        patient.lastName = _lastName;
        patient.DoB = _DoB;
        

        profile.prescription = "";
        profile.latest_date = 1647397301;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }

    function editProfile(
        string memory _prescription,
        //string memory _latest_date
        uint256 _latest_date
    )
        public 
        onlyOwner{
        profile.prescription = _prescription;
        profile.latest_date = _latest_date;
    }

    function get_profile() public view returns(string memory prescription, uint256 latest_date){
        return (profile.prescription,profile.latest_date);
    }

    function get_patient() public view returns(//add patient's address
    uint id,
    string memory firstName,
    string memory lastName,
    string memory DoB){
        return (patient.id, patient.firstName, patient.lastName, patient.DoB);
    }

    function invoke_other_contract public view{
        prescriptionUpdate();
    }

    // function get_patient() public view returns(memory Patient){
    //     return patient;
    // }

}