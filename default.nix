{ haskellPackages
, inkscape
, imagemagick
, stdenv
, width ? 3840
, height ? 2160
}:
stdenv.mkDerivation {
  name = "giraffe-wallpaper";
  buildInputs = [
    haskellPackages.ghc
    inkscape
    imagemagick
  ];
  src = ./.;
  buildPhase = ''
    runghc Main main.svg ${builtins.toString width} ${builtins.toString height}
  '';
  installPhase = ''
    mkdir -p $out/share
    cp output.png $out/share/wallpaper.png
  '';
}

