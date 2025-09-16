# Copilot Instructions for KYC-less Move Project

## Project Overview
- This is a Move-based smart contract project for KYC-less enrollment, targeting the Aptos blockchain.
- Main module: `MyModule::KyclessEnrollment` (see `sources/KYC.move` and `build/KYC/sources/KyclessEnrollment.move`).
- The project manages user enrollment using wallet ownership, storing enrollment records on-chain.

## Architecture & Key Components
- **Modules:**
  - `KyclessEnrollment`: Handles user enrollment, status checks, and exposes helper functions for other modules.
  - Dependencies: Uses Aptos Framework, AptosStdlib, and MoveStdlib (see `Move.toml` and `build/KYC/sources/dependencies/`).
- **Data Flow:**
  - Users enroll by calling `enroll_user` with their signer; enrollment data is stored in `EnrollmentRecord` under their address.
  - Enrollment status and details can be queried via `check_enrollment` and `is_user_enrolled`.

## Developer Workflows
- **Build:**
  - Use Move CLI or Aptos CLI to build modules. Example:
    ```powershell
    move compile --package-dir .
    # or
    aptos move compile --package-dir .
    ```
  - Output artifacts are in `build/KYC/bytecode_modules/` and `build/KYC/source_maps/`.
- **Test:**
  - No test scripts found; add tests in `tests/` using Move's test framework.
- **Deploy:**
  - Use Aptos CLI for deployment. Example:
    ```powershell
    aptos move publish --package-dir . --profile <profile>
    ```
- **Debug:**
  - Use source maps in `build/KYC/source_maps/` for debugging.

## Conventions & Patterns
- **Module Address:**
  - Main module address is set in `Move.toml` under `[addresses]` as `MyModule`.
- **Error Handling:**
  - Error codes are defined as constants in modules (e.g., `E_ALREADY_ENROLLED`, `E_NOT_ENROLLED`).
- **Structs:**
  - Enrollment data is stored in structs with `store, key` abilities.
- **Access Control:**
  - Only wallet owners can enroll themselves (checked via signer).
- **Dependencies:**
  - External modules are imported from Aptos Framework and Stdlib directories.

## Integration Points
- **Aptos Framework:**
  - Core functionality (signer, timestamp, account management) is imported from Aptos modules.
- **Source Maps & Bytecode:**
  - Source maps and bytecode are generated for each module and dependency for debugging and deployment.

## Examples
- **Enroll User:**
  ```move
  public fun enroll_user(user: &signer) { ... }
  ```
- **Check Enrollment:**
  ```move
  public fun check_enrollment(user_address: address): (bool, u64, bool) acquires EnrollmentRecord { ... }
  ```

## Key Files & Directories
- `sources/KYC.move`: Main module source
- `build/KYC/sources/`: Compiled sources and dependencies
- `build/KYC/bytecode_modules/`: Compiled bytecode
- `build/KYC/source_maps/`: Source maps for debugging
- `Move.toml`: Project config and dependencies

---
If any section is unclear or missing, please provide feedback for further refinement.