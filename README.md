
Commands for NixOS:

Update flake
```bash
nix flake update [input-name]
```

Flake outputs:


## Formatting
Format repo:
```bash
nix fmt
```
Format a file: 
```bash
nix fmt <filename>
```

flake.nix outputs:
```nix
formatter.${system} = nixpkgs.legacyPackages.${system}.<formatter-app>;
```


## Run programs
Run program: 
```bash
nix run .#hello
```
Run program with args:
```bash
nix run .#hello -- --help
```

flake.nix outputs:
```nix
apps.${system}.hello = {
  type = "app";
  program = "${nixpkgs.legacyPackages.${system}.hello}/bin/hello";
};
```


## Develop
```nix
{
  outputs = { nixpkgs }:
  let
    pkgs = nixpkgs.legacyPackages.${system};
  in
  {
    # `nix develop .#dev`
    devShells.${system}.dev = pkgs.mkShell {
      NODE_ENV = "development";
      packages = [ pkgs.nodejs_24 ];
    };
  };
}
```
