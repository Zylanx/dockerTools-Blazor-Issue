let
  pkgs = import <nixpkgs> { };

  project = import ./project.nix;
in
pkgs.dockerTools.streamLayeredImage {
  name = "blazortest";
  tag = "latest";

  contents = [ project];
   
  config = {
    WorkingDir = "/lib";

    Env = [ "COMPlus_EnableDiagnostics=0" "ASPNETCORE_URLS=http://+:80" "ASPNETCORE_ENVIRONMENT=Development" ];
    
    Cmd = [ "/bin/BlazorTest" ];

    ExposedPorts = { "80/tcp" = {}; "433/tcp" = {}; };
  };
}
