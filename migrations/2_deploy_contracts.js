var HospitalRecord = artifacts.require("./HospitalRecord.sol");

module.exports = function(deployer) {
  deployer.deploy(HospitalRecord);
};