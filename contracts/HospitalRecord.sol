// SPDX-License-Identifier: MIT
pragma solidity >=0.4.21 <0.7.0;
contract HospitalRecord{
    struct Doctor{
        uint id;
        string name;
        string qualification;
        string workPlace;
        bool registered;
        // as a proof upload a certificate of ur degree or a certified doctor on ipfs and upload a hash value here
    }
    struct Patient{
        uint Id;
        string name;
        uint age;
        bytes disease;
        bool Registered;
    }
    mapping(address => Doctor) doctors;
    mapping(address => Patient) patients;
    Patient[] patient_record;
    Doctor[] doctor_record;
    uint patient_id;
    uint doctor_id;
    event doctorRegistered(address indexed _address,uint id,string name);
    event patientRegistered(uint id);
    modifier onlyPatient{require(patients[msg.sender].Registered,"You are not registered");
        _;
    }
    modifier onlyDoctor{
        require(doctors[msg.sender].registered,"You are not a registered doctor");
        _;
    }
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
    function addNewDisease(string memory _disease) public onlyPatient{
        string memory init = string(patients[msg.sender].disease);
        init = string(abi.encodePacked(init,", "));
        patients[msg.sender].disease = abi.encodePacked(init,_disease);
        patient_record[patients[msg.sender].Id - 1].disease = abi.encodePacked(init,_disease);
    }
    function updateAge(uint _age) public onlyPatient{
        patients[msg.sender].age = _age;
        patient_record[patients[msg.sender].Id - 1].age = _age;
    }
     function viewRecord() public view onlyPatient returns(uint id,uint age,string memory name,string memory disease){
         id = patients[msg.sender].Id;
         age = patients[msg.sender].age;
         name = patients[msg.sender].name;
         disease = string(patients[msg.sender].disease);
     }
     function viewPatientbyDoctor(uint _id) public view onlyDoctor returns(uint id,uint age,string memory name,string memory disease){
         require(_id <= patient_id,"The patient with given Id does not exist");
         for(uint i = 0 ;i < patient_record.length;i++){
             if(patient_record[i].Id == _id){
                 return (patient_record[i].Id,patient_record[i].age,patient_record[i].name,string(patient_record[i].disease));
             }
         }
     }
     function viewDoctorById(uint _id) public view returns(uint id,string memory nmae,string memory qualification,string memory add){
        require(_id <= doctor_id,"The doctor with given Id does not exist");
        for(uint i = 0;i < doctor_record.length;i++){
            if(doctor_record[i].id == _id){
                return (doctor_record[i].id,doctor_record[i].name,doctor_record[i].qualification,doctor_record[i].workPlace);
            }
        }
     }
}