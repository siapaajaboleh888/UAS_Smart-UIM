# Auto Push Script untuk Smart UIM
# Gunakan script ini untuk otomatis push setiap perubahan ke GitHub

Write-Host "🚀 Smart UIM - Auto Git Push" -ForegroundColor Green
Write-Host "================================" -ForegroundColor Green
Write-Host ""

# Git add all changes
Write-Host "📁 Adding files..." -ForegroundColor Yellow
git add .

if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Error: Failed to add files" -ForegroundColor Red
    exit 1
}

# Get commit message from parameter or use default
$commitMessage = $args[0]
if ([string]::IsNullOrEmpty($commitMessage)) {
    $timestamp = Get-Date -Format "dd/MM/yyyy HH:mm"
    $commitMessage = "📝 Update: Auto commit pada $timestamp"
}

# Git commit
Write-Host "💾 Committing changes..." -ForegroundColor Yellow
git commit -m "$commitMessage"

if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  No changes to commit" -ForegroundColor Yellow
    exit 0
}

# Git push
Write-Host "🌐 Pushing to GitHub..." -ForegroundColor Yellow
git push origin main

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "✅ SUCCESS! Changes pushed to GitHub" -ForegroundColor Green
    Write-Host "📦 Repository: https://github.com/siapaajaboleh888/UAS_Smart-UIM" -ForegroundColor Cyan
    Write-Host ""
} else {
    Write-Host "❌ Error: Failed to push" -ForegroundColor Red
    exit 1
}
