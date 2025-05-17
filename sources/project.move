module EscrowModule::VendorEscrow {
    use aptos_framework::signer;
    use aptos_framework::coin;
    use aptos_framework::aptos_coin::AptosCoin;
    use std::error;
    
    /// Error codes
    const ESCROW_NOT_FOUND: u64 = 1;
    const INVALID_STATE: u64 = 2;
    const UNAUTHORIZED: u64 = 3;
    
    /// Escrow status enum
    const STATUS_PENDING: u8 = 0;
    const STATUS_COMPLETED: u8 = 1;
    const STATUS_REFUNDED: u8 = 2;
    
    /// Struct representing an escrow arrangement
    struct Escrow has store, key {
        buyer: address,
        vendor: address,
        amount: u64,
        status: u8,
    }
    
    /// Create a new escrow by depositing funds
    public entry fun create_escrow(
        buyer: &signer, 
        vendor_address: address, 
        amount: u64
    ) {
        let buyer_address = signer::address_of(buyer);
        
        // Transfer funds from buyer to the contract
        let payment = coin::withdraw<AptosCoin>(buyer, amount);
        coin::deposit(buyer_address, payment);
        
        // Create and store the escrow object
        let escrow = Escrow {
            buyer: buyer_address,
            vendor: vendor_address,
            amount,
            status: STATUS_PENDING,
        };
        
        move_to(buyer, escrow);
    }
    
    /// Complete the escrow, releasing funds to the vendor
    public entry fun complete_escrow(
        caller: &signer,
        buyer_address: address
    ) acquires Escrow {
        let caller_address = signer::address_of(caller);
        
        // Get the escrow data
        assert!(exists<Escrow>(buyer_address), error::not_found(ESCROW_NOT_FOUND));
        let escrow = borrow_global_mut<Escrow>(buyer_address);
        
        // Verify the caller is the buyer
        assert!(caller_address == escrow.buyer, error::permission_denied(UNAUTHORIZED));
        assert!(escrow.status == STATUS_PENDING, error::invalid_state(INVALID_STATE));
        
        // Transfer funds to vendor
        let payment = coin::withdraw<AptosCoin>(caller, escrow.amount);
        coin::deposit(escrow.vendor, payment);
        
        // Update escrow status
        escrow.status = STATUS_COMPLETED;
    }
}