{
  description = "Application packaged using poetry2nix";

  inputs.flake-utils.url = "github:numtide/flake-utils";
  inputs.nixpkgs.url = "github:NixOS/nixpkgs";
  inputs.poetry2nix = {
    url = "github:nix-community/poetry2nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, flake-utils, poetry2nix }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        # see https://github.com/nix-community/poetry2nix/tree/master#api for more functions and examples.
        inherit (poetry2nix.legacyPackages.${system})
          mkPoetryEnv mkPoetryPackages defaultPoetryOverrides overrides;
        # import some helper functions
        inherit (nixpkgs.lib.attrsets) genAttrs getAttrs;
        pkgs = nixpkgs.legacyPackages.${system};
        # Overrides go here:
        /* customOverrides = self: super:
           let
             addToPyAttrs = ls: p:
               super.${p}.overridePythonAttrs
               (old: { buildInputs = (old.buildInputs or [ ]) ++ ls; });
             # (old: getAttrs [ "buildInputs" ] old // { buildInputs = ls; });
           in genAttrs [ "seaborn" ] (addToPyAttrs [ super.certifi ])
           // genAttrs [ "torch-geometric" ] (addToPyAttrs [ super.setuptools ])
           // genAttrs [ "torch-sparse" ]
           (addToPyAttrs [ super.setuptools super.torch ]) // {
             llvmlite = pkgs.python310Packages.llvmlite;
           };
        */
        devEnv = mkPoetryEnv {
          projectDir = self;
          preferWheels = true;
          # overrides = [ defaultPoetryOverrides customOverrides ];
          python = pkgs.python310;
        };
        myPkg = mkPoetryPackages {
          projectDir = self;
          preferWheels = true;
          # overrides = [ defaultPoetryOverrides customOverrides ];
          python = pkgs.python310;
        };
      in {
        defaultPackage = {
          inherit myPkg;
          ${system} = myPkg;
          # default = self.packages.${system}.myPkg;
          default = myPkg;
        };

        devShells.default = pkgs.mkShell {
          packages = [
            poetry2nix.packages.${system}.poetry
            devEnv
            #
          ];
        };
      });
}
