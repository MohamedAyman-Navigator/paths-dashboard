$connectionString = "postgresql://postgres:MUgkEUfaUYXzGWXToHLjYaqquZCUEWVC@hopper.proxy.rlwy.net:19239/railway"

Write-Host "Setting up Railway PostgreSQL database..." -ForegroundColor Cyan
Write-Host ""

# Read SQL files
$schemaPath = Join-Path $PSScriptRoot "database\schema.sql"
$seedPath = Join-Path $PSScriptRoot "database\seed.sql"

if (-not (Test-Path $schemaPath)) {
    Write-Host "Error: schema.sql not found!" -ForegroundColor Red
    exit 1
}

if (-not (Test-Path $seedPath)) {
    Write-Host "Error: seed.sql not found!" -ForegroundColor Red
    exit 1
}

# Execute schema
Write-Host "Executing schema.sql..." -ForegroundColor Yellow
& psql $connectionString -f $schemaPath 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Schema created successfully!" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to create schema" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Execute seed data
Write-Host "Executing seed.sql..." -ForegroundColor Yellow
& psql $connectionString -f $seedPath 2>&1

if ($LASTEXITCODE -eq 0) {
    Write-Host "✓ Seed data loaded successfully!" -ForegroundColor Green
} else {
    Write-Host "✗ Failed to load seed data" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "✅ Database setup complete!" -ForegroundColor Green
Write-Host ""
Write-Host "Default admin account:" -ForegroundColor Cyan
Write-Host "  Email: admin@example.com"
Write-Host "  Password: admin123"
Write-Host ""
Write-Host "⚠️  Remember to change the admin password after deployment!" -ForegroundColor Yellow
