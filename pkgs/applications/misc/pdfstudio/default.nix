# For upstream versions, download links, and change logs see https://www.qoppa.com/pdfstudio/versions
#
# PDF Studio license is for a specific year, so we need different packages for different years.
# All versions of PDF Studio Viewer are free, so we package only the latest year.
# Thus, packages are pdfstudioviewer, pdfstudio2021, pdfstudio2022, etc.
# Variables:
# - program is either "pdfstudio" or "pdfstudioviewer", defaults to "pdfstudio".
# - year identifies the year portion of the version, defaults to most recent year.
# - pname is either "pdfstudio${year}" or "pdfstudioviewer".

{
  lib,
  stdenv,
  program ? "pdfstudio",
  year ? "2024",
  fetchurl,
  callPackage,
  jdk11,
  jdk17,
}:
let
  longDescription = ''
    PDF Studio is an easy to use, full-featured PDF editing software. This is the standard/pro edition, which requires a license. For the free PDF Studio Viewer see the package pdfstudioviewer.
  '';
  pname = if (program == "pdfstudio") then "${program}${year}" else program;
  desktopName = if (program == "pdfstudio") then "PDF Studio ${year}" else "PDF Studio Viewer";
  dot2dash = str: builtins.replaceStrings [ "." ] [ "_" ] str;
in
{
  pdfstudioviewer = callPackage ./common.nix rec {
    inherit
      desktopName
      pname
      program
      year
      ;
    version = "${year}.0.1";
    longDescription = ''
      PDF Studio Viewer is an easy to use, full-featured PDF editing software. This is the free edition. For the standard/pro edition, see the package pdfstudio.
    '';
    src = fetchurl {
      url = "https://web.archive.org/web/20241201121627/https://download.qoppa.com/pdfstudioviewer/PDFStudioViewer_linux64.deb";
      hash = "sha256-hxReGuyGsBiEr7wWxWzQUQvxk11sgF9HkJ07L9i+e+0=";
    };
    jdk = jdk17;
  };

  pdfstudio2021 = callPackage ./common.nix rec {
    inherit
      desktopName
      longDescription
      pname
      program
      year
      ;
    version = "${year}.2.2";
    src = fetchurl {
      url = "https://download.qoppa.com/pdfstudio/v${year}/PDFStudio_v${dot2dash version}_linux64.deb";
      hash = "sha256-HdkwRMqwquAaW6l3AukGReFtw2f5n36tZ8vXo6QiPvU=";
    };
    extraBuildInputs = [
      (lib.getLib stdenv.cc.cc) # for libstdc++.so.6 and libgomp.so.1
    ];
    jdk = jdk11;
  };

  pdfstudio2022 = callPackage ./common.nix rec {
    inherit
      desktopName
      longDescription
      pname
      program
      year
      ;
    version = "${year}.2.5";
    src = fetchurl {
      url = "https://download.qoppa.com/pdfstudio/v${year}/PDFStudio_v${dot2dash version}_linux64.deb";
      hash = "sha256-3faZyWUnFe//S+gOskWhsZ6jzHw67FRsv/xP77R1jj4=";
    };
    extraBuildInputs = [
      (lib.getLib stdenv.cc.cc) # for libstdc++.so.6 and libgomp.so.1
    ];
    jdk = jdk17;
  };

  pdfstudio2023 = callPackage ./common.nix rec {
    inherit
      desktopName
      longDescription
      pname
      program
      year
      ;
    version = "${year}.0.4";
    src = fetchurl {
      url = "https://download.qoppa.com/pdfstudio/v${year}/PDFStudio_v${dot2dash version}_linux64.deb";
      hash = "sha256-TTh0yzpCOpxFKGfrakvnu1Y+l9NI0nfWlVuvSWpkRkE=";
    };
    extraBuildInputs = [
      (lib.getLib stdenv.cc.cc) # for libstdc++.so.6 and libgomp.so.1
    ];
    jdk = jdk17;
  };

  pdfstudio2024 = callPackage ./common.nix rec {
    inherit
      desktopName
      longDescription
      pname
      program
      year
      ;
    version = "${year}.0.1";
    src = fetchurl {
      url = "https://download.qoppa.com/pdfstudio/v${year}/PDFStudio_v${dot2dash version}_linux64.deb";
      hash = "sha256-dptpkWPlocp4U9QSp+AJTOSVWA3RRs8GrFfXhCYzOJc=";
    };
    extraBuildInputs = [
      (lib.getLib stdenv.cc.cc) # for libstdc++.so.6 and libgomp.so.1
    ];
    jdk = jdk17;
  };

}
.${pname}
