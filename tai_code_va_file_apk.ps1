# Tạm thời bỏ qua chính sách thực thi
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
# Đường dẫn thư mục tạm
$TempDir = [System.IO.Path]::GetTempPath()
# Đường dẫn của hai file APK
$Apk_cu_name = "JTSprinter1.1.167.apk"
$Apk_moi_name = "JTSprinter1.1.173.apk"
$ilauncher_name = "idata.ilauncher.apk"
$Apk_cu_Path = Join-Path -Path $TempDir -ChildPath $Apk_cu_name
$Apk_moi_Path = Join-Path -Path $TempDir -ChildPath $Apk_moi_name
$ilauncher_Path = Join-Path -Path $TempDir -ChildPath $ilauncher_name
 # URL của hai file APK trên Google Drive
$Apk1Url = "https://drive.usercontent.google.com/download?id=1MybzNAu71Y1ZYvLS2sZ31AuIJ5XkFian&export=download&authuser=0&confirm=t&uuid=86e99f2e-e97f-4932-a07e-04e66921f46d&at=APcmpoySIje0Dk6bMzF6-8dcmSXg:1745316848242"
$Apk2Url = "https://drive.usercontent.google.com/download?id=1dkQL4-2DeAxdMhhrZTp-frJfkpE08ITk&export=download&authuser=0&confirm=t&uuid=a24983a3-e983-4e22-8498-55ee622c3f8a&at=ALoNOgkB0rKfkNudLrvfW-RR_gfR:1749550942110"
$ilauncherurl = "https://drive.usercontent.google.com/download?id=1vInaFnJs1ajRr-5HwmO1ZQTOyzDiBgTU&export=download&authuser=0&confirm=t&uuid=0416326e-346b-40a7-af98-20071fa971e9&at=ALoNOgmV9mE5DRGxuodboNq1tCqF:1747136381168"
# URL của file BAT trên GitHub
$BatUrl = "https://raw.githubusercontent.com/nguyenlinhvuong249/tools_setup_idata_share/refs/heads/main/idata%20setup%20share.bat"
# Kiểm tra sự tồn tại của các file APK
$Apk1Exists = Test-Path $Apk_cu_Path
$Apk2Exists = Test-Path $Apk_moi_Path
$Apk3Exists = Test-Path $ilauncher_Path
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

if (-not $Apk3Exists) {
    Write-Host "File $ilauncher_name không tồn tại. Đang tải về..." -ForegroundColor Yellow
    Invoke-WebRequest -Uri $ilauncherurl -OutFile $ilauncher_Path -UseBasicParsing
    if (Test-Path $ilauncher_Path) {
        Write-Host "Tải file $ilauncher_name thành công: $ilauncher_Path" -ForegroundColor Green
    } else {
        Write-Host "Lỗi: Không thể tải file $ilauncher_name." -ForegroundColor Red
        exit
    }
} else {
    Write-Host "File $ilauncher_name đã tồn tại: $ilauncher_Path" -ForegroundColor Cyan
}

# Thư mục tạm thời
$TempFolder = $env:TEMP

# Đường dẫn file APK và BAT tạm thời
$ApkFile1 = Join-Path -Path $TempFolder -ChildPath $Apk_cu_name
$ApkFile2 = Join-Path -Path $TempFolder -ChildPath $Apk_moi_name
$ApkFile3 = Join-Path -Path $TempFolder -ChildPath $ilauncher_name
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
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "$BatFile $ApkFile1 $ApkFile2 $ApkFile3" -NoNewWindow -Wait

    # Xóa các file tạm sau khi thực thi
    Write-Host "Đang xóa các file tạm..." -ForegroundColor Yellow
    # Remove-Item -Path $ApkFile1, $ApkFile2, $BatFile -Force
    Remove-Item -Path $ApkFile3 -Force
    Remove-Item -Path $BatFile -Force

    Write-Host "Hoàn tất. Các file tạm đã được xóa." -ForegroundColor Green
} else {
    Write-Host "Lỗi: Không thể tải một hoặc nhiều file. Vui lòng kiểm tra URL hoặc kết nối mạng." -ForegroundColor Red
}

# Đóng cửa sổ PowerShell
Write-Host "Đóng cửa sổ PowerShell..." -ForegroundColor Yellow
exit
