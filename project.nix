let
  pkgs = import <nixpkgs> { };

  project = pkgs.buildDotnetModule {
    name = "BlazorTest";

    src = ./.;

    nugetDeps = ./deps.nix;

    projectFile = "./BlazorTest.csproj";

    executables = [ "BlazorTest" ];
    dotnet-runtime = pkgs.dotnetCorePackages.aspnetcore_6_0;

    meta.platforms = pkgs.lib.platforms.linux;

  };
in
project
