###        N2019CoV Response Script         ###
###  Author: Robin Dimyanoglu (@1ce7ea) ###

# 1) Run\2019nCoV keyinin degerini al
# 2) O pathe git, dosyayi oradan al ve masaustune .malware uzantısıyla tasi
# 3) Run\2019nCoV keyini sil
# 4) Bilgisayara reboot at


$n2019cov_path = (Get-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name '2019nCoV').2019nCoV
$desktop_path = [Environment]::GetFolderPath("Desktop")
$destination_file_name = "infected_file.malware"
$destination_path = Join-Path $desktop_path $destination_file_name
Move-Item -Path $n2019cov_path -Destination $destination_path
Remove-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Run' -Name '2019nCoV'
Restart-Computer
