    @echo off
    setlocal EnableDelayedExpansion
    cd C:\Program Files (x86)\Minimal ADB and Fastboot
    set PATH=%PATH%;C:\Program Files (x86)\Minimal ADB and Fastboot
    ADB SETUP IDATA by minitools (Minimal ADB and Fastboot)
    adb start-server
    rem bạn hãy thay đổi và pass wifi tại đây ================================================================================================
                ::set duong_dan_app_ban_cu=C:\Users\PH\AppData\Local\Temp\JTSprinter1.1.125.apk
                ::set duong_dan_app_ban_moi=C:\Users\PH\AppData\Local\Temp\JTSprinter1.1.151.apk
		set duong_dan_app_ban_cu=%1
		set duong_dan_app_ban_moi=%2
                set packages_name_JT_cu_1=cn.yssoft.vietnam
                set packages_name_JT_cu_2=cn.yssoft.philippines
                set packages_name_JT_moi=com.jt.express.vietnam.outfield
            rem pass wifi J&T Expreess Office
                set pass_wifi_jt_expreess_office="Jtexpress2024!@#++"
            rem pass wifi J&T Expreess Guest
                set pass_wifi_JT_Expreess_Guest="Jtexpress@2024++$"
    rem =======================================================================================================================
        FOR %%a IN (%duong_dan_app_ban_cu%) DO SET JTSprinter_version_cu=%%~na
        FOR %%a IN (%duong_dan_app_ban_moi%) DO SET JTSprinter_version_new=%%~na
    ::=========================================================================================================================
:: chương trình
    rem check chương trình ADB ================================================================================================
        cls
        echo Dang kiem tra thiet bi ket noi qua ADB...
        adb get-state >nul 2>&1
        if ERRORLEVEL 1 (
            echo Loi: ADB chua duoc cai dat hoac cau hinh dung
            echo VUI LONG KIEM TRA LAI
            pause
            exit
        )
        for /f "skip=1 tokens=1" %%i in ('adb devices') do (
            if "%%i"=="List" goto :no_device
            if not "%%i"=="" (
                echo Thiet bi da ket noi: %%i
                goto :mainmenu
            )
        )
            :no_device
                echo.
                echo.
                echo ========================================= Xac nhan thuc hien ==========================================
                echo =                                                                                                     =
                echo =                     * KHONG CO THIEP BI NAO DUOC KET NOI HOAT ADB CHUA DUOC BAT *                   =
                echo =                                    VUI LONG KIEM TRA VA THU LAI                                     =
                echo =                                                                                                     =
                echo =======================================================================================================
                pause
                exit
    ::=========================================================================================================================
::=============================================================================================================================
cls
    :mainmenu
        cls
         adb devices -l
        echo.
        echo.
        echo ============================================= MENU PROGRAM ============================================
        echo =======================================================================================================
        echo =                                          [01] . Auto setup                                          =
        echo =  [02] . Cai dat giay tren thanh thong bao        =  [03] . An giay tren thanh thong bao             =
        echo =  [04] . An ung dung                              =  [05] . Hien ung dung                            =
        echo =  [06] . Cai ung dung JTSprinter                  =  [07] . Xoa ung dung JTSprinter                  =
        echo =  [08] . Cai ung dung khac                        =  [09] . Xoa ung dung khac                        =
        echo =  [10] . Chep File cai JTSprinter vao thiep bi    =  [11] . Nhap Password WIFI                       =
        echo =  [rl] . Reload tools                             =                                                  =
        echo =======================================================================================================
        echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
        echo =======================================================================================================
        set /p mainmenu=" VUI LONG NHAP LUA CHON CUA BAN :   "
        set compare_result=findstr /i "LUA CHON MONG MUON" "%mainmenu%"
            if %mainmenu%==01 (
                cls
                goto menu_auto_setup
            ) else if %mainmenu%==02 (
                cls
                 adb shell settings put secure clock_seconds 1
                goto mainmenu
            ) else if %mainmenu%==03 (
                cls
                 adb shell settings put secure clock_seconds 0
                goto mainmenu
            ) else if %mainmenu%==04 (
                cls
                goto menu_set_hidden_app
            ) else if %mainmenu%==05 (
                cls
                goto menu_set_unhidden_app
            ) else if %mainmenu%==06 (
                cls
                goto menu_install_JTSprinter
            ) else if %mainmenu%==07 (
                cls
                goto menu_uninstall_JTSprinter
            ) else if %mainmenu%==08 (
                cls
                goto install_another_app
            ) else if %mainmenu%==09 (
                cls
                goto uninstall_another_app
            ) else if %mainmenu%==10 (
                cls
                rem tạo thư mục apk_file trong máy
                 adb shell mkdir /storage/emulated/0/apk_file
                rem copy file từ máy tính sang thiếp bị
                 adb push "%duong_dan_app_ban_moi%" "/storage/emulated/0/apk_file"
                goto mainmenu
            ) else if %mainmenu%==11 (
                cls
                goto menu_input_wifi_pass
            ) else if "%mainmenu%"=="rs" (
                cls
                 adb reboot
                goto mainmenu
            ) else if "%mainmenu%"=="rl" (
                cls
                goto mainmenu
            ) else if "%mainmenu%"=="ex" (
                exit
            ) else (
                cls
                echo.
                echo.
                echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                echo                        VUI LONG NHAP LAI !
                goto mainmenu
            )
::=============================================================================================================================
            rem 1.1 ===========================================================================================================
                :menu_auto_setup
                    cls
                     adb devices -l
                    echo.
                    echo.
                    echo ============================================= MENU PROGRAM ============================================
                    echo =======================================================================================================
                    echo =  [01] . Idata K1S (cu)                           =                                                  =
                    echo =  [02] . Idata AUTOID Q9                          =                                                  =
                    echo =  [03] . Idata K1S (moi)                          =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =  [00] . BACK                                     =  [H] . HOME                                      =
                    echo =======================================================================================================
                    echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
                    echo =======================================================================================================
                    set /p menu_auto_setup=" VUI LONG NHAP LUA CHON CUA BAN :   "
                        if %menu_auto_setup%==01 (
                            cls
                            goto menu_auto_setup_K1S_cu 
                        ) else if %menu_auto_setup%==02 (
                            cls
                            goto menu_auto_setup_AUTOID_Q9
                        ) else if %menu_auto_setup%==03 (
                            cls
                            goto menu_auto_setup_K1S_moi
                        ) else if "%menu_auto_setup%"=="H" (
                            cls
                            goto mainmenu
                        ) else if %menu_auto_setup%==00 (
                            cls
                            goto mainmenu            
                        ) else if "%menu_auto_setup%"=="rs" (
                            cls
                             adb reboot
                            goto menu_auto_setup
                        ) else if "%menu_auto_setup%"=="ex" (
                            exit
                        ) else (
                            cls
                            echo.
                            echo.
                            echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                            echo                        VUI LONG NHAP LAI !
                            goto menu_auto_setup
                        )
                ::=============================================================================================================
                    rem 1.1.1 =================================================================================================
                        :menu_auto_setup_K1S_cu
                            cls
                            echo Thuc hien tu dong SETUP tu dong thiep bi IDATA K1S
                             adb devices -l
                            echo.
                            echo.
                            echo ========================================= Xac nhan thuc hien ==========================================
                            echo =                                                                                                     =
                            echo =  - Nhung ung dung se duoc an                                                                        =
                            echo =          * Trinh Duyet Web                       =            * Ban Phim Tieng Trung                =
                            echo =          * Danh Ba                               =            * Email                               =
                            echo =          * Cuoc Goi                              =            * Tin Nhan                            =
                            echo =          * Am Nhac                               =            * mdm                                 =
                            echo =          * Bo cong cu SIM                        =                                                  =
                            echo =  - Ung dung JT ban cu se duoc XOA                                                                   =
                            echo =  - Tao thu muc apk_file                                                                             =
                            echo =  - Sao chep file cai app JT vao thiep bi                                                            =
                            echo =  - Ung dung ISCAN duoc mo de ban thiet lap                                                          =
                            echo =                                                                                                     =
                            echo =======================================================================================================
                            echo =  [y] . Xac nhan                                  =  [n] . huy                                       =
                            echo =                                                  =                                                  =
                            echo =                                                  =                                                  =
                            echo =                                                  =  [H] . HOME                                      =
                            echo =======================================================================================================
                            echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
                            echo =======================================================================================================
                            set /p menu_auto_setup_K1S_cu=" VUI LONG NHAP LUA CHON CUA BAN :   "
                                if "%menu_auto_setup_K1S_cu%"=="y" (
                                    cls
                                    goto start_run_K1S_cu
                                ) else if "%menu_auto_setup_K1S_cu%"=="n" (
                                    cls
                                    goto menu_auto_setup
                                ) else if "%menu_auto_setup_K1S_cu%"=="H" (
                                    cls
                                    goto mainmenu            
                                ) else if "%menu_auto_setup_K1S_cu%"=="rs" (
                                    cls
                                     adb reboot
                                    goto menu_auto_setup_K1S_cu
                                ) else if "%menu_auto_setup_K1S_cu%"=="ex" (
                                    exit
                                ) else (
                                    cls
                                    echo.
                                    echo.
                                    echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                                    echo                        VUI LONG NHAP LAI !
                                    goto menu_auto_setup_K1S_cu
                                )
                        ::=====================================================================================================
                            rem start_run_K1S =================================================================================
                                :start_run_K1S_cu
                                    cls
                                    echo Bat dau thuc thi
                                     adb devices -l
                                     adb get-serialno
                                    rem bật wifi
                                     adb shell svc wifi enable
                                    rem bật giây trên thanh thông báo
                                     adb shell settings put secure clock_seconds 1
                                    rem cài múi giờ
                                     adb shell service call alarm 3 s16 Asia/Ho_Chi_Minh
                                    rem cài ngôn ngữ
                                     adb shell content query --uri content://settings/system --where "name=\'system_locales\'"
                                     adb shell content delete --uri content://settings/system --where "name=\'system_locales\'"
                                     adb shell content insert --uri content://settings/system --bind name:s:system_locales --bind value:s:vi-VN
                                    rem xóa app JT cũ
                                     adb uninstall "%packages_name_JT_cu_1%"
                                    rem cài app JT bản mới nhất
                                     adb install -r -d "%duong_dan_app_ban_moi%"
                                    rem adb install -r "%duong_dan_app_ban_cu%" dùng khi bản mới lỗi
                                    rem tạo thư mục apk_file trong máy
                                     adb shell mkdir /storage/emulated/0/apk_file
                                    rem copy file từ máy tính sang thiếp bị
                                     adb push "%duong_dan_app_ban_moi%" "/storage/emulated/0/apk_file"
                                    rem ẩn ứng dụng
                                     adb shell pm disable-user com.android.browser
                                     adb shell pm disable-user com.android.contacts
                                     adb shell pm disable-user com.android.mms
                                     adb shell pm disable-user com.idatachina.mdm
                                     adb shell pm disable-user com.android.dialer
                                     adb shell pm disable-user com.iflytek.inputmethod.google
                                     adb shell pm disable-user com.android.email
                                     adb shell pm disable-user com.android.music
                                     adb shell pm disable-user com.android.stk
                                    rem mở ứng dụng scanpro lên setup
                                    cls
                                     adb shell am start -n com.idata.iscanv2/com.idata.iscanv2.MainActivity
                                    echo sau khi reset vao app "iSanPro" ===== app setting
                                    echo ============================================================
                                    echo additional content              ===== "null"
                                    echo scan result output mode         ===== "output to broadcast"
                                    echo ============================================================
                                    echo sau khi SETUP vui long an phim bat ki de ket thuc
                                    pause
                                     adb shell am force-stop com.idata.iscanv2
                                    cls
                                    timeout /t 05
                                     adb reboot
                                    cls
                                    goto menu_auto_setup
                            ::=================================================================================================
                    rem 1.1.2 =================================================================================================
                        :menu_auto_setup_AUTOID_Q9
                            cls
                            echo Thuc hien tu dong SETUP tu dong thiep bi IDATA AUTOID Q9
                             adb devices -l
                            echo.
                            echo.
                            echo ========================================= Xac nhan thuc hien ==========================================
                            echo =                                                                                                     =
                            echo =  - Nhung ung dung se duoc an                                                                        =
                            echo =          * Bo cong cu SIM                        =                                                  =
                            echo =  - Nhung ung dung se duoc XOA                                                                       =
                            echo =          * Youtube                               =            * YT Music                            =
                            echo =          * Google Drive                          =            * Email                               =
                            echo =          * Tro Ly                                =            * Google                              =
                            echo =          * Chrome                                =            * Google Play                         =
                            echo =  - Ung dung JT ban cu se duoc XOA                                                                   =
                            echo =  - Tao thu muc apk_file                                                                             =
                            echo =  - Sao chep file cai app JT vao thiep bi                                                            =
                            echo =                                                                                                     =
                            echo =                                                                                                     =
                            echo =======================================================================================================
                            echo =  [y] . Xac nhan                                  =  [n] . huy                                       =
                            echo =                                                  =                                                  =
                            echo =                                                  =                                                  =
                            echo =                                                  =  [H] . HOME                                      =
                            echo =======================================================================================================
                            echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
                            echo =======================================================================================================
                            set /p menu_auto_setup_AUTOID_Q9=" VUI LONG NHAP LUA CHON CUA BAN :   "
                                if "%menu_auto_setup_AUTOID_Q9%"=="y" (
                                    cls
                                    goto start_run_AUTOID_Q9
                                ) else if "%menu_auto_setup_AUTOID_Q9%"=="n" (
                                    cls
                                    goto menu_auto_setup
                                ) else if "%menu_auto_setup_AUTOID_Q9%"=="H" (
                                    cls
                                    goto mainmenu            
                                ) else if "%menu_auto_setup_AUTOID_Q9%"=="rs" (
                                    cls
                                     adb reboot
                                    goto menu_auto_setup_AUTOID_Q9
                                ) else if "%menu_auto_setup_AUTOID_Q9%"=="ex" (
                                    exit
                                ) else (
                                    cls
                                    echo.
                                    echo.
                                    echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                                    echo                        VUI LONG NHAP LAI !
                                    goto menu_auto_setup_AUTOID_Q9
                                )
                        ::=====================================================================================================
                            rem start_run_AUTOID_Q9 ===========================================================================
                                :start_run_AUTOID_Q9
                                    echo Bat dau thuc thi
                                     adb devices -l
                                     adb get-serialno
                                    rem bật wifi
                                     adb shell svc wifi enable
                                    rem bật giây trên thanh thông báo
                                     adb shell settings put secure clock_seconds 1
                                    rem xóa app JT cũ
                                     adb uninstall "%packages_name_JT_cu_2%"
                                    rem cài app JT bản mới nhất
                                     adb install -r -d "%duong_dan_app_ban_moi%"
                                        rem adb install -r "%duong_dan_app_ban_cu%" dùng khi bản mới lỗi
                                    rem ẩn ứng dụng
                                     adb shell pm disable-user com.android.stk
                                     adb shell pm disable-user com.android.cellbroadcastreceiver
                                    rem xóa ứng dụng không cần thiết
                                     adb shell pm uninstall -k --user 0 com.android.chrome
                                     adb shell pm uninstall -k --user 0 com.android.vending
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.youtube.music
                                     adb shell pm uninstall -k --user 0 com.google.android.youtube
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.docs
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.tachyon
                                     adb shell pm uninstall -k --user 0 com.google.android.gm
                                     adb shell pm uninstall -k --user 0 com.google.android.googlequicksearchbox
                                     adb shell pm uninstall -k --user 0 com.google.android.videos
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.maps
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.googleassistant
                                    rem tạo thư mục apk_file trong máy
                                     adb shell mkdir /storage/emulated/0/apk_file
                                    rem copy file từ máy tính sang thiếp bị
                                     adb push "%duong_dan_app_ban_moi%" /storage/emulated/0/apk_file
                                    goto menu_auto_setup
                            ::=================================================================================================
                    rem 1.1.3 =================================================================================================
                        :menu_auto_setup_K1S_moi
                            cls
                            echo Thuc hien tu dong SETUP tu dong thiep bi IDATA K1S chay Android 
                             adb devices -l
                            echo.
                            echo.
                            echo ========================================= Xac nhan thuc hien ==========================================
                            echo =                                                                                                     =
                            echo =  - Nhung ung dung se duoc an                                                                        =
                            echo =          * Bo cong cu SIM                        =                                                  =
                            echo =  - Nhung ung dung se duoc XOA                                                                       =
                            echo =          * Youtube                               =            * YT Music                            =
                            echo =          * Google Drive                          =            * Email                               =
                            echo =          * Tro Ly                                =            * Google                              =
                            echo =          * Chrome                                =            * Google Play                         =
                            echo =  - Ung dung JT ban cu se duoc XOA                                                                   =
                            echo =  - Tao thu muc apk_file                                                                             =
                            echo =  - Sao chep file cai app JT vao thiep bi                                                            =
                            echo =                                                                                                     =
                            echo =                                                                                                     =
                            echo =======================================================================================================
                            echo =  [y] . Xac nhan                                  =  [n] . huy                                       =
                            echo =                                                  =                                                  =
                            echo =                                                  =                                                  =
                            echo =                                                  =  [H] . HOME                                      =
                            echo =======================================================================================================
                            echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
                            echo =======================================================================================================
                            set /p menu_auto_setup_K1S_moi=" VUI LONG NHAP LUA CHON CUA BAN :   "
                                if "%menu_auto_setup_K1S_moi%"=="y" (
                                    cls
                                    goto start_run_K1S_moi
                                ) else if "%menu_auto_setup_K1S_moi%"=="n" (
                                    cls
                                    goto menu_auto_setup
                                ) else if "%menu_auto_setup_K1S_moi%"=="H" (
                                    cls
                                    goto mainmenu            
                                ) else if "%menu_auto_setup_K1S_moi%"=="rs" (
                                    cls
                                     adb reboot
                                    goto menu_auto_setup_K1S_moi
                                ) else if "%menu_auto_setup_K1S_moi%"=="ex" (
                                    exit
                                ) else (
                                    cls
                                    echo.
                                    echo.
                                    echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                                    echo                        VUI LONG NHAP LAI !
                                    goto menu_auto_setup_K1S_moi
                                )
                        ::=====================================================================================================
                            rem start_run_K1S_moi =============================================================================
                                :start_run_K1S_moi
                                    cls
                                    echo Bat dau thuc thi
                                     adb devices -l
                                     adb get-serialno
                                    rem bật wifi
                                     adb shell svc wifi enable
                                    rem bật giây trên thanh thông báo
                                     adb shell settings put secure clock_seconds 1
                                    rem xóa app JT cũ
                                     adb uninstall "%packages_name_JT_cu_1%"
                                    rem cài app JT bản mới nhất
                                     adb install -r "%duong_dan_app_ban_moi%"
                                    rem adb install -r -d "%duong_dan_app_ban_cu%" dùng khi bản mới lỗi
                                    rem tạo thư mục apk_file trong máy
                                     adb shell mkdir /storage/emulated/0/apk_file
                                    rem copy file từ máy tính sang thiếp bị
                                     adb push "%duong_dan_app_ban_moi%" /storage/emulated/0/apk_file
                                    rem ẩn ứng dụng
                                     adb shell pm disable-user com.android.stk
                                     adb shell pm disable-user com.android.cellbroadcastreceiver
                                    rem xóa ứng dụng không cần thiết
                                     adb shell pm uninstall -k --user 0 com.android.chrome
                                     adb shell pm uninstall -k --user 0 com.android.vending
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.youtube.music
                                     adb shell pm uninstall -k --user 0 com.google.android.youtube
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.docs
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.tachyon
                                     adb shell pm uninstall -k --user 0 com.google.android.gm
                                     adb shell pm uninstall -k --user 0 com.google.android.googlequicksearchbox
                                     adb shell pm uninstall -k --user 0 com.google.android.videos
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.maps
                                     adb shell pm uninstall -k --user 0 com.google.android.apps.googleassistant
                                    cls
                                    goto menu_auto_setup
                            ::=================================================================================================
            ::=================================================================================================================
            rem 1.4 ===========================================================================================================
                :menu_set_hidden_app
                    cls
                     adb devices -l
                    echo.
                    echo.
                    echo ============================================= MENU PROGRAM ============================================
                    echo =======================================================================================================
                    echo =  [01] . Idata K1S (cu)                           =                                                  =
                    echo =  [02] . Idata AUTOID Q9                          =                                                  =
                    echo =  [03] . An cac ung dung khac                     =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =  [00] . BACK                                     =  [H] . HOME                                      =
                    echo =======================================================================================================
                    echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
                    echo =======================================================================================================
                    set /p menu_set_hidden_app=" VUI LONG NHAP LUA CHON CUA BAN :   "
                        if %menu_set_hidden_app%==01 (
                            cls
                            goto menu_set_hidden_app_K1S 
                        ) else if %menu_set_hidden_app%==02 (
                            cls
                            goto menu_set_hidden_app_AUTOID_Q9
                        ) else if %menu_set_hidden_app%==03 (
                            cls
                            goto menu_set_hidden_app_khac
                        ) else if %menu_set_hidden_app%==00 (
                            cls
                            goto mainmenu
                        ) else if "%menu_set_hidden_app%"=="H" (
                            cls
                            goto mainmenu      
                        ) else if "%menu_set_hidden_app%"=="rs" (
                            cls
                             adb reboot
                            goto menu_set_hidden_app
                        ) else if "%menu_set_hidden_app%"=="ex" (
                            exit
                        ) else (
                            cls
                            echo.
                            echo.
                            echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                            echo                        VUI LONG NHAP LAI !
                            goto menu_set_hidden_app
                        )
            ::=================================================================================================================
                    rem 1.4.1 =================================================================================================
                        :menu_set_hidden_app_K1S
                        rem ẩn ứng dụng khi đã được xác nhận
                            cls
                             adb shell pm disable-user com.android.browser
                             adb shell pm disable-user com.android.contacts
                             adb shell pm disable-user com.android.mms
                             adb shell pm disable-user com.idatachina.mdm
                             adb shell pm disable-user com.android.dialer
                             adb shell pm disable-user com.iflytek.inputmethod.google
                             adb shell pm disable-user com.android.email
                             adb shell pm disable-user com.android.music
                             adb shell pm disable-user com.android.stk
                            goto menu_set_hidden_app
                        ::=====================================================================================================
                    rem 1.4.2 =================================================================================================
                        :menu_set_hidden_app_AUTOID_Q9
                            cls
                            rem tiếp tục chạy tiếp
                             adb shell pm disable-user com.android.browser
                             adb shell pm disable-user com.android.contacts
                             adb shell pm disable-user com.android.mms
                             adb shell pm disable-user com.idatachina.mdm
                             adb shell pm disable-user com.android.dialer
                             adb shell pm disable-user com.iflytek.inputmethod.google
                             adb shell pm disable-user com.android.email
                             adb shell pm disable-user com.android.music
                             adb shell pm disable-user com.android.stk
                            goto menu_set_hidden_app
                        ::=====================================================================================================
                    rem 1.4.3 =================================================================================================
                        :menu_set_hidden_app_khac
                            cls
                                        adb shell pm list packages                                    
                            echo ************************************************************
                            echo.
                            echo.
                            echo VUI LONG NHAP PACKAGES NAME CUA UNG DUNG BAN MUON AN
                            echo      * NHAP 'back' DE QUAY LAI
                            echo      * NHAP 'exit' DE THOAT
                            echo.
                            set /p menu_set_hidden_app_khac="packages name hidden: "
                            if "%menu_set_hidden_app_khac%"=="back" (
                                cls
                                goto menu_set_hidden_app
                            ) else if "%menu_set_hidden_app_khac%"=="exit" (
                                cls
                                exit
                            ) else (
                                    adb shell pm list packages
                                echo ************************************************************
                                    adb shell pm disable-user "%menu_set_hidden_app_khac%"
                                if ERRORLEVEL 1 (
                                    cls
                                    echo LOI: Khong the an ung dung. Vui long kiem tra packages name hoac thu lai.
                                    goto menu_set_hidden_app_khac
                                ) else (
                                    cls
                                    echo.
                                    echo.
                                    echo         ********** Ung dung da duoc an thanh cong **********
                                )
                                goto menu_set_hidden_app_khac
                            )
                        ::=====================================================================================================                        
            rem 1.5 ===========================================================================================================
                :menu_set_unhidden_app
                    cls
                     adb devices -l
                    echo.
                    echo.
                    echo ============================================= MENU PROGRAM ============================================
                    echo =======================================================================================================
                    echo =  [01] . Idata K1S (cu)                           =                                                  =
                    echo =  [02] . Idata AUTOID Q9                          =                                                  =
                    echo =  [03] . Hien cac ung dung khac                   =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =  [00] . BACK                                     =  [H] . HOME                                      =
                    echo =======================================================================================================
                    echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
                    echo =======================================================================================================
                    set /p menu_set_unhidden_app=" VUI LONG NHAP LUA CHON CUA BAN :   "
                        if %menu_set_unhidden_app%==01 (
                            cls
                            goto menu_set_unhidden_app_K1S 
                        ) else if %menu_set_unhidden_app%==02 (
                            cls
                            goto menu_set_unhidden_app_AUTOID_Q9
                        ) else if %menu_set_unhidden_app%==03 (
                            cls
                            goto menu_set_unhidden_app_khac
                        ) else if %menu_set_unhidden_app%==00 (
                            cls
                            goto mainmenu
                        ) else if "%menu_set_unhidden_app%"=="H" (
                            cls
                            goto mainmenu            
                        ) else if "%menu_set_unhidden_app%"=="rs" (
                            cls
                             adb reboot
                            goto menu_set_unhidden_app
                        ) else if "%menu_set_unhidden_app%"=="ex" (
                            exit
                        ) else (
                            cls
                            echo.
                            echo.
                            echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                            echo                        VUI LONG NHAP LAI !
                            goto menu_set_unhidden_app
                        )
            ::=================================================================================================================
                    rem 1.5.1 =================================================================================================
                        :menu_set_unhidden_app_K1S
                        rem ẩn ứng dụng khi đã được xác nhận
                            cls
                             adb shell pm enable com.android.browser
                             adb shell pm enable com.android.contacts
                             adb shell pm enable com.android.mms
                             adb shell pm enable com.idatachina.mdm
                             adb shell pm enable com.android.dialer
                             adb shell pm enable com.iflytek.inputmethod.google
                             adb shell pm enable com.android.email
                             adb shell pm enable com.android.music
                             adb shell pm enable com.android.stk
                            goto menu_set_unhidden_app
                        ::=====================================================================================================
                    rem 1.5.2 =================================================================================================
                        :menu_set_unhidden_app_AUTOID_Q9
                            cls
                            rem tiếp tục chạy tiếp
                             adb shell pm enable com.android.browser
                             adb shell pm enable com.android.contacts
                             adb shell pm enable com.android.mms
                             adb shell pm enable com.idatachina.mdm
                             adb shell pm enable com.android.dialer
                             adb shell pm enable com.iflytek.inputmethod.google
                             adb shell pm enable com.android.email
                             adb shell pm enable com.android.music
                             adb shell pm enable com.android.stk
                            goto menu_set_unhidden_app
                        ::=====================================================================================================
                    rem 1.5.3 =================================================================================================
                        :menu_set_unhidden_app_khac
                            cls
                                        adb shell pm list packages                                    
                            echo ************************************************************
                            echo.
                            echo.
                            echo VUI LONG NHAP PACKAGES NAME CUA UNG DUNG BAN MUON HIEN
                            echo      * NHAP 'back' DE QUAY LAI
                            echo      * NHAP 'exit' DE THOAT
                            echo.
                            set /p menu_set_unhidden_app_khac="packages name unhidden: "
                            if "%menu_set_unhidden_app_khac%"=="back" (
                                cls
                                goto menu_set_unhidden_app
                            ) else if "%menu_set_unhidden_app_khac%"=="exit" (
                                cls
                                exit
                            ) else (
                                    adb shell pm list packages
                                echo ************************************************************
                                    adb shell pm enable "%menu_set_unhidden_app_khac%"
                                if ERRORLEVEL 1 (
                                    cls
                                    echo LOI: Khong the an ung dung. Vui long kiem tra packages name hoac thu lai.
                                    goto menu_set_unhidden_app_khac
                                ) else (
                                    cls
                                    echo.
                                    echo.
                                    echo         ********** Ung dung da duoc hien thanh cong **********
                                )
                                goto menu_set_unhidden_app_khac
                            )
                        ::=====================================================================================================                        
            rem 1.6 ===========================================================================================================
                :menu_install_JTSprinter
                    cls
                    echo ============================================= MENU PROGRAM ============================================
                    echo =======================================================================================================
                    echo =  [01] . [%JTSprinter_version_new%]                      =                                                  =
                    echo =  [02] . [%JTSprinter_version_cu%]                      =                                                  =
                    echo =  [03] . Phien ban khac                           =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =  [00] . BACK                                     =  [H] . HOME                                      =
                    echo =======================================================================================================
                    echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
                    echo =======================================================================================================
                    set /p menu_install_JTSprinter=" VUI LONG NHAP LUA CHON CUA BAN :   "
                        if %menu_install_JTSprinter%==01 (
                            cls
                             adb install -r -d "%duong_dan_app_ban_moi%"
                            goto menu_install_JTSprinter
                        ) else if %menu_install_JTSprinter%==02 (
                            cls
                             adb install -r -d "%duong_dan_app_ban_cu%"
                            goto menu_install_JTSprinter
                        ) else if %menu_install_JTSprinter%==03 (
                            cls
                            goto install_another_app
                        ) else if %menu_install_JTSprinter%==00 (
                            cls
                            goto check_adb
                        ) else if "%menu_install_JTSprinter%"=="H" (
                            cls
                            goto check_adb        
                        ) else if "%menu_install_JTSprinter%"=="rs" (
                            cls
                             adb reboot
                            goto menu_install_JTSprinter
                        ) else if "%menu_install_JTSprinter%"=="ex" (
                            exit
                        ) else (
                            cls
                            echo.
                            echo.
                            echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                            echo                        VUI LONG NHAP LAI !
                            goto menu_install_JTSprinter
                        )
            ::=================================================================================================================
                    rem 1.6.1 =================================================================================================
                        :install_another_app
                            cls
                            echo.
                            echo.
                            echo VUI LONG NHAP DUONG DAN CUA UNG DUNG BAN MUON CAI DAT
                            echo      * NHAP 'back' DE QUAY LAI
                            echo      * NHAP 'exit' DE THOAT
                            echo.
                            set /p install_another_app="path install: "
                                if "%install_another_app%"=="back" (
                                    cls
                                    goto mainmenu
                                ) else if "%install_another_app%"=="exit" (
                                    cls
                                    exit
                                ) else (
                                        adb install -r -d "%install_another_app%"
                                    if ERRORLEVEL 1 (
                                        cls
                                        echo LOI: Khong the cai dat ung dung. Vui long kiem tra duong dan hoac thu lai.
                                        goto install_another_app
                                    ) else (
                                        echo.
                                        echo.
                                        echo         ********** Ung dung da duoc cai dat thanh cong **********
                                    )
                                    goto install_another_app
                                )
                        ::=====================================================================================================
            rem 1.7 ===========================================================================================================
                :menu_uninstall_JTSprinter
                    cls
                    echo ============================================= MENU PROGRAM ============================================
                    echo =======================================================================================================
                    echo =  [01] . Go app cu tren K1S                       =                                                  =
                    echo =  [02] . Go app cu tren AUTOID Q9                 =                                                  =
                    echo =  [03] . Go phien ban moi                         =                                                  =
                    echo =  [04] . Go app khac                              =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =  [00] . BACK                                     =  [H] . HOME                                      =
                    echo =======================================================================================================
                    echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
                    echo =======================================================================================================
                    set /p menu_uninstall_JTSprinter=" VUI LONG NHAP LUA CHON CUA BAN :   "
                        if %menu_uninstall_JTSprinter%==01 (
                            cls
                             adb uninstall "%packages_name_JT_cu_1%"
                            goto menu_uninstall_JTSprinter
                        ) else if %menu_uninstall_JTSprinter%==02 (
                            cls
                             adb uninstall "%packages_name_JT_cu_2%"
                            goto menu_uninstall_JTSprinter
			            ) else if %menu_uninstall_JTSprinter%==03 (
                            cls
                             adb uninstall "%packages_name_JT_moi%"
                            goto menu_uninstall_JTSprinter
                        ) else if %menu_uninstall_JTSprinter%==04 (
                            cls
                            goto uninstall_another_app
                        ) else if %menu_uninstall_JTSprinter%==00 (
                            cls
                            goto mainmenu
                        ) else if "%menu_uninstall_JTSprinter%"=="H" (
                            cls
                            goto mainmenu            
                        ) else if "%menu_uninstall_JTSprinter%"=="rs" (
                            cls
                             adb reboot
                            goto menu_uninstall_JTSprinter
                        ) else if "%menu_uninstall_JTSprinter%"=="ex" (
                            exit
                        ) else (
                            cls
                            echo.
                            echo.
                            echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                            echo                        VUI LONG NHAP LAI !
                            goto menu_uninstall_JTSprinter
                        )
            ::=================================================================================================================
                    rem 1.7.1 =================================================================================================
                        :uninstall_another_app
                            cls
                             adb shell pm list packages -3
                            echo ************************************************************
                            echo.
                            echo.
                            echo VUI LONG NHAP PACKAGES NAME CUA UNG DUNG BAN MUON GO CAI DAT
                            echo      * NHAP 'back' DE QUAY LAI
                            echo      * NHAP 'exit' DE THOAT
                            echo.
                            set /p uninstall_another_app="packages name uninstall: "
                                if "%uninstall_another_app%"=="back" (
                                    cls
                                    goto mainmenu
                                ) else if "%uninstall_another_app%"=="exit" (
                                    cls
                                    exit
                                ) else (
                                        adb shell pm list packages -3
                                    echo ************************************************************
                                        adb uninstall "%uninstall_another_app%"
                                    if ERRORLEVEL 1 (
                                        cls
                                        echo LOI: Khong the go cai dat ung dung. Vui long kiem tra packages name hoac thu lai.
                                        goto uninstall_another_app
                                    ) else (
                                        cls
                                        echo.
                                        echo.
                                        echo         ********** Ung dung da duoc go cai dat thanh cong **********
                                    )
                                    goto uninstall_another_app
                                )
                        ::=====================================================================================================
            rem 1.10 ==========================================================================================================
                :menu_input_wifi_pass
                    cls
                     adb devices -l
                    echo.
                    echo.
                    echo ============================================= MENU PROGRAM ============================================
                    echo =======================================================================================================
                    echo =  [01] . PASSWORD WIFI J^&T Expreess Office       =                                                  =
                    echo =  [02] . NHAP PASSWORD WIFI J^&T Expreess Guest   =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =                                                  =                                                  =
                    echo =  [00] . BACK                                     =  [H] . HOME                                      =
                    echo =======================================================================================================
                    echo =       [rs] . Khoi dong lai thiep bi              =       [ex] . THOAT CHUONG TRINH                  =
                    echo =======================================================================================================
                    set /p menu_input_wifi_pass=" VUI LONG NHAP LUA CHON CUA BAN :   "
                        if %menu_input_wifi_pass%==01 (
                            cls
                            goto menu_auto_setup_K1S 
                        ) else if %menu_input_wifi_pass%==02 (
                            cls
                            goto menu_auto_setup_AUTOID_Q9
                        ) else if %menu_input_wifi_pass%==00 (
                            cls
                            goto mainmenu
                        ) else if "%menu_input_wifi_pass%"=="H" (
                            cls
                            goto mainmenu            
                        ) else if "%menu_input_wifi_pass%"=="rs" (
                            cls
                             adb reboot
                            goto menu_input_wifi_pass
                        ) else if "%menu_input_wifi_pass%"=="ex" (
                            exit
                        ) else (
                            cls
                            echo.
                            echo.
                            echo                LUA CHON BAN NHAP VAO KHONG HOP LE
                            echo                        VUI LONG NHAP LAI !
                            goto menu_input_wifi_pass
                        )
            ::=================================================================================================================
:end
endlocal
adb kill-server
pause
