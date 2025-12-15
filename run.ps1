# Smart UIM - Quick Run Script
# Untuk memudahkan testing aplikasi

param(
    [string]$device = "chrome"
)

Write-Host "🚀 Smart UIM - Quick Run" -ForegroundColor Green
Write-Host "=========================" -ForegroundColor Green
Write-Host ""

# Check if in correct directory
if (-not (Test-Path "pubspec.yaml")) {
    Write-Host "❌ Error: pubspec.yaml not found!" -ForegroundColor Red
    Write-Host "📁 Please run from project root: lms_celoe_app" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Correct usage:" -ForegroundColor Cyan
    Write-Host "  cd 'e:\SEMESTER 7\Flutter\UAS\lms_celoe_app'" -ForegroundColor White
    Write-Host "  .\run.ps1" -ForegroundColor White
    exit 1
}

Write-Host "📋 Checking available devices..." -ForegroundColor Yellow
flutter devices

Write-Host ""
Write-Host "🎯 Running on: $device" -ForegroundColor Cyan
Write-Host ""

if ($device -eq "chrome") {
    Write-Host "🌐 Launching in Chrome browser..." -ForegroundColor Yellow
    flutter run -d chrome
}
elseif ($device -eq "android") {
    Write-Host "📱 Launching on Android device..." -ForegroundColor Yellow
    flutter run
}
elseif ($device -eq "release") {
    Write-Host "⚡ Building release APK..." -ForegroundColor Yellow
    flutter build apk --release
    Write-Host ""
    Write-Host "✅ APK built successfully!" -ForegroundColor Green
    Write-Host "📦 Location: build\app\outputs\flutter-apk\app-release.apk" -ForegroundColor Cyan
}
else {
    Write-Host "🎮 Running on device: $device" -ForegroundColor Yellow
    flutter run -d $device
}
