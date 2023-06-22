# Issue Description
There are multiple issues here that I can't work out:  
- I can't work out how to make it so that .NET can create/access
a .aspnet folder for its Data Protection Key management.

- The Blazor app that is being shown here has issues only when run inside a nix docker container.

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
docker build -t blazortest . && docker run -it --rm -p 8080:80 blazortest:latest
```
Then go to http://localhost:8080 and notice how the website looks correct

# Steps to Demonstrate/Reproduce
First clone this repo:
```
git clone https://github.com/Zylanx/dockerTools-Blazor-Issue.git
```

Then build default.nix and run the docker container
```
$(nix-build) | docker load && docker run -it --rm -p 8080:80 blazortest:latest
```

Then go to http://localhost:8080.  
You will notice that the CSS has not loaded correctly.