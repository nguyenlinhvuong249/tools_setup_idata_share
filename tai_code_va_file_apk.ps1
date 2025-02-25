# Tạm thời bỏ qua chính sách thực thi
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
# Đường dẫn thư mục tạm
$TempDir = [System.IO.Path]::GetTempPath()
# Đường dẫn của hai file APK
$Apk_cu_name = "JTSprinter1.1.153.apk"
$Apk_moi_name = "JTSprinter1.1.155.apk"
$Apk_cu_Path = Join-Path -Path $TempDir -ChildPath $Apk_cu_name
$Apk_moi_Path = Join-Path -Path $TempDir -ChildPath $Apk_moi_name

 # URL của hai file APK trên Google Drive
$Apk1Url = "https://drive.usercontent.google.com/download?id=1tALKzMWTPfFuB36h0Zmf3HbbMD2p2y-s&export=download&authuser=0&confirm=t&uuid=7f25b14e-4df0-4f9a-aaf7-80fd7b609c7e&at=AEz70l48od9ft-mVh3uCLwxU6dEz:1740479227568"
$Apk2Url = "https://drive.usercontent.google.com/download?id=1tSsvrDd959TR9_LanLUEGrjLSIgEh8_A&export=download&authuser=0&confirm=t&uuid=8b498d57-49c7-47e8-a04b-c74c4f0159c1&at=APvzH3pVcZLe1cbHMRPlM6LcOBFe:1735120967721"
# URL của file BAT trên GitHub
$BatUrl = "https://raw.githubusercontent.com/nguyenlinhvuong249/tools_setup_idata_share/refs/heads/main/idata%20setup%20share.bat"
# Kiểm tra sự tồn tại của các file APK
$Apk1Exists = Test-Path $Apk_cu_Path
$Apk2Exists = Test-Path $Apk_moi_Path

# Tải file APK nếu chưa có
if (-not $Apk1Exists) {
    Write-Host "File $Apk_cu_name không tồn tại. Đang tải về..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $Apk1Url -OutFile $Apk_cu_Path -UseBasicParsing
    if (Test-Path $Apk_cu_Path) {
        Write-Host "Tải file $Apk_cu_name thành công: $Apk_cu_Path" -ForegroundColor Green
    } else {
        Write-Host "Lỗi: Không thể tải file $Apk_cu_name." -ForegroundColor Red
        exit
    }
} else {
    Write-Host "File $Apk_cu_name đã tồn tại: $Apk_cu_Path" -ForegroundColor Cyan
}

if (-not $Apk2Exists) {
    Write-Host "File $Apk_moi_name không tồn tại. Đang tải về..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $Apk2Url -OutFile $Apk_moi_Path -UseBasicParsing
    if (Test-Path $Apk_moi_Path) {
        Write-Host "Tải file $Apk_moi_name thành công: $Apk_moi_Path" -ForegroundColor Green
    } else {
        Write-Host "Lỗi: Không thể tải file $Apk_moi_name." -ForegroundColor Red
        exit
    }
} else {
    Write-Host "File $Apk_moi_name đã tồn tại: $Apk_moi_Path" -ForegroundColor Cyan
}
# Thư mục tạm thời
$TempFolder = $env:TEMP

# Đường dẫn file APK và BAT tạm thời
$ApkFile1 = Join-Path -Path $TempFolder -ChildPath $Apk_cu_name
$ApkFile2 = Join-Path -Path $TempFolder -ChildPath $Apk_moi_name
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
