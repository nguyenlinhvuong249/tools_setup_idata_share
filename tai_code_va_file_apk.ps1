# Tạm thời bỏ qua chính sách thực thi
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
 # URL của hai file APK trên Google Drive
$ApkUrl1 = "https://drive.usercontent.google.com/download?id=10s2VYn7oRKgEaUT4tcf829lap7bGjGkK&export=download&authuser=0&confirm=t&uuid=b5444085-1d50-4710-b983-1330e7a902a6&at=APvzH3oF2Gz_H9cA3KvKR_SuRDlu:1735017687796"  # Thay <file_id_1> bằng ID file APK thứ nhất
$ApkUrl2 = "https://drive.usercontent.google.com/download?id=1Nbe9pNUqV2hPwovQTJ6G9G8VoRzZqJEB&export=download&authuser=0&confirm=t&uuid=70b05220-f706-48f9-ae86-453a7ae1238e&at=APvzH3pChtl43pJp0U9CqATqkqbK:1735017685689"  # Thay <file_id_2> bằng ID file APK thứ hai

# URL của file BAT trên GitHub
$BatUrl = "https://raw.githubusercontent.com/nguyenlinhvuong249/tools_setup_idata_share/refs/heads/main/idata%20setup%20share.bat"

# Thư mục tạm thời
$TempFolder = $env:TEMP

# Đường dẫn file APK và BAT tạm thời
$ApkFile1 = Join-Path -Path $TempFolder -ChildPath "JTSprinter1.1.125.apk"
$ApkFile2 = Join-Path -Path $TempFolder -ChildPath "JTSprinter1.1.151.apk"
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
