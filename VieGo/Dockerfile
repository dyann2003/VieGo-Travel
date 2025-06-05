# Giai đoạn build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Sao chép các file từ thư mục cha vì Dockerfile đang nằm trong /VieGo
COPY ../EXE201_VieGo.sln ./
COPY ../VieGo/*.csproj ./VieGo/
COPY ../Business/*.csproj ./Business/
COPY ../Data/*.csproj ./Data/
COPY ../Model/*.csproj ./Model/

RUN dotnet restore EXE201_VieGo.sln

# Copy toàn bộ code từ thư mục cha (nơi có toàn bộ project)
COPY .. .

RUN dotnet publish VieGo/VieGo.csproj -c Release -o /out

# Giai đoạn runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /out ./

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "VieGo.dll"]
