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

1. Install npm package manager
2. Install truffle
3. Run 'truffle compile'
4. Open another terminal and start development blockchain by running 'truffle develop' in same directory
5. Then on first terminal run 'truffle test'
6. Then run 'truffle migrate --reset'
7. Then run 'npm run dev'. This will start the project in the browser
8. Make sure that your metamask is connected to the site (Import accounts from the truffle development blockchain into metamask)




