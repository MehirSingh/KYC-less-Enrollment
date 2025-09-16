module MyModule::KyclessEnrollmentTest {
    use MyModule::KyclessEnrollment;
    use aptos_framework::signer;
    use std::debug;

    #[test]
    public fun test_enroll_and_check(user: &signer) {
        KyclessEnrollment::enroll_user(user);
        let user_address = signer::address_of(user);
        let (is_enrolled, enrolled_at, is_active) = KyclessEnrollment::check_enrollment(user_address);
        debug::print(&is_enrolled);
        debug::print(&enrolled_at);
        debug::print(&is_active);
        assert!(is_enrolled, 100);
        assert!(is_active, 101);
    }
}
