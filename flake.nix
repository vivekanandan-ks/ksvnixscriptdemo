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
              pkgs.cowsay
              pkgs.lolcat
              pkgs.figlet
              pkgs.python312
              pkgs.nix
            ]}"
          ];
        }
        
        #script
        ''
          echo "Hello, myself!" | figlet | lolcat
          echo "You're a great person!" | cowsay | lolcat

          #python from script
          echo Your python version for this script is:
          python --version
          echo ---------------------
          #another version of python in a nested nix shell
          echo hello version is:
          ${pkgs.hello}/bin/hello --version
          echo
          echo again hello version is:
          hello --version
          echo echo Your another python version is:
          ${pkgs.python311}/bin/python --version
        '' ;
      
      in {

        packages.default = shell-app;   
      }
    );
}
