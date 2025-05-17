# 🛡️ Aptos Escrow Smart Contract - `VendorEscrow`

This project implements a simple **escrow system** on the Aptos blockchain using Move. It allows a buyer to deposit funds into an escrow, which can later be released to a vendor upon successful completion of a transaction.

---

## 📦 Module

**`EscrowModule::VendorEscrow`**

---

## 🚀 Features

- ✅ Buyers can initiate an escrow by depositing Aptos tokens (`APT`)
- ✅ Funds are locked in an `Escrow` struct under the buyer’s address
- ✅ Buyer can complete the transaction to release funds to the vendor
- 🔐 Basic status management to track escrow state (`Pending`, `Completed`, `Refunded`)
- ⚠️ Error handling for invalid states or unauthorized access

---


---

## 🧠 How It Works

### `create_escrow(buyer: &signer, vendor_address: address, amount: u64)`

- Called by the **buyer**
- Transfers `amount` of `APT` tokens from buyer
- Stores a new `Escrow` object under the buyer's address

### `complete_escrow(caller: &signer, buyer_address: address)`

- Called by the **buyer**
- Validates escrow is still `Pending`
- Transfers `APT` tokens to the vendor
- Updates the status to `Completed`

---

## 📜 Sample Deployment Commands

### Compile the module

```bash
aptos move compile
aptos move publish --profile default
'''

