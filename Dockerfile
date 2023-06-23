FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY [".", "."]
RUN dotnet restore
COPY . .
RUN dotnet build "BlazorTest.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "BlazorTest.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .

# Here we copy out the wwwroot files and replace them with symbolic links
COPY ["./wwwroot/*", "./link/"]
RUN rm -r ./wwwroot/*
RUN mkdir ./wwwroot/css
RUN ln -s ./link/BlazorTest.styles.css ./wwwroot
RUN ln -s ./link/favicon.ico ./wwwroot
RUN ln -s ./link/css/site.css ./wwwroot/css
RUN ln -s ./link/css/bootstrap ./wwwroot/css
RUN ln -s ./link/css/open-iconic ./wwwroot/css

ENTRYPOINT ["dotnet", "BlazorTest.dll"]
