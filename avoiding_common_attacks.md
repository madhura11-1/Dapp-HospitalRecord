Different Attacks and how my contract avoids them :

1. Denial of Service Attack : 
   This attack takes place when a huge amount of transactions are flooded into the contract anf the attacker then tries to take all the
   funds inside the contract.
   But my contract does not stores any kind of funds so this is avoided.

2. Re-entrancy attacks :
   Problematic because calling external contracts passes control flow to them. The called contract may take over the control flow and end up calling the smart contract function again in a recursive manner.
   My contract does not invlove calling any other external function from the contract so there is quite a less possibility of this attack.
   Also the contract does not store any ether.

3. Integer Overflow and Underflow : 
   Huge risk of integer overflow and underflow occurs when a contract has uint8, uint16 or lower involved.
   And if at any time this integer overflows or underflows they are reset to minimum or maximum values accordingly.
   To avoid this I am using uint256 in the contract and hope this wont overflow in future.
   Considering risk of underflow there are no such operations involving subtraction or division to underflow them beyond zero.
