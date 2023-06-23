let
  pkgs = import <nixpkgs> { };

  project = pkgs.buildDotnetModule {
    name = "BlazorTest";

    src = ./.;

    nugetDeps = ./deps.nix;

    projectFile = "./BlazorTest.csproj";

    executables = [ "BlazorTest" ];
    dotnet-sdk = pkgs.dotnetCorePackages.sdk_7_0;
    dotnet-runtime = pkgs.dotnetCorePackages.aspnetcore_7_0;

    meta.platforms = pkgs.lib.platforms.linux;

  };
in
project
