1)
$env:COMPUTERNAMEšī komanda parāda datora nosaukumu.
Get-CimInstance -ClassName Win32_OperatingSystemkomanda, kas vaicā operētājsistēmas Windows informāciju.
$PSVersionTable.PSVersionkomanda, ko var izmantot, lai noteiktu čaulas versiju.
Get-Processkomanda, kas parāda visus pašlaik darbojošos procesus.
Count beigās tā aprēķina, cik procesu ir.

2)
Sort-Object -Property WorkingSetSakārto procesus pēc to RAM izmantošanas.
Select-Object Name, Id — Izvadei atlasa tikai procesa nosaukumu, tā ID un aprēķināto atmiņas lauku.
@{Name="Atmiņa (MB)"; Expression={...}}Aprēķinu bloks, kas konvertē baitus uz megabaitiem un formatē skaitli tā, lai tam būtu tieši viena zīme aiz komata.

3)
Get-Serviceiegūst visu datorā esošo pakalpojumu sarakstu.
Mēs definējam divus skaitītāja mainīgos ar vērtību 0: $runningCount un $stoppedCount.
foreach ($s in $services) sāk ciklu, kas pēc kārtas aplūko katru pakalpojumu (mēs to sauksim par $s).
if ($s.Status -eq 'Darbojas')pārbauda: ja pakalpojuma statuss ir "Darbojas", tad pievieno vienu tekošajam skaitītājam ($runningCount++).
elseif ($s.Status -eq 'Apturēts')ja statuss ir "Apturēts", tad palielina apturētā skaitītāja vērtību.
Visbeidzot, mēs pievienojam abus skaitļus mainīgajam $total un parādām rezultātus.

4)
Get-CimInstance -ClassName Win32_Serviceatrod visus pakalpojumus.
Where-Object filtri: mēs iekļaujam tikai tos, kuru startēšanas tips ir Automatic un stāvoklis ir Stopped.
Measure-Object saskaita atrasto elementu skaitu.
Nosacījuma perators if pārbauda: ja pakalpojumu nav, mēs rakstām tekstu par nulli.
Ja pakalpojumu ir vairāk nekā nulle, mēs parādām to nosaukumus un izmantojam komandu Start-Service ar parametru -WhatIf testēšanai vai bez tā reālai palaišanai.

5)
(Get-Date).AddHours(-48)ņem pašreizējo datumu un laiku un atņem no tiem tieši 48 stundas.
Get-WinEventizgūst notikumus no Windows sistēmas žurnāla. Parametrs Level=2 atlasa kļūdas (Error), un StartTime ierobežo meklēšanu pēc laika.
Group-Object ProviderName - grupē kļūdas pēc avota nosaukuma.
Sort-Object Count -Dilstošā secībā | Select-Object -First 1kārto grupas no lielākās līdz mazākajai un
ņem pašu pirmo rindu.

6)
Get-CimInstance -ClassName Win32_PnPSignedDriver Iegūst visu sistēmā parakstīto ierīču draiveru sarakstu.
Where-Object {$_.Manufacturer -ne 'Microsoft'} - Atlasa tikai tos, kuru ražotājs nav Microsoft.
Export-Csv - Saglabā iegūto tabulu CSV failā.
Import-Csv nolasa šo failu un izmanto .Count, lai aprēķinātu precīzu rindu skaitu.

7)
$warningLimitGB = 20 iestata brīdinājuma slieksni uz 20 gigabaitiem.
Get-CimInstance -ClassName Win32_LogicalDisk -Filter "DriveType=3"pieprasa informāciju tikai par datora cietajiem diskiem.
[Math]::Round(...,- 2)noapaļo skaitli līdz divām zīmēm aiz komata, lai nodrošinātu precīzu izvadi.
Dalot ar 1 GB, sistēmas atgrieztie baiti tiek konvertēti uz standarta gigabaitiem.         
Ja nosacījumsif ($freeGB -lt $warningLimitGB) salīdzina pašreizējo brīvo vietu ar
iestatīto ierobežojumu un parāda brīdinājumu, ja vietas ir maz.

8)
Measure-Command { ... } ir īpaša hronometra komanda, kas precīzi mēra,
cik milisekundes nepieciešamas, lai izpildītu tajā ietverto kodu.
Pirmā metode (Get-Service) ir standarta saīsne darbam ar pakalpojumiem.
Otrajai metodei (Get-CimInstance) var piekļūt, izmantojot CIM/WMI pakalpojumu.
.TotalMilliseconds no hronometra rezultāta iegūst precīzu
laiku milisekundēs.

9)
Get-Process iterē pa procesiem.
Konstrukcija try
{ ... } catch { ...} ļauj uztvert kļūdas: ja lietotājam nav atļaujas
ieskatīties citā sistēmas procesā, skripts neavārijas ar sarkanu kļūdas
ziņojumu, bet gan lietotāja laukā glīti ierakstīs statusu, piemēram, "Nav atļauju".

10)

Šis skripts vienkārši apkopo iepriekšējo uzdevumu komandu ātrās versijas, lai tās palaistu vienlaikus.
