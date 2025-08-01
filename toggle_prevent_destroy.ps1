# PowerShell script to toggle prevent_destroy settings across all Terraform resources
# Usage: .\toggle_prevent_destroy.ps1 [enable|disable]

param(
    [Parameter(Mandatory=$true)]
    [ValidateSet("enable", "disable")]
    [string]$Action
)

if ($Action -eq "enable") {
    Write-Host "Enabling prevent_destroy on all resources..." -ForegroundColor Green
    
    # Replace false with true
    Get-ChildItem -Path . -Filter "*.tf" -Recurse | ForEach-Object {
        (Get-Content $_.FullName) -replace 'prevent_destroy = false', 'prevent_destroy = true' | Set-Content $_.FullName
    }
    
    # Uncomment commented prevent_destroy lines
    Get-ChildItem -Path . -Filter "*.tf" -Recurse | ForEach-Object {
        (Get-Content $_.FullName) -replace '# *prevent_destroy = true', 'prevent_destroy = true' | Set-Content $_.FullName
        (Get-Content $_.FullName) -replace '#   prevent_destroy = true', '    prevent_destroy = true' | Set-Content $_.FullName
        (Get-Content $_.FullName) -replace '#     prevent_destroy = true', '      prevent_destroy = true' | Set-Content $_.FullName
    }
    
    Write-Host "✅ prevent_destroy = true enabled on all resources" -ForegroundColor Green
    
} elseif ($Action -eq "disable") {
    Write-Host "Disabling prevent_destroy on all resources..." -ForegroundColor Yellow
    
    # Replace true with false
    Get-ChildItem -Path . -Filter "*.tf" -Recurse | ForEach-Object {
        (Get-Content $_.FullName) -replace 'prevent_destroy = true', 'prevent_destroy = false' | Set-Content $_.FullName
    }
    
    Write-Host "✅ prevent_destroy = false set on all resources" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "🔍 Current prevent_destroy settings:" -ForegroundColor Cyan
Select-String -Path "*.tf" -Pattern "prevent_destroy =" -Recurse | Select-Object -First 10

Write-Host ""
Write-Host "⚠️  Remember to run 'terraform plan' to validate the changes" -ForegroundColor Yellow
