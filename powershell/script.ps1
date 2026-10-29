$fechaActual = Get-Date

Write-Host "Año actual: $($fechaActual.Year)"
Write-Host "Caducidad de la contraseña: $($fechaActual.AddDays(45))"

$inicio = Get-Date
Start-Sleep -Seconds 3
$fin = Get-Date

[TimeSpan]$tiempoTotal = $fin - $inicio

Write-Host "Segundos transcurridos: $($tiempoTotal.TotalSeconds)"
