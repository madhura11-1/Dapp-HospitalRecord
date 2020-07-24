App = {
  web3Provider: null,
  contracts: {},
  account: '0x0',

  init: function() {
    return  App.initWeb3();
  },

  initWeb3: function() {

    if(typeof web3 !== 'undefined'){
      App.web3Provider = web3.currentProvider;
      web3 = new Web3(web3.currentProvider);  
    }
    else{
      App.web3Provider = new Web3.providers.HttpProvider('http://localhost:7545');
      web3 = new Web3(App.web3Provider);
    }

    return App.initContract();
  },

  initContract: function() {

    $.getJSON("HospitalRecord.json",function(record){

      App.contracts.HospitalRecord = TruffleContract(record);
      App.contracts.HospitalRecord.setProvider(App.web3Provider);


      if(window.ethereum) {
        window.ethereum.on('accountsChanged', function () {
            web3.eth.getAccounts(function(error, accounts) {
              if(error == null){
                location.reload();
              }
            });
        });
    }
      return App.render();
    });

  },

  listenEvent : function(){

    App.contracts.HospitalRecord.deployed()
    .then(function(instance){
      instance.patientRegistered({},{
        fromBlock : 0,
        toBlock : 'latest'
      }).watch(function(error,event){
        alert(event);
        App.render();
      }); 
    });

  },

  render: function() {
    var recordInstance;
    var loader = $("#loader");
    var content = $("#content");
    content.hide();
    setTimeout(function(){
      loader.hide();
      content.show();
    },2000);
    
    web3.eth.getCoinbase(function(eror,account){

     if(eror == null){
       App.account = account;
       alert("Your account is : " + account);
     }
    });

    App.contracts.HospitalRecord.deployed()
    .then(function(instance){
       recordInstance = instance;
    })
    .catch(function(error){
      console.warn(error);
      alert("error");
    });
  },


  recordPatient: function(){
    var name = $("#name");
    var age = $("#age");
    var recordInstance;

    App.contracts.HospitalRecord.deployed()
    .then(function(instance){
       recordInstance = instance;
       return recordInstance.registerPatient(name.val(),age.val(),{from : App.account});
    })
    .then(function(receipt){
      alert(receipt.logs[0].event +"\n" + receipt.logs[0].args.id);
    })
    .catch(function(error){
      alert("You cannot register more than once"); 
    });
  },

  recordDoctor: function(){

    var name = $("#name2");
    var edu = $("#edu");
    var place = $("#place");
    var recordInstance;

    App.contracts.HospitalRecord.deployed()
    .then(function(instance){
       recordInstance = instance;
       return recordInstance.registerDoctor(name.val(),edu.val(),place.val(),{from : App.account});
    })
    .then(function(receipt){
      alert(receipt.logs[0].event +"\n" + receipt.logs[0].args.id + "\n" + receipt.logs[0].args._address + "\n" + receipt.logs[0].args.name);
    })
    .catch(function(error){
       //alert(error);
       alert("You cannot register more than once");
    });

  },

  recordDisease: function(){

    var disease = $("#disease");
    var recordInstance;

    App.contracts.HospitalRecord.deployed()
    .then(function(instance){
       recordInstance = instance;
       return recordInstance.addNewDisease(disease.val(),{from : App.account});
    })
    .then(function(event){
       alert("Recorded your disease update");
    })
    .catch(function(error){
       alert("You may not have access to this account");
    });

  },

  updateAge : function(){
    
   var updated_age = $("#update_age");

   App.contracts.HospitalRecord.deployed()
   .then(function(instance){
      recordInstance = instance;
      return recordInstance.updateAge(updated_age.val(),{from : App.account});
   })
   .then(function(event){
      alert("Recorded your age update");
   })
   .catch(function(error){
      alert("You may not have access to this account");
   });

  },

  showPatientbyOwn: function(){

    var show_id = $("#id_display");
    var show_name = $("#name_display");
    var show_age = $("#age_display");
    var show_disease = $("#disease_display");

    App.contracts.HospitalRecord.deployed()
    .then(function(instance){
      return instance.viewRecord({from : App.account});
    })
    .then(function(event){
      show_id.text(event[0]);
      show_name.text(event[2]);
      show_age.text(event[1]);
      show_disease.text(event[3]);
    })
    .catch(function(eror){
      alert("You may not have access to this account");
    });

  },

  showPatientbydoctor : function(){

    var id = $("#id");
    var show_id = $("#id_display");
    var show_name = $("#name_display");
    var show_age = $("#age_display");
    var show_disease = $("#disease_display");
    
    App.contracts.HospitalRecord.deployed()
    .then(function(instance){
      return instance.viewPatientbyDoctor(id.val(),{from : App.account});
    })
    .then(function(event){
        show_id.text(event[0]);
        show_name.text(event[2]);
        show_age.text(event[1]);
        show_disease.text(event[3]);
    })
    .catch(function(eror){
      alert("Either this id does not exist or you may not have access to the account");
    });


  },

  showDoctor: function(){

    var id = $("#id_d");
    var show_id = $("#id_display");
    var show_name = $("#name_display");
    var show_age = $("#age_display");
    var show_disease = $("#disease_display");
    App.contracts.HospitalRecord.deployed()
    .then(function(instance){
      return instance.viewDoctorById(id.val(),{from : App.account});
    })
    .then(function(event){
      show_id.text(event[0]);
      show_name.text(event[2]);
      show_age.text(event[1]);
      show_disease.text(event[3]);
    })
    .catch(function(eror){
      alert("Either this id does not exist or you may not have access to the account");
    });
    

  },

};

$(function() {
  $(window).load(function() {
    App.init();
  });
});
