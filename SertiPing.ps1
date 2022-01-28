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
    
    Write-Host ""
    Write-Host(Get-Date)
    Write-Host ""
    Write-Host "*********SERTI**********"
    Write-Host ""

    foreach ($Server in $Servers){

        $Ping = Test-Connection -ComputerName $Server -Count 1 -Quiet

            if($Ping){ 

                $Status = "Online"

                $obj = new-object psobject -Property @{

                    Server = $server
                    Status = $Status
                } 

            }

            else {
        
                $Status = "Offline"

                $obj = new-object psobject -Property @{

                    Server = $server
                    Status = $Status
                } 

                $ServerDownCount +=1
            }

            $obj
        }
        $obj = $null

        Write-Host ""
        Write-Host "Server down Count = $ServerDownCount"
        Write-Host ""
        Write-Host -NoNewline "Pausing "

        for($s=0; $s -le 5; $s++){

            Write-Host -NoNewline "."
            Start-Sleep 3
        }

        Write-Host ""
}

while($true)