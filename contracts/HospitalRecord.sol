// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;

//This contract does not require any inheritance so I am doing it under LibraryDemo.sol in the contracts folder itself

/** @title Hospital Record. */
contract HospitalRecord{


    //a struct for a doctor storing his ID, name, qualification, workplace and a boolean to check if he is already registered
    struct Doctor{
        uint id;
        string name;
        string qualification;
        string workPlace;
        bool registered;
        // as a proof upload a certificate of ur degree or a certified doctor on ipfs and upload a hash value here
    }

    // a struct for patient storing his Id,name,age,disease and boolean to check if he is registered
    struct Patient{
        uint Id;
        string name;
        uint age;
        bytes disease;
        bool Registered;
    }

    // mapping to map each struct with the address
    mapping(address => Doctor) doctors;
    mapping(address => Patient) patients;

    Patient[] patient_record;
    Doctor[] doctor_record;
    uint patient_id;
    uint doctor_id;

    // events to record some data
    event doctorRegistered(address indexed _address,uint id,string name);
    event patientRegistered(uint id);

    // modifiers 
    modifier onlyPatient{
        require(patients[msg.sender].Registered,"You are not registered");
        _;
    }

    modifier onlyDoctor{
        require(doctors[msg.sender].registered,"You are not a registered doctor");
        _;
    }


    /**  
        @dev Registers a user as a doctor
        @param _name Name of the user
        @param _qualification Which degree he/she holds as a doctor
        @param _workPlace Address of his/her hospital/clinic
    */
    function registerDoctor(string memory _name,string memory _qualification,string memory _workPlace) public {

        require(!doctors[msg.sender].registered,"You are already registered");
        doctor_id++;
        doctors[msg.sender].id = doctor_id;
        doctors[msg.sender].name = _name;
        doctors[msg.sender].qualification = _qualification;
        doctors[msg.sender].workPlace = _workPlace;
        doctors[msg.sender].registered = true;
        doctor_record.push(doctors[msg.sender]);
        emit doctorRegistered(msg.sender,doctors[msg.sender].id,_name);

    }

    /**
        @dev Registers a user as patient
        @param _name Name of the user
        @param _age Age of user
    */
    function registerPatient(string memory _name,uint _age) public {

        require(!patients[msg.sender].Registered,"You are already registered patient");
        Patient storage patient = patients[msg.sender];
        patient_id++;
        patient.Id = patient_id;
        patient.name = _name;
        patient.age = _age;
        patient.Registered = true;
        patient_record.push(patients[msg.sender]);
        emit patientRegistered(patient.Id);

    }

    /**
        @dev Add new disease to a registered Patient (only one disease at a time)
        @param _disease Name of the disease
    */
    function addNewDisease(string memory _disease) public onlyPatient{

        string memory init = string(patients[msg.sender].disease);
        init = string(abi.encodePacked(init,", "));
        patients[msg.sender].disease = abi.encodePacked(init,_disease);
        patient_record[patients[msg.sender].Id - 1].disease = abi.encodePacked(init,_disease);

    }

    /**
        @dev Updates the age of the registered Patient
        @param _age New age of the patient
    */
    function updateAge(uint _age) public onlyPatient{

        patients[msg.sender].age = _age;
        patient_record[patients[msg.sender].Id - 1].age = _age;

    }

    /**
        @dev View record of the Patient only by himself
        @return id Id of the patient
        @return age Age of the patient
        @return name Name of the patient
        @return disease All the disease of the patient
    */
    function viewRecord() public view onlyPatient returns(uint id,uint age,string memory name,string memory disease){

         id = patients[msg.sender].Id;
         age = patients[msg.sender].age;
         name = patients[msg.sender].name;
         disease = string(patients[msg.sender].disease);

    }

    /**
        @dev View record of the Patient only by registered doctor
        @param _id ID of the patient
        @return id ID of the patient
        @return age Age of the patient
        @return name Name of the patient
        @return disease All the disease of the patient
    */
    function viewPatientbyDoctor(uint _id) public view onlyDoctor returns(uint id,uint age,string memory name,string memory disease){
        
        require(_id <= patient_id,"The patient with given Id does not exist");
         for(uint i = 0 ;i < patient_record.length;i++){
             if(patient_record[i].Id == _id){
                 return (patient_record[i].Id,patient_record[i].age,patient_record[i].name,string(patient_record[i].disease));
             }
        }

    }

    /**
        @dev View record of the Doctor by anyone
        @param _id ID of the doctor
        @return id ID of the doctor
        @return nmae Name of the doctor
        @return qualification Which degree he/she holds as a doctor
        @return add Address of his/her hospital/clinic
    */
    function viewDoctorById(uint _id) public view returns(uint id,string memory nmae,string memory qualification,string memory add){
       
        require(_id <= doctor_id,"The doctor with given Id does not exist");
        for(uint i = 0;i < doctor_record.length;i++){
            if(doctor_record[i].id == _id){
                return (doctor_record[i].id,doctor_record[i].name,doctor_record[i].qualification,doctor_record[i].workPlace);
            }
        }
        
    }
}