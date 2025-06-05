# Sử dụng image .NET SDK để build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# Sao chép tệp giải pháp và các tệp .csproj
COPY *.sln ./
COPY VieGo/*.csproj ./VieGo/
COPY Business/*.csproj ./Business/
COPY Data/*.csproj ./Data/
COPY Model/*.csproj ./Model/

# Khôi phục dependencies cho toàn bộ giải pháp
RUN dotnet restore EXE201_VieGo.sln

# Sao chép toàn bộ mã nguồn
COPY . ./

# Build và publish dự án chính
RUN dotnet publish VieGo/VieGo.csproj -c Release -o /out

# Sử dụng image ASP.NET runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS runtime
WORKDIR /app
COPY --from=build /out .
# Cấu hình cổng cho Render.com
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "VieGo.dll"]
