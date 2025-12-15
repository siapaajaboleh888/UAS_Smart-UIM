# ========================================
# Auto Fix & Build Script
# Smart UIM LMS - Flutter Project
# ========================================
# Author: Moh. Syaiful Anam (2022020100078)
# ========================================

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Smart UIM LMS - Quick Fix & Build" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Clean
Write-Host "[1/4] Cleaning Flutter cache..." -ForegroundColor Yellow
flutter clean
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Flutter clean failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Clean successful!" -ForegroundColor Green
Write-Host ""

# Step 2: Get Dependencies
Write-Host "[2/4] Getting Flutter dependencies..." -ForegroundColor Yellow
flutter pub get
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Flutter pub get failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Dependencies installed!" -ForegroundColor Green
Write-Host ""

# Step 3: Build APK Debug
Write-Host "[3/4] Building debug APK..." -ForegroundColor Yellow
flutter build apk --debug
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Build failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Build successful!" -ForegroundColor Green
Write-Host ""

# Step 4: Show Result
Write-Host "[4/4] Build completed!" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ SUCCESS!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "📱 APK Location:" -ForegroundColor Cyan
Write-Host "   build\app\outputs\flutter-apk\app-debug.apk" -ForegroundColor White
Write-Host ""
Write-Host "🎯 Next Steps:" -ForegroundColor Cyan
Write-Host "   1. Test: flutter run" -ForegroundColor White
Write-Host "   2. Build release: flutter build apk --release" -ForegroundColor White
Write-Host "   3. Import database: cd database; .\import_database.ps1" -ForegroundColor White
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
