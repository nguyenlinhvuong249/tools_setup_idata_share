# Tạm thời bỏ qua chính sách thực thi
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
# Đường dẫn thư mục tạm
$TempDir = [System.IO.Path]::GetTempPath()
# Đường dẫn của hai file APK
$Apk1Name = "JTSprinter1.1.151.apk"
$Apk2Name = "JTSprinter1.1.153.apk"
$Apk1Path = Join-Path -Path $TempDir -ChildPath $Apk1Name
$Apk2Path = Join-Path -Path $TempDir -ChildPath $Apk2Name

 # URL của hai file APK trên Google Drive
$Apk1Url = "https://drive.usercontent.google.com/download?id=1Nbe9pNUqV2hPwovQTJ6G9G8VoRzZqJEB&export=download&authuser=0&confirm=t&uuid=4dda05a1-050b-4ba6-838c-aaf590106272&at=APvzH3rjFhYRs7CcjwyaO5DbBfWh%3A1735019534048"
$Apk2Url = "https://drive.usercontent.google.com/download?id=1tALKzMWTPfFuB36h0Zmf3HbbMD2p2y-s&export=download&authuser=0&confirm=t&uuid=aae8389f-9d2c-4f00-b160-3dc9346f36f3&at=APvzH3ouCaNh3mZD6TQUWHAQc4ep:1735117279767"
# URL của file BAT trên GitHub
$BatUrl = "https://raw.githubusercontent.com/nguyenlinhvuong249/tools_setup_idata_share/refs/heads/main/idata%20setup%20share.bat"
# Kiểm tra sự tồn tại của các file APK
$Apk1Exists = Test-Path $Apk1Path
$Apk2Exists = Test-Path $Apk2Path

# Tải file APK nếu chưa có
if (-not $Apk1Exists) {
    Write-Host "File APK 1 không tồn tại. Đang tải về..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $Apk1Url -OutFile $Apk1Path -UseBasicParsing
    if (Test-Path $Apk1Path) {
        Write-Host "Tải file APK 1 thành công: $Apk1Path" -ForegroundColor Green
    } else {
        Write-Host "Lỗi: Không thể tải file APK 1." -ForegroundColor Red
        exit
    }
} else {
    Write-Host "File APK 1 đã tồn tại: $Apk1Path" -ForegroundColor Cyan
}

if (-not $Apk2Exists) {
    Write-Host "File APK 2 không tồn tại. Đang tải về..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $Apk2Url -OutFile $Apk2Path -UseBasicParsing
    if (Test-Path $Apk2Path) {
        Write-Host "Tải file APK 2 thành công: $Apk2Path" -ForegroundColor Green
    } else {
        Write-Host "Lỗi: Không thể tải file APK 2." -ForegroundColor Red
        exit
    }
} else {
    Write-Host "File APK 2 đã tồn tại: $Apk2Path" -ForegroundColor Cyan
}
# Thư mục tạm thời
$TempFolder = $env:TEMP

# Đường dẫn file APK và BAT tạm thời
$ApkFile1 = Join-Path -Path $TempFolder -ChildPath "JTSprinter1.1.151.apk"
$ApkFile2 = Join-Path -Path $TempFolder -ChildPath "JTSprinter1.1.153.apk"
$BatFile = Join-Path -Path $TempFolder -ChildPath "idata_setup_share.bat"

# Tải file APK thứ nhất từ Google Drive
Write-Host "Đang tải file APK thứ nhất từ Google Drive..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $ApkUrl1 -OutFile $ApkFile1 -UseBasicParsing

# Tải file APK thứ hai từ Google Drive
Write-Host "Đang tải file APK thứ hai từ Google Drive..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $ApkUrl2 -OutFile $ApkFile2 -UseBasicParsing

# Tải file BAT từ GitHub
Write-Host "Đang tải file BAT từ GitHub..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $BatUrl -OutFile $BatFile -UseBasicParsing

# Kiểm tra nếu cả ba file đã tải thành công
if ((Test-Path $ApkFile1) -and (Test-Path $ApkFile2) -and (Test-Path $BatFile)) {
    Write-Host "Cả ba file đã được tải thành công." -ForegroundColor Green

    # Thực thi file BAT và truyền đường dẫn của hai file APK vào
    Write-Host "Đang thực thi file BAT và truyền đường dẫn của hai file APK..." -ForegroundColor Cyan
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "$BatFile $ApkFile1 $ApkFile2" -NoNewWindow -Wait

    # Xóa các file tạm sau khi thực thi
    Write-Host "Đang xóa các file tạm..." -ForegroundColor Yellow
    # Remove-Item -Path $ApkFile1, $ApkFile2, $BatFile -Force
    Remove-Item -Path $BatFile -Force

    Write-Host "Hoàn tất. Các file tạm đã được xóa." -ForegroundColor Green
} else {
    Write-Host "Lỗi: Không thể tải một hoặc nhiều file. Vui lòng kiểm tra URL hoặc kết nối mạng." -ForegroundColor Red
}

# Đóng cửa sổ PowerShell
Write-Host "Đóng cửa sổ PowerShell..." -ForegroundColor Yellow
exit
