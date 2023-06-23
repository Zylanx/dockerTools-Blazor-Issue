let
  pkgs = import <nixpkgs> { };

  baseImage = import ./baseImage.nix;

  project = import ./project.nix;
in
pkgs.dockerTools.streamLayeredImage {
  name = "blazortest";
  tag = "latest";

  contents = [ project ];

  enableFakechroot = true;
  fakeRootCommands = ''
    mkdir /tmp
  '';
   
  config = {
    WorkingDir = "${project}/lib";

    Env = [ "COMPlus_EnableDiagnostics=0" "ASPNETCORE_URLS=http://+:80" "ASPNETCORE_ENVIRONMENT=Development" ];
    
    Cmd = [ "${project}/bin/BlazorTest" ];

    ExposedPorts = { "80/tcp" = {}; "433/tcp" = {}; };
  };
}
