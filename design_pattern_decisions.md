1. There is no such typical circuit breaker design pattern that I have implemented in my project because the idea did not
   require such a tough pattern to be implemented.
2. The smart contract which I have prepared does not have any ether involved or stored in it.
3. So I felt that there is no need for a hard or tough circuit breaker pattern.
4. But I have surely implemented a loose or weak circuit breaker pattern where in if some conditions are not met then the contract
   won't be proceeded further for that particular user(patient/doctor).
5. The main aim mostly for any contract breaker pattern is to keep safe the ethers stored into it.
6. But my contract does not involve any ether storage so minor circuit breakers are implemented by me.

7. Following are the design patterns I used :
   a. Making use of require statement so that only doctors can see any patient's record.
      No external user is allowed to see any patient's record for the safety.
   b. Making use of modifiers to allow patients to view their own record only.
      No patient can view other patients record.
   c. Any one can view a doctors record meaning his name, Id, Address of hospital as it is relevant for any user who wants 
      to visit that doctor to show this basic information 


Which patterns have I used ??

1. Circuit breaker : The contract does contain a weak circuit breaker pattern where not the entire contract is stopped but that user 
                     is being stopped from doing any further activities.

Why did not I use any other design patterns ??

1. Mortal Pattern : It is used when you want to destroy the contract and remove it from the blockchain.
                    It takes one parameter which is the address that will receive all of the funds that the contract currently holds.
 
   So for implementing this pattern you need a owner address and my contract has no owner as there are no separate controls required for a owner. So implementation of Mortal pattern was not useful.

2. Auto Deprecation : The auto deprecation design pattern is a useful strategy for closing contracts that should expire after a 
                       certain amount of time.

    This was also not required in my contract.
