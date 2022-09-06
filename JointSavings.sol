pragma solidity ^0.5.0;

// Define a new contract named `JointSavings`
contract JointSavings {
    address payable accountOne;
    address payable accountTwo;
    address public lastToWithdraw;
    uint public lastWithdrawAmount;
    uint public contractBalance;
   
    /*
    Define a function named **withdraw** that will accept two arguments.
    - A `uint` variable named `amount`
    - A `payable address` named `recipient`
    */
        /*
        Define a `require` statement that checks if the `recipient` is equal to either `accountOne` or `accountTwo`. The `requiere` statement returns the text `"You don't own this account!"` if it does not.
        */
    function withdraw(uint amount, address payable recipient) public {
        require(recipient == accountOne || recipient == accountTwo, "You don't own this account!");
        require(address(this).balance >= amount, "Insufficient funds in contract!");
        if (lastToWithdraw != recipient) {
            lastToWithdraw = recipient;
        }
        
    
        // Call the `transfer` function of the `recipient` and pass it the `amount` to transfer as an argument.
        recipient.transfer(amount);

        // Set  `lastWithdrawAmount` equal to `amount`
        lastWithdrawAmount = amount;
    
        // Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance` to reflect the new balance of the contract.
        contractBalance = address(this).balance;
        
    }
    // Define a `public payable` function named `deposit`.
    function deposit() public payable {

        /*
        Call the `contractBalance` variable and set it equal to the balance of the contract by using `address(this).balance`.
        */
        contractBalance = address(this).balance;
    }

        /*
        Define a `public` function named `setAccounts` that receive two `address payable` arguments named `account1` and `account2`.
        */
        function setAccounts(address payable account1, address payable account2) public{

            // Set the values of `accountOne` and `accountTwo` to `account1` and `account2` respectively.
            accountOne = account1;
            accountTwo = account2;
        }

        /*
        Finally, add the **default fallback function** so that your contract can store Ether sent from outside the deposit function.
        */
        function() external payable {
            contractBalance = address(this).balance;
        }

    }
