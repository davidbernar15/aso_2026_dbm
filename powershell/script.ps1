[long]$tamanoBackup = 2199023255552

[decimal]$costeLicencia = 149.95
[decimal]$iva = 31.49

$totalFactura = $costeLicencia + $iva

Write-Host "Total de la factura: $totalFactura euros"
