{ pkgs, inputs, lib, config, ... }:

let
  pkgs-stable = import inputs.nixpkgs-stable { system = pkgs.stdenv.system; };

  python = pkgs-stable.python3;
  python-pkgs = with python.pkgs; [
    # PyQt 5
    pyqt5
    pyqt5_sip

    # PySide 6
    pyside6
    shiboken6
  ];

  useQt6 = true;

  qApp = if useQt6 then
    (with pkgs-stable.qt6Packages; {
      QT_API = "pyside6";
      QT_PLUGIN_PATH = null;
      QML_IMPORT_PATH = null;
      GTK_PATH = with pkgs-stable; "${libcanberra-gtk3}/lib";

      packages = [
        pkgs-stable.qgnomeplatform-qt6
        pkgs-stable.gtk3
        qtbase
        qtwayland
        qtdeclarative
      ];
    })
  else
    (with pkgs-stable.qt5; {
      QT_API = "pyqt5";
      QT_PLUGIN_PATH = "${config.env.DEVENV_PROFILE}/${qtbase.qtPluginPrefix}";
      QML_IMPORT_PATH = "${config.env.DEVENV_PROFILE}/${qtbase.qtQmlPrefix}";
      LD_LIBRARY_PATH = null;

      packages =
        [ pkgs-stable.adwaita-qt5 qtbase qtwayland qtx11extras qtdeclarative ];
    });

in {
  env = {
    inherit (qApp) QT_API QT_PLUGIN_PATH QML_IMPORT_PATH GTK_PATH;

    QT_QPA_PLATFORM = "xcb";
    QT_QPA_PLATFORMTHEME = "gnome";

    PYTHONPATH = lib.concatMapStringsSep ":" (p: "${p}/${python.sitePackages}")
      python-pkgs;
  };

  languages.python = {
    enable = true;
    poetry.enable = true;
  };

  packages = qApp.packages;
}
