FROM microsoft/dotnet:2.2-aspnetcore-runtime-nanoserver-1803 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk-nanoserver-1803 AS build
WORKDIR /src
COPY ["TestDocker/TestDocker.csproj", "TestDocker/"]
COPY ["TestDocker.Lib/TestDocker.Lib.csproj", "TestDocker.Lib/"]
COPY ["TestDocker.sln", "."]
RUN dotnet restore "TestDocker.Lib/TestDocker.Lib.csproj"
RUN dotnet restore "TestDocker/TestDocker.csproj"
COPY . ./
WORKDIR "/src"
RUN dotnet build "TestDocker.Lib/" -c Release
RUN dotnet build "TestDocker/" -c Release

FROM build AS publish
RUN dotnet publish "TestDocker/TestDocker.csproj" -c Release -o out

FROM base AS final
WORKDIR /app
COPY --from=publish /src/TestDocker/out .
ENTRYPOINT ["dotnet", "TestDocker.dll"]