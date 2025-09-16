# KYC-less Enrollment Smart Contract

A simple Aptos Move smart contract that enables user enrollment through wallet ownership verification without requiring traditional KYC (Know Your Customer) processes.

## Overview

This smart contract allows users to enroll in a system by simply proving ownership of their wallet address through transaction signing. It eliminates the need for complex identity verification while maintaining security through cryptographic wallet ownership proof.

## Features

- **KYC-less Enrollment**: No personal information required
- **Wallet Ownership Verification**: Uses Aptos signer mechanism for secure authentication  
- **Duplicate Prevention**: Prevents multiple enrollments from same address
- **Public Verification**: Anyone can check enrollment status
- **Timestamp Tracking**: Records enrollment time for audit purposes
- **Active Status Management**: Tracks enrollment state

## Contract Structure

### Data Structure
```move
struct EnrollmentRecord {
    enrolled_at: u64,      // Unix timestamp of enrollment
    wallet_address: address, // User's wallet address  
    is_active: bool,       // Current enrollment status
}
```

### Core Functions

#### 1. `enroll_user(user: &signer)`
- **Purpose**: Enrolls a user using their wallet signature
- **Access**: Only callable by wallet owner
- **Security**: Automatic ownership verification through signer
- **Error Handling**: Prevents duplicate enrollments

#### 2. `check_enrollment(user_address: address): (bool, u64, bool)`
- **Purpose**: Verifies enrollment status and returns details
- **Returns**: 
  - `bool`: Whether user is enrolled
  - `u64`: Enrollment timestamp
  - `bool`: Active status
- **Access**: Public function, callable by anyone

### Helper Function
- `is_user_enrolled(address): bool` - Quick enrollment status check

## Usage Examples

### Enrolling a User
```move
// User calls this function to enroll themselves
public entry fun enroll_me(user: &signer) {
    KyclessEnrollment::enroll_user(user);
}
```

### Checking Enrollment Status
```move
// Check if address is enrolled
let (is_enrolled, timestamp, is_active) = KyclessEnrollment::check_enrollment(@0x123);

// Quick status check
let enrolled = KyclessEnrollment::is_user_enrolled(@0x123);
```

## Error Codes

- `E_ALREADY_ENROLLED (1)`: User attempting to enroll when already enrolled
- `E_NOT_ENROLLED (2)`: Reserved for future use

## Security Model

### Advantages
- **No Personal Data Storage**: Only wallet addresses are stored
- **Cryptographic Security**: Relies on Aptos's proven signature verification
- **Decentralized**: No central authority required for enrollment
- **Transparent**: All enrollments are publicly verifiable

### Considerations
- **Sybil Resistance**: One enrollment per wallet address
- **Wallet Security**: Users must maintain wallet security
- **Address Reuse**: Consider implications of address reuse

## Deployment

1. **Compile**: Use Aptos CLI to compile the Move contract
2. **Deploy**: Deploy to desired Aptos network (devnet/testnet/mainnet)
3. **Initialize**: No initialization required - contract is ready to use

## Integration

Other smart contracts can integrate with this enrollment system:

```move
// Example: Restrict function to enrolled users only
public fun restricted_function(user: &signer) {
    let user_addr = signer::address_of(user);
    assert!(KyclessEnrollment::is_user_enrolled(user_addr), E_NOT_ENROLLED);
    // Function logic here...
}
```

## Use Cases

- **DeFi Protocols**: User onboarding without identity verification
- **DAOs**: Membership enrollment for governance
- **Gaming Platforms**: Player registration systems  
- **Airdrops**: Eligibility tracking for token distributions
- **Access Control**: Gated content or feature access

## Technical Requirements

- **Aptos Framework**: Uses standard Aptos libraries
- **Move Language**: Written in Move for Aptos blockchain
- **Dependencies**: 
  - `aptos_framework::signer`
  - `aptos_framework::timestamp`

## Contract Specifications

- **Lines of Code**: 43 lines
- **Functions**: 2 main functions + 1 helper
- **Storage**: Minimal on-chain storage per user
- **Gas Efficiency**: Optimized for low transaction costs

## Future Enhancements

- **Enrollment Expiry**: Time-based enrollment validity
- **Multi-signature Support**: Support for multi-sig wallets
- **Bulk Operations**: Batch enrollment checking
- **Event Emission**: Emit events for enrollment activities
- **Admin Functions**: Administrative controls if needed

## License

This smart contract is provided as-is for educational and development purposes. Please review and test thoroughly before production use.

## transaction
0xd273a881b94a2f739efe199c26e15de1db5c0c6bb5bfadf0922c0cf38f2b0f47
<img width="1920" height="1080" alt="Screenshot (39)" src="https://github.com/user-attachments/assets/9fec2e39-ad09-4887-9301-8af42ffe5c9a" />
