# Script untuk menjalankan aplikasi di Web (Chrome)
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "  Smart UIM - Run on Web (Chrome)" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Memeriksa devices yang tersedia..." -ForegroundColor Yellow
flutter devices

Write-Host "`nMengunduh dependencies..." -ForegroundColor Yellow
flutter pub get

Write-Host "`nMenjalankan aplikasi di Chrome..." -ForegroundColor Green
Write-Host "Tunggu Chrome akan terbuka otomatis..." -ForegroundColor Gray
Write-Host ""
flutter run -d chrome
