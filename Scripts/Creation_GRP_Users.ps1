Import-Module ActiveDirectory #(commenter si le module Active Directory est déjà importer)

$csvPath = "path\to\your\CSV_Master.csv"
$baseOU = "OU=BillU-Users,DC=BillU,DC=lan"

# Importer le fichier CSV
$csv = Import-Csv -Path $csvPath

# Get unique combinations of OU and Groupe_Departement, excluding rows with "NA"
$uniqueDeptGroups = $csv | Where-Object { $_.OU -ne "NA" -and $_.Groupe_Departement -ne "NA" } | Select-Object -Property OU, Groupe_Departement -Unique

# Boucle pour chaque combinaison unique d'OU et Groupe_Departement
foreach ($item in $uniqueDeptGroups) {
    $ou = $item.OU
    $groupDept = $item.Groupe_Departement
    $ouPath = "OU=$ou,$baseOU"
    
    # Vérification si le groupe existe,sinon, création
    if (-not (Get-ADGroup -Filter {Name -eq $groupDept} -SearchBase $ouPath -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $groupDept -GroupScope Global -GroupCategory Security -Path $ouPath
        Write-Host "Le groupe $groupDept a été créé dans l'OU $ou"
    } else {
        Write-Host "Le groupe $groupDept existe dejà dans l'OU $ou"
    }
}

# Boucle pour chaque combinaison unique de SousOU et Groupe_Service, exclu les lignes avec "NA"
$uniqueServiceGroups = $csv | Where-Object { $_.SousOU -ne "NA" -and $_.Groupe_Service -ne "NA" } | Select-Object -Property OU, SousOU, Groupe_Service -Unique

#  Boucle pour chaque combinaison unique de SousOU et Groupe_Service
foreach ($item in $uniqueServiceGroups) {
    $ou = $item.OU
    $sousOU = $item.SousOU
    $groupService = $item.Groupe_Service
    $ouPath = "OU=$sousOU,OU=$ou,$baseOU"
    
    # Vérification si le groupe existe,sinon, création
    if (-not (Get-ADGroup -Filter {Name -eq $groupService} -SearchBase $ouPath -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $groupService -GroupScope Global -GroupCategory Security -Path $ouPath
        Write-Host "Le groupe $groupService a été créé dans la sous-OU $sousOU de l'OU parente $ou"
    } else {
        Write-Host "Le groupe $groupService existe dejà dans la sous-OU $sousOU de l'OU parente $ou"
    }
}
