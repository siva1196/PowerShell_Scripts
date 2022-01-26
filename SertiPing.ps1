Do{
    $Servers = @()
    $IP = @()
    $Location = @()
    $PManager = @()
    $ServerDownCount = 0

    $ServerList = Import-csv 'C:\Users\coramals\Desktop\Serti.csv' |`

    ForEach-Object{

        $Servers+=$_.Server
        $IP+=$_."IP Address"
        $Location+=$_.Location
        $PManager+=$_."Plant manager"

    }

    Write-Host(Get-Date)

    foreach ($Server in $Servers){

        $Ping = Test-Connection -ComputerName $Server -Count 1 -Quiet

            if($Ping){ 

                Write-Host "$Server is Online" -BackgroundColor Green

            }

            else {
        
                Write-Host "$Server is Offline" -BackgroundColor Red
                $ServerDownCount +=1
            }

        }
        Write-Host "Server down Count = $ServerDownCount"

        Write-Host -NoNewline "Pausing "

        for($s=0; $s -le 5; $s++){

            Write-Host -NoNewline "."
            Start-Sleep 3
        }

        Write-Host ""
}

while($true)