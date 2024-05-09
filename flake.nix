{
  inputs = {
    nixpkgs.url = github:nixos/nixpkgs/nixos-unstable;
    home-manager = {
      url = github:nix-community/home-manager; 
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = github:nix-community/impermanence;
    
    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows ="nixpkgs";
    };


  };
  outputs = { self, nixpkgs, home-manager, impermanence, ... }@attrs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {

      nixosConfigurations = {
        nuc = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = attrs;

          
          modules = [
            impermanence.nixosModules.impermanence
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = attrs;
              home-manager.users.johannes = import ./home.nix;
            }
          ];
        };
      };
    };
}
