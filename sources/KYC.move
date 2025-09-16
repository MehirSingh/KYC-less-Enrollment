module MyModule::KyclessEnrollment {
    use aptos_framework::signer;
    use aptos_framework::timestamp;

    /// Error codes
    const E_ALREADY_ENROLLED: u64 = 1;
    const E_NOT_ENROLLED: u64 = 2;

    /// Struct representing user enrollment data
    struct EnrollmentRecord has store, key {
        enrolled_at: u64,      // Timestamp when user enrolled
        wallet_address: address, // User's wallet address
        is_active: bool,       // Enrollment status
    }

    /// Function to enroll a user using their wallet ownership
    /// Only the wallet owner can call this function for their address
    public fun enroll_user(user: &signer) {
        let user_address = signer::address_of(user);
        
        // Check if user is already enrolled
        assert!(!exists<EnrollmentRecord>(user_address), E_ALREADY_ENROLLED);
        
        // Create enrollment record
        let enrollment_record = EnrollmentRecord {
            enrolled_at: timestamp::now_seconds(),
            wallet_address: user_address,
            is_active: true,
        };
        
        // Store enrollment record under user's address
        move_to(user, enrollment_record);
    }

    /// Function to check if a user is enrolled and get their enrollment details
    /// Returns (is_enrolled, enrolled_at, is_active)
    public fun check_enrollment(user_address: address): (bool, u64, bool) acquires EnrollmentRecord {
        if (exists<EnrollmentRecord>(user_address)) {
            let enrollment_record = borrow_global<EnrollmentRecord>(user_address);
            (true, enrollment_record.enrolled_at, enrollment_record.is_active)
        } else {
            (false, 0, false)
        }
    }

    /// Helper function to verify if user is enrolled (for other modules to use)
    public fun is_user_enrolled(user_address: address): bool acquires EnrollmentRecord {
        if (exists<EnrollmentRecord>(user_address)) {
            let enrollment_record = borrow_global<EnrollmentRecord>(user_address);
            enrollment_record.is_active
        } else {
            false
        }
    }
}