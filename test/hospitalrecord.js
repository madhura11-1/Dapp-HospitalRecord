let HospitalRecord = artifacts.require("./HospitalRecord.sol");
let contractinstance;

contract("HospitalRecord",function(accounts) {

    // test to check if contract is deployed or not 
     it("Contract Deployment",function(){
         return HospitalRecord.deployed()
         .then(function(instance){
             contractinstance = instance;
             assert(contractinstance !== undefined,"HospitalRecord contract needs to be defined");
         })
     });

    /* test to register a doctor and check if the doctor is registered successfully by viewing the doctor's records and checking
        them with the provided input itself.  */
     it("Registered a Doctor",function(){
        return contractinstance.registerDoctor("Doctor1","MD","Pune",{from: accounts[1]})
        .then(function(receipt){
            return contractinstance.viewDoctorById(1);
        })
        .then(function(result){
            assert.equal(result[1],"Doctor1","Doctor education displayed");
        })
     });


    /* test to register a patient and check if the patient is registered successfully or not by viewing the patient by doctor only and
     checking them with the provided input.
    */ 
     it("Registered a Patient",function(){
         return contractinstance.registerPatient("Patient1",32,{from : accounts[2]})
         .then(function(receipt){
            return contractinstance.viewPatientbyDoctor(1,{from : accounts[1]});
         })
         .then(function(result){
             assert.equal(result[1],32,"Patient's age displayed");
             return contractinstance.viewRecord({from : accounts[2]});
         })
         .then(function(result1){
             assert.equal(result1[2],"Patient1","Patient's name displayed");
         })
     });


     // test to check if a registered patient can add a disease or not
     it("Adds a disease of the patient",function(){

        return contractinstance.addNewDisease("Cough",{from : accounts[2]})
        .then(function(receipt){
            return contractinstance.viewPatientbyDoctor(1,{from : accounts[1]});
        })
        .then(function(result){
            assert.equal(result[3],", Cough","Patient's diseases displayed");
        })

     });

     // test to check if a registered patient can update his age or not
     it("Updates the age of Patient",function(){
         return contractinstance.updateAge(50,{from : accounts[2]})
         .then(function(result){
             return contractinstance.viewRecord({from : accounts[2]});
         })
         .then(function(result1){
             assert.equal(result1[1],50,"Age updated");
         })
     });

     // test to check that a same doctor cannot register twice on the platfrom
     it("should not register same doctor twice",function(){
         return contractinstance.registerDoctor("Doctor2","Md","Pune",{from : accounts[1]})
         .then(function(result){
             throw("same doctor");
         }).catch(function(e){
             let a = e.toString();
             if(a === "same doctor"){
                 assert(false);
             }
             else{
                 assert(true);
             }
         })
     });


    // test to check that a doctor who is not yet registered on the platfrom cannot view any patients record 
     it("Non registered doctors cannot view the patient's information",function(){
         return contractinstance.viewPatientbyDoctor(1,{from : accounts[4]})
     .then(function(result){
         throw("not registered");
     }).catch(function(e){
         let a = e.toString();
         if(a === "not registered"){
             assert(false);
         }
         else{
             assert(true);
         }
     })
    });

});