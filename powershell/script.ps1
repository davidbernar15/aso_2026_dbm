
$logCrudo = @"
[INFO] ID:8842 :: 2023/11/01_10:00 :: User:admin_01 :: Action:Login_Success
[ERROR] ID:9921 :: 2023/11/01_10:05 :: User:guest_user :: Action:Auth_Fail (Pass)
[WARN] ID:8843 :: 2023-11-01 10:15 :: User:dev_team :: Action:Upload_Limit_Exceeded
[CRITICAL] ID:1001 :: 01-11-2023_10:20 :: User:ROOT :: Action:Service_Stop
"@

$lineas = $logCrudo -split "`r?`n"
$resultados = @()

foreach ($linea in $lineas) {

    if ($linea -match '^\[(.*?)\]\s*ID:(\d+)\s*::\s*(.*?)\s*::\s*User:(.*?)\s*::\s*Action:(.*)$') {

        $gravedad = $matches[1].ToLower()
        $id = $matches[2]
        $fechaOriginal = $matches[3]
        $usuario = $matches[4].ToLower()
        $accion = $matches[5].ToLower()

        # Ignorar INFO
        if ($gravedad -eq "info") {
            continue
        }

        # Corregir fechas
        if ($fechaOriginal -match '^(\d{4})/(\d{2})/(\d{2})_(\d{2}):(\d{2})$') {
            $fecha = "$($matches[1])-$($matches[2])-$($matches[3]) $($matches[4]):$($matches[5])"
        }
        elseif ($fechaOriginal -match '^(\d{4})-(\d{2})-(\d{2}) (\d{2}):(\d{2})$') {
            $fecha = $fechaOriginal
        }
        elseif ($fechaOriginal -match '^(\d{2})-(\d{2})-(\d{4})_(\d{2}):(\d{2})$') {
            $fecha = "$($matches[3])-$($matches[2])-$($matches[1]) $($matches[4]):$($matches[5])"
        }

        # Cambiar ROOT por administrator
        if ($usuario -eq "root") {
            $usuario = "administrator"
        }

        # Crear objeto
        $objeto = [PSCustomObject]@{
            ID       = $id
            Fecha    = $fecha
            Usuario  = $usuario
            Gravedad = $gravedad
            Accion   = $accion
        }

        $resultados += $objeto
    }
}

# Exportar a CSV
$resultados | Export-Csv -Path "reporte_seguridad.csv" -NoTypeInformation -Encoding UTF8
