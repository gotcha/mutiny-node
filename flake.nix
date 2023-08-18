{
  description = "htmx wasm-service";

  # Flake inputs
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs"; # also valid: "nixpkgs"
    rust-overlay.url = "github:oxalica/rust-overlay";
  };

  # Flake outputs
  outputs = { self, nixpkgs, rust-overlay }:
    let
      # Systems supported
      allSystems = [
        "x86_64-linux" # 64-bit Intel/AMD Linux
        "aarch64-linux" # 64-bit ARM Linux
        "x86_64-darwin" # 64-bit Intel macOS
        "aarch64-darwin" # 64-bit ARM macOS
      ];

      # Helper to provide system-specific attributes
      forAllSystems = f: nixpkgs.lib.genAttrs allSystems (system: f {
          pkgs = import nixpkgs {
            inherit system;
            overlays = [
              rust-overlay.overlay
              (self: super: {
                # Because rust-overlay bundles multiple rust packages into one
                # derivation, specify that mega-bundle here, so that crate2nix
                # will use them automatically.
                rustc = self.rust-bin.stable.latest.default;
                cargo = self.rust-bin.stable.latest.default;
              })
            ];
          };
      });
    in
    {
      rust = forAllSystems ({ pkgs }: {
        default = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
      });

      # Development environment output
      devShells = forAllSystems ({ pkgs }: {
        default =
          let
            # Use Python 3.11
            rust = pkgs.rust-bin.fromRustupToolchainFile ./rust-toolchain.toml;
          in
          pkgs.mkShell {
            # The Nix packages provided in the environment
            packages = [
              rust
            ];
          };
      });
    };
}
