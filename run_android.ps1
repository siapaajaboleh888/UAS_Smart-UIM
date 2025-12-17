# Script untuk menjalankan aplikasi di Android
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Smart UIM - Run on Android Device" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Memeriksa device yang tersedia..." -ForegroundColor Yellow
flutter devices

Write-Host "`nMembersihkan cache Flutter..." -ForegroundColor Yellow
flutter clean

Write-Host "`nMengunduh dependencies..." -ForegroundColor Yellow
flutter pub get

Write-Host "`nMemeriksa status ADB..." -ForegroundColor Yellow
adb devices

Write-Host "`nJika device offline, mencoba restart ADB server..." -ForegroundColor Yellow
adb kill-server
Start-Sleep -Seconds 2
adb start-server
Start-Sleep -Seconds 3

Write-Host "`nMengecek device lagi..." -ForegroundColor Yellow
adb devices

Write-Host "`nMenjalankan aplikasi di Android..." -ForegroundColor Green
flutter run
