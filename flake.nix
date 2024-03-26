{
  inputs.nixpkgs.url = "nixpkgs/nixos-23.11-small";

  outputs = { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };

      app = pkgs.python3Packages.buildPythonApplication {
        pname = "primecalc";
        version = "0.1.0";
        format = "pyproject";

        src = ./.;

        nativeBuildInputs = with pkgs; [
          python3Packages.poetry-core
          qt6Packages.wrapQtAppsHook
        ];

        propagatedBuildInputs = (with pkgs.python3Packages; [
          qtpy
          pyside6
          shiboken6
        ]) ++ (with pkgs.qt6Packages; [
          qtbase
          qtdeclarative
        ]);
      };

    in {
      packages.${system}.default = app;

      formatter.${system} = pkgs.nixfmt;
    };
}
