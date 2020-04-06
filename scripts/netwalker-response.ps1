###     Netwalker Response Script       ###
###   Author: Ahmet Kotan (@0r1gamic)   ###

# 1) Pathinde %TEMP% geçen prosesleri bul
# 2) Buldugun tum prosesleri durdur
# 3) Zararliyi bulundugu konumdan masaustune .malware uzantisiyla tasi


$tmp_path = $env:TEMP
$infected_processes = Get-Process | Where-Object {$_.Path -Like "*$tmp_path*"}

Foreach ($process in $infected_processes) {
    $description = $process.Description.ToLower()
    $company = $process.Company.ToLower()
    
    IF ($description -Like "*wtv*" -And $company -Like "*microsoft*") {
        Write-Host "Netwalker Detected."

        $infected_pid = $process.Id
        $infected_wmi = Get-WmiObject -Class Win32_Process | Where-Object {$_.ProcessId -Eq $infected_pid}
        $executable_path = $infected_wmi.ExecutablePath
        $infected_name = $infected_wmi.Name

        $desktop_path = [Environment]::GetFolderPath("Desktop")
        $destination_file_name = "$infected_name.malware"
        $destination_path = Join-Path $desktop_path $destination_file_name

        Stop-Process -Id $infected_pid -Force
        Move-Item -Path $executable_path -Destination $destination_path
    }

}

