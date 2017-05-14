pragma solidity ^0.4.8;
//import "github.com/Arachnid/solidity-stringutils/strings.sol";

// string comparison problem

contract trade {
    address  public owner;
    address public buyer;
    address public authority;
    uint public product_serial;
    string public state="nothing";
    uint public price;
    uint public authority_pk=0;
    uint public buyer_pk=0;
    uint public amount_paid=0;
    uint public quantity=0;
    string a="released";
    
    /* function trade(){
        owner=msg.sender;
    } */
    
 function trade(address authority_add,address buyer_add, uint p,uint q) {
    owner = msg.sender;
    //product_serial=serial;
    price=p;
    authority=authority_add;
    buyer=buyer_add;
    quantity=q;
  } 
  modifier onlyseller{
		if (msg.sender != owner){
			throw;
		}else{
			_;
		}
	}
	modifier onlybuyer{
		if (msg.sender != buyer){
			throw;
		}else{
			_;
		}
	}
	modifier onlyauthority{
		if (msg.sender != authority){
			throw;
		}else{
			_;
		}
	}
  
  
  function product_state(string s) onlyseller  returns(bool)
  {    
      // uint n= a.localeCompare(s);
     if ( sha3(s) != sha3("released") && sha3(state) !=sha3("released") )
     {
         state=s;
         return true;   
     }
     else{
         return false;
     }
      
		
		
  }
  function conformation_buyer() onlybuyer returns (bool)
  {
      if(amount_paid<price)
      {
          return false;
      }
      else
      {
      buyer_pk=1;
      return true;
      }
  }
  function conformation_aothority() onlyauthority returns (bool)
  {
      if(amount_paid<price)
      {
          return false;
      }
      else
      {
      authority_pk=1;
      return true;
     }
      
  }
  
  
  function release_fund() returns (bool)
  {
 
      if(authority_pk==1)
      {
          if(buyer_pk==1)
          {
             state="released";
             owner.transfer(price);
             uint remaining_amount=0;
             remaining_amount=amount_paid-price;
             if(remaining_amount>0)
             {
                 buyer.transfer(remaining_amount);
                 return true;
             }
             }
             
      }
      return false;
     
  }
  function pay() payable{
        amount_paid= amount_paid+msg.value;
        
    }
  
  
  
  
}
