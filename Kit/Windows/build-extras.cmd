setlocal
pushd %BUILDER_TOP_DIR%\Kit\Windows
call build-check-pip-deps.cmd %1
cd %BUILDER_TOP_DIR%\Source\Common
    if exist wb_diff_images.py del wb_diff_images.py
    %PYTHON% make_wb_diff_images.py
    if errorlevel 1 goto :eof

cd %BUILDER_TOP_DIR%\Source\
echo Info: Build Clean
    if exist locale rmdir /s /q locale
    echo zzz >I18N\zzzqqqzzz.current.po
    del I18N\*.current.po
    if exist wb_scm_images.py del wb_scm_images.py
    if exist wb_scm_version.py del wb_scm_version.py

echo Info: Build all
    %PYTHON% -u make_wb_scm_images.py
    %PYTHON% -u make_wb_scm_version.py %BUILDER_TOP_DIR%/Builder/version.dat wb_scm_version.py
    if not exist locale\en\LC_MESSAGES mkdir locale\en\LC_MESSAGES
    for /F "usebackq" %%X in ('xgettext.exe') do set XGETTXT_PATH=MISSING%%~$PATH:X
    if "%XGETTXT_PATH%" == "MISSING" (
        echo Warning: cannot make translation MO files - cannot find xgettext.exe
    ) else (
        cd %BUILDER_TOP_DIR%\Source\Scm\I18N
        %PYTHON% make_pot_file.py
        %PYTHON% make_po_file.py en
        %PYTHON% make_mo_files.py ..\locale
    )
popd
endlocal
