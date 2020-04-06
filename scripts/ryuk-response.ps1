###        Ryuk Response Script         ###
###  Author: Robin Dimyanoglu (@1ce7ea) ###

# 1) Run\svchos keyinin degerini al
# 2) O pathe git, dosyayi oradan al ve masaustune .malware uzantısıyla tasi
# 3) Run\svchos keyini sil
# 4) Bilgisayara reboot at


$ryuk_path = (Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'svchos').svchos
$desktop_path = [Environment]::GetFolderPath("Desktop")
$destination_file_name = "infected_file.malware"
$destination_path = Join-Path $desktop_path $destination_file_name
Move-Item -Path $ryuk_path -Destination $destination_path
Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name 'svchos'
Restart-Computer
