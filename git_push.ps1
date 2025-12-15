# ========================================
# Auto Git Push Script
# Smart UIM LMS - Flutter Project
# ========================================
# Author: Moh. Syaiful Anam (2022020100078)
# Repository: https://github.com/siapaajaboleh888/UAS_Smart-UIM.git
# ========================================

param(
    [string]$CommitMessage = "Update: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Smart UIM LMS - Auto Git Push" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Step 1: Check Git Status
Write-Host "[1/5] Checking Git status..." -ForegroundColor Yellow
$gitStatus = git status --porcelain
if ([string]::IsNullOrWhiteSpace($gitStatus)) {
    Write-Host "⚠️  No changes to commit!" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "Tip: Make some changes first, then run this script again." -ForegroundColor Gray
    exit 0
}
Write-Host "✅ Changes detected!" -ForegroundColor Green
Write-Host ""

# Step 2: Add All Changes
Write-Host "[2/5] Adding all changes..." -ForegroundColor Yellow
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Git add failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ All changes staged!" -ForegroundColor Green
Write-Host ""

# Step 3: Commit
Write-Host "[3/5] Committing changes..." -ForegroundColor Yellow
Write-Host "Commit message: $CommitMessage" -ForegroundColor Gray
git commit -m "$CommitMessage"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Git commit failed!" -ForegroundColor Red
    exit 1
}
Write-Host "✅ Changes committed!" -ForegroundColor Green
Write-Host ""

# Step 4: Pull (if needed)
Write-Host "[4/5] Pulling latest changes..." -ForegroundColor Yellow
git pull origin main --rebase
if ($LASTEXITCODE -ne 0) {
    Write-Host "⚠️  Pull failed or conflicts detected!" -ForegroundColor Yellow
    Write-Host "Manual intervention may be required." -ForegroundColor Yellow
}
else {
    Write-Host "✅ Pull successful!" -ForegroundColor Green
}
Write-Host ""

# Step 5: Push
Write-Host "[5/5] Pushing to GitHub..." -ForegroundColor Yellow
git push origin main
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Git push failed!" -ForegroundColor Red
    Write-Host ""
    Write-Host "Common solutions:" -ForegroundColor Yellow
    Write-Host "1. Check internet connection" -ForegroundColor White
    Write-Host "2. Verify GitHub credentials" -ForegroundColor White
    Write-Host "3. Try: git push -u origin main --force (if needed)" -ForegroundColor White
    exit 1
}
Write-Host "✅ Pushed to GitHub successfully!" -ForegroundColor Green
Write-Host ""

# Success Summary
Write-Host "========================================" -ForegroundColor Green
Write-Host "  ✅ SUCCESS!" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Green
Write-Host ""
Write-Host "📊 Summary:" -ForegroundColor Cyan
Write-Host "   Repository: https://github.com/siapaajaboleh888/UAS_Smart-UIM.git" -ForegroundColor White
Write-Host "   Branch: main" -ForegroundColor White
Write-Host "   Commit: $CommitMessage" -ForegroundColor White
Write-Host ""
Write-Host "🔗 View changes:" -ForegroundColor Cyan
Write-Host "   https://github.com/siapaajaboleh888/UAS_Smart-UIM/commits/main" -ForegroundColor White
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

# Show recent commits
Write-Host ""
Write-Host "📝 Recent commits:" -ForegroundColor Cyan
git log --oneline -5
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Done! ✨" -ForegroundColor Green
