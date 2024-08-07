# TSSR-2402-P3-G1-BuildYourInfra-BillU

## INSTALL GUIDE Infrastructure sécurisée pour BillU

### 1 - Journalisation des scripts

### 2	- Supervision ZABBIX



## 1 - JOURNALISATION - Mettre en place une journalisation des scripts PowerShell

Modifier les scripts que l'on veut journaliser en ajoutant au début : 

```powershell
$logFilePath = "C:\Logs\<nom_fichier>.log"
Start-Transcript -Path $logFilePath -Append
```
  
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Journalisation-001.PNG?raw=true)

  Puis à la fin
  
```powershell
Stop-Transcript
```
  
  
![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Journalisation-002.PNG?raw=true)

Les journaux sont disponibles dans le dossier `C:\Logs`

Nous pouvons aussi consulter les logs depuis l'Observateur d'Evenements

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Journalisation-003.PNG?raw=true)

## 2 - SUPERVISION - Mise en place d'une supervision de l'infrastructure réseau avec ZABBIX
⚠️ *Pour tous les champs `<mot_de_passe>` suivants, nous avons utilisé le même mot de passe : **`Azerty1*`***

## Installation  

### 1 . Téléchargement et mise à jour des dépôts ZABBIX :  

```bash
wget https://repo.zabbix.com/zabbix/7.0/debian/pool/main/z/zabbix-release/zabbix-release_7.0-1+debian12_all.deb
dpkg -i zabbix-release_7.0-1+debian12_all.deb
apt update
```

### 2 . Installation de ZABBIX Server, ZABBIX Frontend, et ZABBIX Agent :  

```bash
apt install zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-sql-scripts zabbix-agent
```

### 3 . Installation du socle LAMP :  

```bash
apt-get install apache2 php mariadb-server
```

### 4 . Création de la base de données initiale :  

```bash
mysql -uroot -p
<mot_de_passe>
mysql> create database zabbix character set utf8mb4 collate utf8mb4_bin;
mysql> create user zabbix@localhost identified by *<mot_de_passe>*;
mysql> grant all privileges on zabbix.* to zabbix@localhost;
mysql> set global log_bin_trust_function_creators = 1;
mysql> quit;
```


```bash
zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql --default-character-set=utf8mb4 -uzabbix -p zabbix
```

```bash
mysql -uroot -p
<mot_de_passe>
mysql> set global log_bin_trust_function_creators = 0;
mysql> quit;
```

### 5 . Edition du fichier `/etc/zabbix/zabbix_server.conf` :   

```bash
nano /etc/zabbix/zabbix_server.conf
```
Puis ajouter le mot de passe défini précédemment : 

```bash
DBPassword=<mot_de_passe>
```
### 6 . Démarrage du serveur et des agents ZABBIX

```bash
systemctl restart zabbix-server zabbix-agent apache2
systemctl enable zabbix-server zabbix-agent apache2
```

## Configuration

Se rendre sur un poste relié au réseau, ouvrir un navigateur web, et entrer l'adresse suivante :  
  
`<Adresse_IP_hôte>/zabbix`

![2024-06-13 16_01_49-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/46021452-6e8e-48e1-ad4e-2f1c3dac5134)


Selectionner la langue `Français (fr-FR)`, puis cliquer sur `Prochaine étape` 

L'écran suivant informe que les pré-requis à l'utilisation de ZABBIX sont `OK`, cliquer sur `Prochaine étape`

![2024-06-13 16_02_15-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a7699667-1490-4ffa-a5fa-da1715b001a0)

A cet écran, entrer les informations préalablement éditées lors de l'installation de ZABBIX, et cliquer sur `Prochaine étape`

![2024-06-13 16_02_45-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/9bc21551-8d65-4dcd-9f69-ccc37977537e)

A cet écran, définir le bon fuseau horaire, et cliquer sur `Prochaine étape`

![2024-06-13 16_04_08-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/0f01a5e4-83d1-47f7-a8a0-09cd2954c0b1)

Les deux écrans suivants indiquent un résumé de la pré-installation, et la confirmation de l'installation de l'interface de ZABBIX

![2024-06-13 16_04_21-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/29dfd66d-b7c4-4f47-bf12-9854e4969def)

![2024-06-13 16_04_35-QEMU (G1-Ubuntu-Client2) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/12da09b5-f685-40ff-8266-fcd1e90735b4)

## Installation de l'agent ZABBIX sur un client Linux

Se rendre sur la page officielle de ZABBIX pour obtenir les consignes d'installation de l'agent ZABBIX en fonction de l'OS : 

![2024-06-14 11_47_09-](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/1954c0a0-514a-4e08-b8b5-71988815f77d)

Ensuite, entrer les commandes comme indiqué sur le bas de la page : 

- Installation du dépôt ZABBIX :
```bash
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu24.04_all.deb
dpkg -i zabbix-release_7.0-1+ubuntu24.04_all.deb
apt update
```

- Installation de l'agent ZABBIX :
```bash
apt install zabbix-agent
```

- Edition du fichier de configuration de l'agent ZABBIX :
```bash
nano /etc/zabbix/zabbix_agentd.conf
```

Et éditer la ligne n°117 : `Server=<IP_du_serveur_zabbix>`

- Redémarrer l'agent ZABBIX, et le configurer pour un démarrage autoimatique :
```bash
systemctl restart zabbix-agent
systemctl enable zabbix-agent
```

- Vérifier le statut de l'agent ZABBIX (Il devrait être en statut `Active`):
```bash
systemctl status zabbix-agent
```

L'installation de l'agant ZABBIX est terminée.
