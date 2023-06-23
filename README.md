# Issue Description
There are multiple issues here that I can't work out:
- The Blazor app that is being shown here has issues only when run inside a nix docker container.
- I can't work out how to make it so that .NET can create/access
  a .aspnet folder for its Data Protection Key management.

# Solution
To the first issue, Blazor doesn't handle symbolic links correctly and just ignores them.  
Solution: Set the working dir to the nix store path's /lib folder for the app.  
This is demonstrated in solved.nix.

To the second issue, Blazor has weird issues when a /tmp folder doesn't exist.
Solution: Just create a /tmp directory. It works fine then.

# Steps to Demonstrate/Reproduce
First clone this repo:
```
git clone https://github.com/Zylanx/dockerTools-Blazor-Issue.git
```

Then build default.nix or Dockerfile.broken and run the docker container
```
docker build -t blazortest -f Dockerfile.broken . && docker run -it --rm -p 80:80 blazortest:latest
```
or  
```
$(nix-build) | docker load && docker run -it --rm -p 80:80 blazortest:latest
```

Then go to http://localhost.  
You will notice that the CSS has not loaded correctly.

# Expected Result
You can either build and run the Dockerfile or you can build and run project.nix
### project.nix
```
nix-build project.nix
cd result/lib
../bin/BlazorTest
```
Then go to http://localhost:80 and notice how it looks correct

### Docker
```
docker build -t blazortest -f Dockerfile.working . && docker run -it --rm -p 8080:80 blazortest:latest
```
Then go to http://localhost:8080 and notice how the website looks correct
