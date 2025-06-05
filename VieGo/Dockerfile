# Giai đoạn build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Tạo thư mục làm việc trong container
WORKDIR /app

# Copy file solution
COPY EXE201_VieGo.sln ./

# Copy từng project (.csproj) tương ứng
COPY VieGo/VieGo.csproj ./VieGo/
COPY Model/Model.csproj ./Model/
COPY Data/Data.csproj ./Data/
COPY Business/Business.csproj ./Business/

# Restore dependencies
RUN dotnet restore EXE201_VieGo.sln

# Copy toàn bộ source code sau khi restore xong
COPY . .

# Build project (chỉ build, chưa publish)
RUN dotnet build EXE201_VieGo.sln -c Release -o /app/build

# Publish project (xuất bản bản release, chỉ cần WebAPI project)
RUN dotnet publish VieGo/VieGo.csproj -c Release -o /app/publish

# Giai đoạn runtime (chạy thực tế)
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final

# Tạo thư mục làm việc
WORKDIR /app

# Copy từ build stage
COPY --from=build /app/publish .

# Mở port 80 cho container
EXPOSE 80

# Lệnh chạy khi container khởi động
ENTRYPOINT ["dotnet", "VieGo.dll"]
