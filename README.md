# Dapp-HospitalRecord

A decentralized application to manage your hospital records with no burden to carry all the files that we do usually.
This system proposes an idea to keep your hospital record safe on the distibuted ledger without anyone to change or modify it.
There are two types of users involved into this system : 1. Doctor
                                                         2. Patient
        
The doctor has to first register himself through the platform and then he is given a role as Doctor only then he will be able to access the patients records.
Basic information of the doctor like Name,Degree and Hospital address are used for registration of the doctor.

The Patient also has to first register through the platfrom only then he will be able to consult from a doctor.
Basic information like Name,Age,etc are used for registration of patient.
The patient can add his diseases one by one into his record through the system/platform.

Once registered both the patient as well as the doctor is assigned a unique ID. Through this ID the doctor/patient can be searched.

Though this project any user can register himself as a Patient and hence whenever he needs to visit the hospital there wont be any need to carry all such files.
The only thing needed is a ID to get the details of the patient throug this platfrom.
This wasy Patient's records will also be safe.

The project is a truffle project and runs on local host.
To run this project :

1. Install npm package manager and node : `sudo apt install nodejs` , `sudo apt install npm`
2. Install truffle : `npm install -g truffle`
3. Install Ganache : https://www.trufflesuite.com/ganache
4. Run `truffle compile` from the project directory in terminal
5. Start the Ganache and choose `Quickstart Ethereum`
6. Make sure that the local host url on Ganache and in `truffle-config.js` is same.
6. Then on terminal run `truffle test`
6. Then run `truffle migrate --reset`
7. Then run `npm run dev`. This will start the project in the browser
8. Make sure that your metamask is connected to the site (Import accounts from Ganache blockchain into metamask).

Other features that can be added into the project : 
1.To verify the doctor you can store the certificate on the IPFS and store its has in the smart contract.
2. Same for patient, The patients documents can be stored on IPFS and its hash can be included into the smart contract.




