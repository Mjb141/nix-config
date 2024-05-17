{ stdenv, fetchFromGitHub }:
{
  monochrome-red = stdenv.mkDerivation rec {
    pname = "monochrome-red";
    version = "1.0";
    dontBuild = true;
    installPhase = ''
      mkdir -p $out/share/sddm/themes
      cp -aR $src $out/share/sddm/themes/mono-red
    '';
    src = fetchFromGitHub {
      owner = "camholl";
      repo = "SDDM-Monochrome-Red";
      rev = "5ca556bcd46539ad977b746dc16b0bc9bf65c8c1";
      sha256 = "wzEayNyIcWU0JTBMIh2Nt6nyfLFzmFlDf6bj7Ybac+c=";
    };
  };
}
