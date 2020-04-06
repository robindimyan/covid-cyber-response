$desktop_path = [Environment]::GetFolderPath("Desktop")
$app_data_directory = $env:APPDATA

$infected_tasks = Get-ScheduledTask | Where-Object {$_.Actions.Execute -Like "*$app_data_directory*" -Or $_.TaskPath -Like "*$app_data_directory*"}

Foreach ($task in $infected_tasks) {
    
    $executable_file = $task.Actions.Execute
    $executable_path = $executable_file.Trim('"')

    $executable_file_name = Split-Path $executable_path -leaf
    $executable_file_name = $executable_file_name

    $destination_file_name = "$executable_file_name.malware"
    $destination_path = Join-Path $desktop_path $destination_file_name

    Move-Item -Path $executable_path -Destination $destination_path -Force
    Unregister-ScheduledTask -TaskName $task.TaskName -Confirm:$false
    Restart-Computer
}

