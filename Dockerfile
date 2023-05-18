#FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS base
#FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build

FROM mcr.microsoft.com/dotnet/sdk:3.1 AS build
WORKDIR /src
COPY ./SampleApp.sln ./
COPY ./SampleWebApp/SampleWebApp.csproj ./SampleWebApp/
COPY ./TestProject1/TestProject1.csproj ./TestProject1/
RUN dotnet restore
COPY . .
RUN dotnet test ./TestProject1/TestProject1.csproj
RUN dotnet publish ./SampleWebApp/SampleWebApp.csproj -c Release -o /app/

FROM mcr.microsoft.com/dotnet/aspnet:3.1 AS final
WORKDIR /app
COPY --from=build /app .
EXPOSE 80
EXPOSE 443
ENTRYPOINT ["dotnet", "SampleWebApp.dll"]

#docker run -d -p 8000:80 -p 8443:443 -e ASPNETCORE_HTTPS_PORT=8443 -e ASPNETCORE_URLS="https://+:443;http://+:80" -e Kestrel__Certificates__Default__Path=/root/.dotnet/https/cert-aspnetcore.pfx -e Kestrel__Certificates__Default__Password=abc123 -v D:\Dev\Cert\:/root/.dotnet/https --name=attempt_4  webapp:1.0.4