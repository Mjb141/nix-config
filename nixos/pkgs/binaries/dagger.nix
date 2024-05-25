{
  system ? builtins.currentSystem,
  pkgs,
  lib,
  fetchurl,
  installShellFiles,
}:
{
  dagger = pkgs.stdenv.mkDerivation rec {
    pname = "dagger";
    version = "0.11.4";
    src = fetchurl {
      url = "https://dl.dagger.io/dagger/releases/0.11.4/dagger_v0.11.4_linux_amd64.tar.gz";
      sha256 = "1fz0750biycz21c7fbigkd2njdd54dq27ds22r6j5pxmc5fljz49";
    };
  
    system = system;
    sourceRoot = ".";
    nativeBuildInputs = [ installShellFiles ];
  
    installPhase = ''
      mkdir -p $out/bin
      cp -vr ./dagger $out/bin/dagger
    '';

    postInstall = ''
      installShellCompletion --cmd dagger \
      --zsh <($out/bin/dagger completion zsh)
    '';

    meta = {
      description = "Dagger is an integrated platform to orchestrate the delivery of applications";
      homepage = "https://dagger.io";
      license = lib.licenses.asl20;
  
      sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
  
      platforms = [
        "x86_64-linux"
      ];
    };
  };
}
