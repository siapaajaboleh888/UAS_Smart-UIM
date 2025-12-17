# Script untuk menjalankan aplikasi di Web (Chrome)
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "  Smart UIM - Run on Web (Chrome)" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

Write-Host "Membersihkan cache Flutter..." -ForegroundColor Yellow
flutter clean

Write-Host "`nMengunduh dependencies..." -ForegroundColor Yellow
flutter pub get

Write-Host "`nMenjalankan aplikasi di Chrome..." -ForegroundColor Green
flutter run -d chrome
