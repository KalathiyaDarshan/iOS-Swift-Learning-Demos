class BankAccount {
    private var accountNumber: String
    private var balance: Double
    
    init(accountNumber: String, initialBalance: Double) {
        self.accountNumber = accountNumber
        self.balance = initialBalance
    }
    
    func deposit(amount: Double) {
        if amount > 0 {
            balance += amount
            print("Deposited \(amount) units.")
        } else {
            print("Invalid deposit amount.")
        }
    }
    
    func withdraw(amount: Double) {
        if amount > 0 && amount <= balance {
            balance -= amount
            print("Withdrew \(amount) units.")
        } else {
            print("Insufficient funds or invalid withdrawal amount.")
        }
    }
    
    func getBalance() -> Double {
        return balance
    }
}

// Example usage:
let account = BankAccount(accountNumber: "123456789", initialBalance: 1000.0)
print("Initial balance: \(account.getBalance())")

account.deposit(amount: 500.0)
print("Current balance after deposit: \(account.getBalance())")

account.withdraw(amount: 200.0)
print("Current balance after withdrawal: \(account.getBalance())")

class bankdata
{
    private var userid: String
    private var accountno: Int
    var amount: Double

    init(userid: String, accountno: Int,amount : Double) {
        self.userid = userid
        self.accountno = accountno
        self.amount = amount
    }
   
    func Showdetails()
    {
        print("User id: \(userid)")
        print("Account No: \(accountno)")
        print("Amount: \(amount)")
    }
    
}
let account1 = bankdata(userid: "Sahil123", accountno: 43344555555333, amount: 1000.0)
account1.Showdetails()

class Bank: bankdata {
    func showDetailsWithAmount() {
        print("Amount: \(amount)")
    }
}

let account2 = Bank(userid:"Darshan122", accountno:1233344, amount: 500.0)
account2.Showdetails()
account2.showDetailsWithAmount()