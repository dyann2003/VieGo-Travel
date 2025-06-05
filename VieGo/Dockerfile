FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy solution and project files
COPY EXE201_VieGo.sln ./
COPY Model/Model.csproj ./Model/
COPY Data/Data.csproj ./Data/
COPY Business/Business.csproj ./Business/
COPY VieGo/VieGo.csproj ./VieGo/

# Restore dependencies
RUN dotnet restore EXE201_VieGo.sln

# Copy remaining files
COPY . .

# Build and publish
RUN dotnet build EXE201_VieGo.sln -c Release -o /app/build
RUN dotnet publish VieGo/VieGo.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app
COPY --from=build /app/publish .
EXPOSE 80
ENTRYPOINT ["dotnet", "VieGo.dll"]
