FROM microsoft/dotnet:2.2-aspnetcore-runtime AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM microsoft/dotnet:2.2-sdk AS build
WORKDIR /src
COPY ["AspNetCoreDockerDemo1/AspNetCoreDockerDemo1.csproj", "AspNetCoreDockerDemo1/"]
RUN dotnet restore "AspNetCoreDockerDemo1/AspNetCoreDockerDemo1.csproj"
COPY . .
WORKDIR "/src/AspNetCoreDockerDemo1"
RUN dotnet build "AspNetCoreDockerDemo1.csproj" -c Release -o /app

FROM build AS publish
RUN dotnet publish "AspNetCoreDockerDemo1.csproj" -c Release -o /app

FROM base AS final
WORKDIR /app
COPY --from=publish /app .
ENTRYPOINT ["dotnet", "AspNetCoreDockerDemo1.dll"]