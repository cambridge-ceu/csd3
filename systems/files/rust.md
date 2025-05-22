To install Rust's nightly toolchain to `$CEUADMIN/rust/nightly`, without requiring root privileges. This is achieved by setting the `CARGO_HOME` and `RUSTUP_HOME` environment variables before running the `rustup` installer.([Stack Overflow][1])

---

### ✅ Step-by-Step Guide to Install Rust Nightly to a Custom Directory

1. **Set Environment Variables**

   Define the `CARGO_HOME` and `RUSTUP_HOME` environment variables to specify the installation directories:

   ```bash
   export CARGO_HOME="$CEUADMIN/rust/nightly/cargo"
   export RUSTUP_HOME="$CEUADMIN/rust/nightly/rustup"
   ```

   The PATH variable is pointed in

   ```
   /home/jhz22/.profile
   /home/jhz22/.bash_profile
   /home/jhz22/.bashrc
   ```

This configuration ensures that Rust's components are installed within the specified directory.

2. **Run the `rustup` Installer**

   Execute the following command to install Rust using the environment variables you've set:

   ```bash
   curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
   ```



During the installation, you can choose the default installation option. The installer will place Rust's binaries in `$CARGO_HOME/bin`, and the toolchains in `$RUSTUP_HOME`.

3. **Update Your Shell Configuration**

   To make the Rust binaries accessible, add the following line to your shell's configuration file (e.g., `~/.bashrc` or `~/.zshrc`):

   ```bash
   export PATH="$CARGO_HOME/bin:$PATH"
   ```



This ensures that the Rust commands (`cargo`, `rustc`, etc.) are available in your shell session.

4. **Install the Nightly Toolchain**

   With the environment variables set and the PATH updated, install the nightly toolchain:

   ```bash
   rustup toolchain install nightly
   ```



This command installs the latest nightly version of Rust into the directory you've specified.

5. **Set the Nightly Toolchain as Default (Optional)**

   If you wish to use the nightly toolchain by default, run:

   ```bash
   rustup default nightly
   ```



This sets the nightly toolchain as the default for your user account.

---

### ✅ Verifying the Installation

To confirm that Rust has been installed correctly, check the installed version of `rustc`:

```bash
rustc --version
```



This should display the version of `rustc` installed by `rustup`.

---

By following these steps, you'll have the nightly version of Rust installed in a custom directory without requiring administrative privileges.

If you encounter any issues during the installation process or need further assistance, feel free to ask!

[1]: https://stackoverflow.com/questions/46739842/where-does-rustup-install-itself-to?utm_source=chatgpt.com "rust - Where does rustup install itself to? - Stack Overflow"
