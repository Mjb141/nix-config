{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  zstd,
  curl,
  fontconfig,
  libglvnd,
  libxkbcommon,
  vulkan-loader,
  wayland,
  xdg-utils,
  xorg,
  zlib,
  makeWrapper,
  waylandSupport ? false,
}: let
  version = "";

  linux = stdenv.mkDerivation (finalAttrs: {
    inherit version;
    src = fetchurl {
      url = "https://releases.warp.dev/stable/v${finalAttrs.version}/warp-terminal-v${finalAttrs.version}-1-x86_64.pkg.tar.zst";
    };

    sourceRoot = ".";

    postPatch = ''
      substituteInPlace usr/bin/warp-terminal \
        --replace-fail /opt/ $out/opt/
    '';

    nativeBuildInputs = [autoPatchelfHook zstd makeWrapper];

    buildInputs = [
      curl
      fontconfig
      stdenv.cc.cc.lib # libstdc++.so libgcc_s.so
      zlib
    ];

    runtimeDependencies =
      [
        libglvnd # for libegl
        libxkbcommon
        stdenv.cc.libc
        vulkan-loader
        xdg-utils
        xorg.libX11
        xorg.libxcb
        xorg.libXcursor
        xorg.libXi
      ]
      ++ lib.optionals waylandSupport [wayland];

    installPhase =
      ''
        runHook preInstall

        mkdir $out
        cp -r opt usr/* $out

      ''
      + lib.optionalString waylandSupport ''
        wrapProgram $out/bin/warp-terminal --set WARP_ENABLE_WAYLAND 1
      ''
      + ''
        runHook postInstall
      '';
  });
in
  linux
