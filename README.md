Aptos Escrow-Based Vendor Payout Smart Contract
Overview
This project implements a simple yet secure escrow-based vendor payout system on the Aptos blockchain. The smart contract facilitates transactions between buyers and vendors by holding funds in escrow until specified conditions are met, providing security and trust for both parties.
Features

Secure Escrow System: Safely holds funds until transaction conditions are satisfied
Simple Interface: Only two core functions for creating and completing escrows
Compact Implementation: Lightweight contract (45 lines) for efficient deployment and gas usage
Status Tracking: Monitors the state of each escrow arrangement

Smart Contract Structure
The contract consists of the following key components:
Escrow Structure
movestruct Escrow has store, key {
    buyer: address,
    vendor: address,
    amount: u64,
    status: u8,
}
Status Constants

STATUS_PENDING: Escrow has been created but not yet completed
STATUS_COMPLETED: Escrow transaction has been successfully completed
STATUS_REFUNDED: Escrow has been refunded (implementation placeholder)

Functions

create_escrow

Creates a new escrow arrangement between buyer and vendor
Locks buyer's funds in the contract until conditions are met
Parameters:

buyer: Signer reference for the buyer
vendor_address: Address of the vendor to receive payment
amount: Amount of AptosCoin to be held in escrow




complete_escrow

Releases funds to the vendor when called by the buyer
Marks the escrow as completed
Parameters:

caller: Signer reference for the caller (must be the buyer)
buyer_address: Address where the escrow is stored





How to Use
Prerequisites

Aptos CLI installed
An Aptos account with sufficient APT tokens

Deployment

Compile the module:

bashaptos move compile --named-addresses EscrowModule=<YOUR_ADDRESS>

Publish the module:

bashaptos move publish --named-addresses EscrowModule=<YOUR_ADDRESS>
Creating an Escrow
bashaptos move run --function-id <YOUR_ADDRESS>::VendorEscrow::create_escrow \
  --args address:<VENDOR_ADDRESS> u64:<AMOUNT>
Completing an Escrow (as buyer)
bashaptos move run --function-id <YOUR_ADDRESS>::VendorEscrow::complete_escrow \
  --args address:<BUYER_ADDRESS>
Security Considerations

The contract implements basic authorization checks to ensure only appropriate parties can perform actions
Error handling is implemented for common failure cases
Funds are securely managed using Aptos's native coin module

Future Enhancements
Potential improvements for future versions:

Add refund functionality for buyers
Implement arbitration for dispute resolution
Add time-based automatic completion or refund
Support for multiple token types beyond AptosCoin

License
MIT License
Disclaimer
This code is provided as a reference implementation. It has not been audited for production use. Use at your own risk.
