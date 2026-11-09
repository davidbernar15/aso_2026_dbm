
$logCrudo = @"
[INFO] ID:8842 :: 2023/11/01_10:00 :: User:admin_01 :: Action:Login_Success
[ERROR] ID:9921 :: 2023/11/01_10:05 :: User:guest_user :: Action:Auth_Fail (Pass)
[WARN] ID:8843 :: 2023-11-01 10:15 :: User:dev_team :: Action:Upload_Limit_Exceeded
[CRITICAL] ID:1001 :: 01-11-2023_10:20 :: User:ROOT :: Action:Service_Stop
"@

$lineas=$logCrudo.Split("`n")

$reportes=foreach($linea in $lineas){
    if ($linea.Substring(1,4) -eq "INFO") {
        continue
    }
    $partes=$linea -split "::"
    $id=$partes[0]
    $fecha=$partes[1]
    $user=$partes[2]
    $accion=$partes[3]





    $id=$id.replace("[","").replace("]","").replace("ID:","")
    $fallo=$id.Split(" ")[0]
    $identificador=$id.split(" ")[1]


    $fecha_hora=$fecha.Replace("_"," ").replace("/","-")
    $fecha_list=$fecha_hora.trim().Split(" ")
    $fecha=$fecha_list[0]
    $hora=$fecha_list[1]

    $horas=$hora.split(":")[0]
    $minutos=$hora.split(":")[1]

    if ($fecha[2] -eq "-") {
        $dia=$fecha.Split("-")[0]
        $mes=$fecha.Split("-")[1]
        $anio=$fecha.Split("-")[2]
    } else {
        $dia=$fecha.Split("-")[2]
        $mes=$fecha.Split("-")[1]
        $anio=$fecha.Split("-")[0]        
    }
    $fechalimpia=Get-Date -Year $anio -Month $mes -day $dia -Hour $horas -Minute $minutos


    $user=$user.ToLower().replace("user:","").trim()
    if ($user -eq "root") {
        $user=$user.Replace("root","administrador")
    }


    $accion=$accion.replace("Action:", "").trim()



    [PSCustomObject]@{
        Timesstamp = $fechalimpia
        severity = $fallo
        User = $user
        EventID = $identificador
        Action = $accion
    }
}
$reportes | Export-Csv "reporte_seguridad.csv" -Encoding UTF8
