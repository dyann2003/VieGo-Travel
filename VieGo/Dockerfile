# Use the .NET SDK image for building
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy the solution file and all project files
COPY *.sln ./
COPY VieGo/*.csproj ./VieGo/
COPY Business/*.csproj ./Business/
COPY Data/*.csproj ./Data/
COPY Model/*.csproj ./Model/

# Restore dependencies for the entire solution
RUN dotnet restore

# Copy the entire solution source code
COPY . ./

# Build and publish the main project
RUN dotnet publish VieGo/VieGo.csproj -c Release -o /out

# Use the .NET ASP.NET runtime image
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /out .
EXPOSE 80
ENTRYPOINT ["dotnet", "VieGo.dll"]
