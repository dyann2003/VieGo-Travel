# Stage 1: Build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Copy solution và project files
COPY EXE201_VieGo.sln ./
COPY Model/Model.csproj ./Model/
COPY Data/Data.csproj ./Data/
COPY Business/Business.csproj ./Business/
COPY VieGo/VieGo.csproj ./VieGo/

# Restore dependencies
RUN dotnet restore EXE201_VieGo.sln

# Copy toàn bộ source code còn lại
COPY . .

# Build và publish app
RUN dotnet publish VieGo/VieGo.csproj -c Release -o /app/publish /p:UseAppHost=false

# Stage 2: Runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# Mount volume persist DataProtection keys tại /keys (người dùng mount khi chạy container)
VOLUME /keys

# Copy app publish từ stage build
COPY --from=build /app/publish .

# Expose port 80 (đồng bộ với app listen)
EXPOSE 80

# Thiết lập biến môi trường để app listen trên port 80
ENV ASPNETCORE_URLS=http://+:80

# Entry point chạy app
ENTRYPOINT ["dotnet", "VieGo.dll"]
