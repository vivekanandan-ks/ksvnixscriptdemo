{
  description = "flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... } @ inputs:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        shell-app = pkgs.writers.writeBashBin       
        #app name
        "mybashshellapp"

        #extra arguments
        {
          makeWrapperArgs = [
            "--prefix" "PATH" ":" "${pkgs.lib.makeBinPath [
              #add dependencies here
              
            ]}"
          ];
        }
        #script without shebang
        ''

        '' ;
      
      in {

        packages.default = shell-app;   
      }
    );
}
