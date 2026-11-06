$dn = "CN=Beatriz,OU=Ventas,DC=dominio,DC=local"
Write-Host ($dn.Split(",")[0].Split("=")[1])