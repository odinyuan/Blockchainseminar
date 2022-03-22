// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract prescriptionUpdate{
    bytes32 doctor_key;
    bytes32 insurance_company_key;
    address doctor_add;
    address insurance_company_add;

    struct Prescription {
        string[] new_prescription_list;
        //string latest_date;
        uint256 issue_date;
    }

    struct Bill{
        string[] prescription_list;
        string[] fee_list;
        uint total_fee;
        uint256 issue_date;
    }

    Bill bill;
    Prescription prescription;

    constructor(address _doctor_add, address _insurance_company_add){
        doctor_add = _doctor_add;
        insurance_company_add = _insurance_company_add;
    }


    modifier onlyOwner(){
        require(msg.sender == insurance_company_add || msg.sender == doctor_add);
        _;
    }

    modifier onlyInsurance(){
        require(msg.sender == insurance_company_add);
        _;
    }

    function set_prescription (string memory _prescription, uint256 date) external onlyOwner{
        
        //fill the prescription array with parameter
    }

    function set_bill () external onlyInsurance{
        
        //fill the bill array with parameter
    }

    function get_bill() public view returns(
        string[] memory prescription_list,
        uint256 issue_date,
        string[] memory fee_list,
        uint total_fee)
        {
        return(bill.prescription_list,bill.issue_date,bill.fee_list,bill.total_fee);
    }

    function get_prescription() public view returns(
        string[] memory prescription_list,
        uint256 issue_date)
        {
            return(prescription.new_prescription_list,prescription.issue_date);
    }
}

contract Insurance{
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

contract Medical{
    

    bytes32 patient_key;
    bytes32 doctor_key;
    address owner;
    address insur_add;

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

    constructor(uint _id, string memory _firstName, string memory _lastName, string memory _DoB, address _insur_add) {
        owner = msg.sender;
        patient.id = _id;
        patient.firstName = _firstName;
        patient.lastName = _lastName;
        patient.DoB = _DoB;
        insur_add = _insur_add;        

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
        Insurance _insur = Insurance(address(insur_add));
        require(!_insur.isExpired());
        return (patient.id, patient.firstName, patient.lastName, patient.DoB);
    }

    // function invoke_other_contract public view{
    //     prescriptionUpdate();
    // }

    // function get_patient() public view returns(memory Patient){
    //     return patient;
    // }

}