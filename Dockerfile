FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Sao chép solution và project files từ thư mục hiện tại (đang ở ngoài root)
COPY ./EXE201_VieGo.sln ./
COPY ./Model/Model.csproj ./Model/
COPY ./Data/Data.csproj ./Data/
COPY ./Business/Business.csproj ./Business/
COPY ./VieGo/VieGo.csproj ./VieGo/

# Khôi phục dependencies
RUN dotnet restore EXE201_VieGo.sln

# Sao chép toàn bộ source code vào container
COPY ./ ./

# Build và publish
RUN dotnet build EXE201_VieGo.sln -c Release -o /app/build
RUN dotnet publish ./VieGo/VieGo.csproj -c Release -o /app/publish

FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

COPY --from=build /app/publish ./

EXPOSE 80

ENTRYPOINT ["dotnet", "VieGo.dll"]
