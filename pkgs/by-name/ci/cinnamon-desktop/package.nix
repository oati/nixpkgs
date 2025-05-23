{
  fetchFromGitHub,
  gdk-pixbuf,
  gobject-introspection,
  gtk3,
  intltool,
  isocodes,
  meson,
  ninja,
  pkg-config,
  pulseaudio,
  python3,
  lib,
  stdenv,
  systemd,
  xkeyboard_config,
  xorg,
  wrapGAppsHook3,
  glib,
}:

stdenv.mkDerivation rec {
  pname = "cinnamon-desktop";
  version = "6.4.1";

  src = fetchFromGitHub {
    owner = "linuxmint";
    repo = "cinnamon-desktop";
    rev = version;
    hash = "sha256-YKGVuT28MLcLO9T8ZJqbHqMN0SAn1P1l8JTDBo4n838=";
  };

  outputs = [
    "out"
    "dev"
  ];

  propagatedBuildInputs = [
    glib
    gtk3
    pulseaudio
  ];

  buildInputs = [
    gdk-pixbuf
    isocodes
    systemd
    xkeyboard_config
    xorg.libxkbfile
    xorg.libXext
    xorg.libXrandr
  ];

  nativeBuildInputs = [
    meson
    ninja
    python3
    wrapGAppsHook3
    intltool
    pkg-config
    gobject-introspection
  ];

  postPatch = ''
    chmod +x install-scripts/meson_install_schemas.py # patchShebangs requires executable file
    patchShebangs install-scripts/meson_install_schemas.py
    sed "s|/usr/share|/run/current-system/sw/share|g" -i ./schemas/* # NOTE: unless this causes a circular dependency, we could link it to cinnamon-common/share/cinnamon
  '';

  meta = with lib; {
    homepage = "https://github.com/linuxmint/cinnamon-desktop";
    description = "Library and data for various Cinnamon modules";

    longDescription = ''
      The libcinnamon-desktop library provides API shared by several applications
      on the desktop, but that cannot live in the platform for various
      reasons. There is no API or ABI guarantee, although we are doing our
      best to provide stability. Documentation for the API is available with
      gtk-doc.
    '';

    license = [
      licenses.gpl2
      licenses.lgpl2
    ];
    platforms = platforms.linux;
    teams = [ teams.cinnamon ];
  };
}
