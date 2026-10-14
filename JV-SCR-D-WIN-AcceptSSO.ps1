$AADPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\AAD"
$ValueName = "AutoAcceptSsoPermission"
$ValueData = 1

if (-not (Test-Path -LiteralPath $AADPath)) {
    New-Item -Path $AADPath -Force | Out-Null
}

New-ItemProperty `
    -Path $AADPath `
    -Name $ValueName `
    -PropertyType DWord `
    -Value $ValueData `
    -Force | Out-Null

$ConfiguredValue = Get-ItemPropertyValue `
    -Path $AADPath `
    -Name $ValueName `
    -ErrorAction SilentlyContinue

if ($ConfiguredValue -eq 1) {
    Write-Output "AutoAcceptSsoPermission has been configured successfully."
    exit 0
}
else {
    Write-Error "AutoAcceptSsoPermission could not be configured."
    exit 1
}