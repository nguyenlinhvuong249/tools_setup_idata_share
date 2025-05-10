# Tạm thời bỏ qua chính sách thực thi
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force

# Kiểm tra xem ADB có tồn tại chưa
$adbExists = Get-Command adb -ErrorAction SilentlyContinue

$adbFolder = "$PSScriptRoot\adb_temp"
$adbBinPath = "$adbFolder\platform-tools"
$adbZipUrl = "https://dl.google.com/android/repository/platform-tools-latest-windows.zip"
$adbZipPath = "$adbFolder\platform-tools.zip"

if (-not $adbExists) {
    Write-Host "ADB chưa được cài đặt. Đang tiến hành tải và thiết lập..."

    if (-not (Test-Path $adbFolder)) {
        New-Item -ItemType Directory -Path $adbFolder | Out-Null
    }

    Invoke-WebRequest -Uri $adbZipUrl -OutFile $adbZipPath
    Expand-Archive -Path $adbZipPath -DestinationPath $adbFolder -Force
    $env:Path = "$adbBinPath;$env:Path"

    Write-Host "ADB đã được thiết lập tạm thời."

    $choice = Read-Host "Bạn có muốn thêm ADB vào PATH vĩnh viễn không? (y/n)"
    if ($choice -eq 'y') {
        $isAdmin = ([Security.Principal.WindowsPrincipal] `
            [Security.Principal.WindowsIdentity]::GetCurrent() `
            ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)

        if ($isAdmin) {
            $currentPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
            if ($currentPath -notlike "*$adbBinPath*") {
                $newPath = "$currentPath;$adbBinPath"
                [Environment]::SetEnvironmentVariable("Path", $newPath, "Machine")
                Write-Host "Đã thêm ADB vào PATH hệ thống thành công."
            } else {
                Write-Host "ADB đã có trong PATH hệ thống."
            }
        } else {
            Write-Warning "Bạn không có quyền admin. Không thể thêm vào PATH hệ thống."
        }
    }
} else {
    Write-Host "ADB đã có sẵn trong hệ thống."
}

# ==== Tải file APK và BAT ====
$TempDir = [System.IO.Path]::GetTempPath()
$Apk_cu_name = "JTSprinter1.1.165.apk"
$Apk_moi_name = "JTSprinter1.1.167.apk"
$Apk_cu_Path = Join-Path -Path $TempDir -ChildPath $Apk_cu_name
$Apk_moi_Path = Join-Path -Path $TempDir -ChildPath $Apk_moi_name

$Apk1Url = "https://drive.usercontent.google.com/download?id=1CL52Re5msX-OXhvbKgh0wOU7HbKWB0bd&export=download&authuser=0&confirm=t&uuid=805e03a9-2966-4fe1-9fb2-c11d866b0088&at=AEz70l4mLdtRGfLOUWwx9CEIKWtW:1742798381061"
$Apk2Url = "https://drive.usercontent.google.com/download?id=1MybzNAu71Y1ZYvLS2sZ31AuIJ5XkFian&export=download&authuser=0&confirm=t&uuid=86e99f2e-e97f-4932-a07e-04e66921f46d&at=APcmpoySIje0Dk6bMzF6-8dcmSXg:1745316848242"
$BatUrl = "https://raw.githubusercontent.com/nguyenlinhvuong249/tools_setup_idata_share/refs/heads/main/idata%20setup%20share.bat"

$Apk1Exists = Test-Path $Apk_cu_Path
$Apk2Exists = Test-Path $Apk_moi_Path

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

$BatFile = Join-Path -Path $TempDir -ChildPath "idata_setup_share.bat"

# Tải file BAT
Write-Host "Đang tải file BAT từ GitHub..." -ForegroundColor Yellow
Invoke-WebRequest -Uri $BatUrl -OutFile $BatFile -UseBasicParsing

if ((Test-Path $Apk_cu_Path) -and (Test-Path $Apk_moi_Path) -and (Test-Path $BatFile)) {
    Write-Host "Cả ba file đã được tải thành công." -ForegroundColor Green

    Write-Host "Đang thực thi file BAT..." -ForegroundColor Cyan
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "`"$BatFile`" `"$Apk_cu_Path`" `"$Apk_moi_Path`"" -NoNewWindow -Wait

    # Xóa thư mục tạm chứa ADB nếu có
    if (Test-Path $adbFolder) {
        Remove-Item -Path $adbFolder -Recurse -Force -ErrorAction SilentlyContinue
        Write-Host "Đã xóa thư mục tạm: $adbFolder"
    }

    # Xóa các file tạm
    Write-Host "Đang xóa các file tạm..." -ForegroundColor Yellow
    Remove-Item -Path $BatFile -Force
    Write-Host "Hoàn tất. Các file tạm đã được xóa." -ForegroundColor Green
} else {
    Write-Host "Lỗi: Không thể tải một hoặc nhiều file. Vui lòng kiểm tra URL hoặc kết nối mạng." -ForegroundColor Red
}

Write-Host "Đóng cửa sổ PowerShell..." -ForegroundColor Yellow
exit
