if not exist "%PROGRAMFILES%\Praat" mkdir "%PROGRAMFILES%\Praat"
set PATH=%PATH%;"%PROGRAMFILES%\Praat"
xcopy  Praat.exe "%PROGRAMFILES%\Praat" /i /y
xcopy  Praat.exe "%userprofile%\Desktop" /i /y
start /d "%PROGRAMFILES%\Praat" Praat.exe
xcopy sendpraat.exe "%PROGRAMFILES%\Praat" /i /y
xcopy packages\* "%userprofile%\Praat\" /i /e /y /s
taskkill /im Praat.exe /f
start /d "%PROGRAMFILES%\Praat" Praat.exe
