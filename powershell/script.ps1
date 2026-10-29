[int]$maxConexiones = 100
[bool]$firewallActivo = $true 

$maxConexiones = "Cien"

# No se puede convertir el valor "Cien" al tipo "System.Int32". Error: "La cadena de entrada no tiene el 
# formato correcto."
# En C:\Users\david.bermar.4\Desktop\practicas\cloud\Practicas_aso\powershell\script.ps1: 4 Carácter: 1
# + $maxConexiones = "Cien"
# + ~~~~~~~~~~~~~~~~~~~~~~~
#    + CategoryInfo          : MetadataError: (:) [], ArgumentTransformationMetadataException
#    + FullyQualifiedErrorId : RuntimeException
 