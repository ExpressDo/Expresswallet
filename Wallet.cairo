// Wallet Contract

// Define the contract
contract Wallet:

    // State variables
    owner: address
    balance: Uint128

    // Event to log deposits
    Deposit: event({from: indexed(address), amount: uint128})

    // Event to log withdrawals
    Withdrawal: event({to: indexed(address), amount: uint128})

    // Initialize the wallet contract
    init():
        owner = msg.sender
        balance = 0

    // Function to deposit funds into the wallet
    function deposit() payable:
        // Ensure only the owner can deposit funds
        require(msg.sender == owner, "Unauthorized")

        // Update the wallet balance
        balance = add(balance, msg.value)

        // Log the deposit event
        log Deposit({from: msg.sender, amount: msg.value})

    // Function to withdraw funds from the wallet
    function withdraw(amount: Uint128):
        // Ensure only the owner can withdraw funds
        require(msg.sender == owner, "Unauthorized")

        // Ensure sufficient balance for withdrawal
        require(balance >= amount, "Insufficient funds")

        // Update the wallet balance
        balance = sub(balance, amount)

        // Transfer funds to the owner
        send(owner, amount)

        // Log the withdrawal event
        log Withdrawal({to: msg.sender, amount: amount})

    // Function to check the wallet balance
    function getBalance() -> (Uint128):
        return balance

// Utility function to add two Uint128 values
function add(a: Uint128, b: Uint128) -> (Uint128):
    return a + b

// Utility function to subtract two Uint128 values
function sub(a: Uint128, b: Uint128) -> (Uint128):
    require(a >= b, "Subtraction overflow")
    return a - b
