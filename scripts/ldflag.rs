// Cargo pre-build script.
// Running `cargo build` executes this script before the actual build.


fn main() -> std::io::Result<()> {
    // Tell cargo to add linker script flag to rustc invocation.
    println!("cargo:rustc-link-arg=-Tscripts/linker.ld");

    Ok(())
}
