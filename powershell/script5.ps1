

$inventarioCrudo = @"
DEV-01 | MAC:00-1A-2B-3C-4D-5E | RAM:512MB | SN:a1b2 | STATUS:ACTIVE
switch_core_02 | MAC:001a.2b3c.4d5f | RAM:2GB | SN:X9Y8Z | STATUS:MAINTENANCE
router-edge-03 | MAC:00-1A-2B-3C-4D-60 | RAM:1024MB | SN:f4e3d2 | STATUS:ACTIVE
core_switch_04 | MAC:00:1a:2b:3c:4d:61 | RAM:4GB | SN:7m8n | STATUS:RETIRED
"@

$lineas=$inventarioCrudo.Split("`n")

$inventario=foreach($linea in $lineas){
    $partes=$linea -split "\|"
    $equipos=$partes[0].trim()
    $mac=$partes[1].trim()
    $ram=$partes[2].trim()
    $sn=$partes[3].trim()
    $status=$partes[4].trim()

    #descartar retired

    $statusreal=$status.split(":")[1].trim()

    if ($statusreal -ne "RETIRED") {
    


        #Device

        $equipos=$equipos.ToLower().Replace("_","-")


        #mac

        $mac=$mac.Replace("MAC:","").replace("-","").replace(".","").replace(":","").toupper()
        $macsalida = "$($mac.Substring(0,2)):$($mac.Substring(2,2)):$($mac.Substring(4,2)):$($mac.Substring(6,2)):$($mac.Substring(8,2)):$($mac.Substring(10,2))"

        #ram core_switch_04 | MAC:00:1a:2b:3c:4d:61 | RAM:4GB | SN:7m8n | STATUS:RETIRED

        $ram=$ram.replace("RAM:","")

        #status

        $status=$status.replace("STATUS:","")

        #serialnumber

        $sn=$sn.ToUpper().replace("SN:","")

        #añadir 0 a la izquierda hasta que el numero tenga 6 digitos.

        $snsalida=$sn.PadLeft(6,"0")

        [PSCustomObject]@{
            method = $objeto
            CleanPath = $rutalimpia
            MaskedIP = $ip2
            ErrorCode = $fallolimpio
            Agent = $agente2

        }

    }

}
