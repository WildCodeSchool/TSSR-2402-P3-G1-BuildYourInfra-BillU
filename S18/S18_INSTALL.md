# TSSR-2402-P3-G1-BuildYourInfra-BillU

## 1 - PingCastle

Se rendre sur le site https://www.pingcastle.com/

Cliquer sur FreeDownload

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Capture%20d'%C3%A9cran%202024-07-08%20103938.png?raw=true)

Un fois le fichier télécharger, le décompresser et lancer le fichier :

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-41-50%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

Suivez le script ouvert puis deux fichier vont être créé dans le même dossier ou cse trouve PingCastle

Nous allons étudier le .html

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-34-26%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-34-33%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-34-42%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-34-55%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/blob/main/RESSOURCES/Screenshot%202024-07-08%20at%2010-35-08%20wcs-cyber-node05%20-%20Proxmox%20Virtual%20Environment.png?raw=true)

![]()


## 2 - Serveur RADIUS : FREERADIUS sur PfSense

Un serveur RADIUS est utilisé dans le but d'authentifier les utilisateurs utilsant le réseau.  
Dans le cadre de notre projet, la fonction qui nous intéressera sera celle du "portail captif", une sorte de passerelle nécéssitant un identifiant et un mot de passe afin d'autoriser les utilisateurs à accéder au réseau Internet.  


### Installation de FREERADIUS sur Pfsense

Se rendre sur l'interface de gestion de PfSense, puis cliquer sur `System`, et sur `Package Manager`

![2024-07-09 14_13_05-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/858536e9-9b65-4632-bc3c-eb47ca5aa35b)

Cliquer sur `Available Packages`, puis cliquer sur le bouton `Install` au niveau du paquet nommé `freeradius3`

![2024-07-09 14_13_49-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/746b64ac-53b8-4d9d-b552-b9702f346d4b)
![2024-07-09 14_14_19-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7b8a168c-ce94-4395-8951-075d67d01d6f)


Cliquer ensuite sur `Confirm`, et patienter jusqu'à la fin de l'installation de `FREERADIUS`

![2024-07-09 14_15_41-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7e80f175-b8fb-447a-bf18-e8f0c15bc864)
![2024-07-09 14_16_00-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/88bff39f-7137-40ae-be1c-7d239a41cb64)
![2024-07-09 14_16_28-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7993bcbd-b934-4c29-beda-1b8ff76929dc)

### Configuration de FREERADIUS sur PfSense

## 3 - Serveur OpenVPN : OpenVPN sur PfSense

Dans l'optique d'un(e) partenariat / fusion entre les entreprises BillU et EcoTechSolutions, nous avons mis en place un tunnel VPN entre les réseaux de ces dernières.  
Cette liaison sécurisée a été possible grâce au service OpenVPN intégré directement sur le pare-feu PfSense.  

### Création et importation de certificats / clés TLS

Nous partons du principe que notre entreprise, BillU, se placera du côté "client VPN", et l'entreprise EcoTechSolutions du côté "serveur VPN".  
Les différents certificats ainsi que les clés TLS seront générés via le service OpenVPN de l'entreprise EcoTechSolutions, et envoyés (par exemple, par mail) sur le serveur principal de l'entreprise BillU.  
Vous pourrez retrouver la documentation concernant la génération de certificats et des clés TLS sur le fichier [`OpenVPN.md`](https://github.com/WildCodeSchool/TSSR-2402-P3-G2-BuildYourInfra-EcoTechSolutions/blob/main/S18/annex/OpenVPN.md) de l'entreprise EcoTechSolutions.  

Nous avons donc en notre possession 4 fichiers : 2 certificats en format `.crt`, une clé en format `.txt`, et une clé en format `.key`

### 1ère étape - Import des certificats/clés
  
Se rendre dans l'interface d'administration de PfSense, puis cliquer sur `System`, puis sur `Certificates`.  
  
Dans la section `Authorities`, cliquer sur le bouton `+ Add`, puis entrer les informations suivantes :   
- Descriptive Name : `OpenVPN_EcoTech_Auth`
- Method : `Import an existing Certificate Authority`
- Trust Store : Cocher la case
- Certificate data : Coller le contenu du fichier `OpenVPN_BillU_Auth.crt`, préalablement ouvert avec le bloc-notes de Windows

Une fois cela fait, cliquer sur `Save`

![2024-07-10 10_33_00-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/84141a13-4718-48f7-b99b-63ea851e51e5)
![2024-07-10 10_33_50-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/7205eef5-11d7-438d-bd10-66bad71f2868)

Cliquer maintenant sur `Certificates`, puis sur le bouton `+ Add`, et entrer les informations suivantes : 
- Méthod : `Importing an existing Certificate`
- Descriptive Name : `OpenVPN_EcoTech_Cert_CLI`
- Certificate Type : Laisser cochée la case `X.509 (PEM)`
- Certificate data : Coller le contenu du fichier `OpenVPN_BillU_Certificat_CLI.crt`, préalablement ouvert avec le bloc-notes de Windows
- Private key data : Coller le contenu du fichier `OpenVPN_BillU_Certificat_CLI.key`, préalablement ouvert avec le bloc-notes de Windows
  
Une fois cela fait, cliquer sur `Save` 

![2024-07-10 10_35_37-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/fd9b6cd4-c193-4a5a-a625-21365c537c07)
![2024-07-10 10_36_06-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/75c93e8b-3665-4aa7-8d25-bf43cce8e26d)
![2024-07-10 10_36_23-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/29067a21-86af-40d3-bae3-c705704bc655)

### 2ème étape - Configuration du "client" OpenVPN
  
Une fois les certificats importés, nous allons configurer le "client" OpenVPN : Cliquer en haut sur `VPN`, puis sur `OpenVPN`.  
Une fois arrivé ici, cliquer sur `Clients`, puis sur le bouton `+ Add`, et entrer les informations suivantes : 
- Description : `OpenVPN_EcoTech_CLI`
- Server mode : `Peer to Peer`
- Desvice Mode : `tun - layer 3 Tunnel Mode`
- Protocol : `UDP on IPv4 only`
- Interface : `WAN`
- Server host or address :  `10.0.0.3` *(Interface WAN du pare-feu PfSense de l'entreprise EcoTech)*
- Server Port : `1194` *(Port utilisé par OpenVPN)*
- TLS Configuration : `Use a TLS Key`
- TLS Key : Coller le contenu du fichier `TLS_KEY_OpenVPN.txt`
- Peer Certificate Authority : `OpenVPN_EcoTech_Auth`
- Client Certificate : `OpenVPN_EcoTech_Cert_CLI`
- IPv4 Tunnel Network : `10.0.8.0/30` *(Réseau utilisé pour la connexion VPN)*
- IPv4 Remote network(s) : `10.10.0.0/16` *(Réseau LAN de l'entreprise EcoTech)*
- Gateway creation : IPv4 only

Une fois cela fait, cliquer sur `Save` 

![2024-07-10 10_37_37-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/1fdd9429-af82-4818-8baa-8aa9c57f05c3)
![2024-07-10 10_38_19-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/dbadb7a9-5a20-4001-b736-bc11fd8aac3f)
![2024-07-10 10_39_24-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/cfb1fb93-49fc-4bf9-9f86-6734692dc6d9)
![2024-07-10 10_39_51-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/8396424f-97db-4672-a0e1-3cd1f820e59e)
![2024-07-10 10_40_31-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/22df5007-f4c9-4832-aefd-e07d635f18f6)
![2024-07-10 10_40_59-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/56809afa-4853-4219-b244-61f98d535f24)

### 3ème étape - Configuration de la nouvelle interface OpenVPN
  
Cliquer en haut sur `Interfaces`, puis sur `Assignements`  
Une fois dans cette section, cliquer sur le bouton `+ Add` en bas à droite, afin d'activer l'interface d'OpenVPN `OPT2`, pusi cliquer sur `OPT2` afin de la configurer avec les informations suivantes : 
- Enable : Cocher la case `Enable interface`
- Description : `OpenVPN`
  
Une fois cela fait, cliquer sur `Save` 

![2024-07-10 10_43_08-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a2994af9-604a-449b-b50a-551817e79a1d)
![2024-07-10 10_43_35-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/d9c6496f-d427-4d53-a617-1a5f00cfefc6)

### 4ème étape - Configuration des règles sur les interfaces d'OpenVPN
  
Cliquer en haut sur `Firewall`, puis sur `Rules`, puis sur l'interface `OPENVPN`, puis sur le bouton `Add`, et créer une règle qui autorise tout le trafic : 

![2024-07-10 10_45_32-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/9e5f8ca4-15aa-4183-8038-ae346323d1a8)

Faire de même avec l'interface `OpenVPN` : 

![2024-07-10 10_46_02-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/ab8ff722-3f10-42fe-9469-cb15b3cd837c)

### 5ème étape - Configuration du routage d'OpenVPN
  
Cliquer en haut sur `System`, puis `Routing`, puis `Static Routes`, puis sur le bouton `+ Add`, et entrer les informations suivantes : 
- Destination network : `10.10.0.0` *(Réseau LAN de l'entreprise EcoTech)*
- Gateway : `OPENVPN_VPNV4 - 10.0.8.1`
- Disabled : Laisser la case décochée
- Description : `Road_To_EcoTech`

Faire de même une nouvelle fois avec les informations suivantes : 
- Destination network : `10.11.0.0` *(Réseau DMZ de l'entreprise EcoTech)*
- Gateway : `OPENVPN_VPNV4 - 10.0.8.1`
- Disabled : Laisser la case décochée
- Description : `Road_To_EcoTech_DMZ`
  
![2024-07-10 11_33_36-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/159007018/a7ca7281-068f-4120-9af6-044047d0387b)

OpenVPN est désormais installé et configuré pour la communication entre les réseaux des deux entreprises


## 3  Bloodhound

BloodHound est un outil populaire utilisé pour cartographier les relations dans un domaine Active Directory et identifier des chemins d'attaque possibles. Il est souvent utilisé par les pentesters et les professionnels de la sécurité pour comprendre et exploiter les faiblesses d'une infrastructure AD.

### Étape 1 : Installer **Neo4j** et **BloodHound**
BloodHound utilise Neo4j comme base de données pour stocker les informations collectées. Pour installer Neo4j, suivez ces étapes :

Utilser la commande :

```
sudo apt update && sudo apt install -y bloodhound
```

![2024-07-10 10_56_28-QEMU (G1-Kali) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/789bbb41-bfe9-46d4-bde0-66612a6c376f)

Bloodhound est installé, nous allons lancer Neo4j avec la  commande :

```
sudo neo4j console
```

![2024-07-10 10_56_55-QEMU (G1-Kali) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/ee8b9f28-97ef-4914-a3ba-a6c46eb9536f)


Nous devons maintenant modifier les informations d'identification par défaut pour neo4j. Accédez aux http://localhost:7474/ et connectez-vous à celles-ci, avec l'utilisateur et le mot de passe ci dessous 

```
username: neo4j
password: neo4j
```


![2024-07-11 09_50_09-bloodhound _ Kali Linux Tools](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/4f06890b-9c9e-4ef4-8f1e-1b6f64c78942)

Après vous être connecté, il vous sera demandé de modifier le mot de passe par défaut par un nouveau. Vous aurez besoin de ce mot de passe pour vous connecter ultérieurement à l'interface de Bloodhound.

![2024-07-11 09_50_50-bloodhound _ Kali Linux Tools](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/c6737979-150f-4453-b382-d34f03b76288)

Maintenant que le mot de passe a été modifié avec succès, vous pouvez vous connecter sur **neo4j** avec votre nouveau mot de passe et vous pouvez enfin lancer **Bloodhound** avec les nouvelles informations d'identification.

![2024-07-11 09_51_41-QEMU (G1-Kali) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/a541d74d-ab5b-4354-bc79-c9ef19c57ebd)

![2024-07-11 10_02_49-QEMU (G1-Kali) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/6b47b4ea-d9b2-416e-94a5-db03d3621205)

![2024-07-10 10_57_47-QEMU (G1-Kali) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/94ecd37e-dc67-4a76-b8bc-672f1fa2bc52)


Bloodhound est installé est fonctionnel.

### Étape 2 : Installer **Sharphound**
SharpHound est l'outil de collecte de données utilisé par BloodHound pour explorer et cartographier les relations et les permissions dans un domaine Active Directory (AD).

Accédez à la page de [SharpHound](https://github.com/BloodHoundAD/SharpHound/releases) et téléchargez les fichiers zip dans leur versions les plus récentes sur l'AD visé ( le serveur qui contient l'AD de préférence )

![2024-07-11 10_16_43-Releases · BloodHoundAD_SharpHound](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/1b9b5133-eb84-41c1-b795-aaba082600d4)

**Attention WINDOWS considera le zip comme un élément dangereux et Windows Defender bloquera le téléchargement !** Désactivez le pour la mise en place et l'execution de celui-ci. 

Vous allez ensuite dezipper le dossier et vous rendre dans ce même dossier en ligne de commande et executer le fichier **SharpHound.exe**

![2024-07-11 10_26_06-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/5b8b0dda-47fc-41be-9f57-c784a021c6a6)

![2024-07-11 10_26_38-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/ba21154c-941c-462b-8b15-7873e8918e7b)

![2024-07-11 10_27_39-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/62fbe3ef-ef23-4315-8c02-3a95a2485ec2)

**SharpHound.exe** va extraire des fichiers en format **JSON** avec les différentes données de l'AD

![2024-07-11 10_28_10-QEMU (G1-WServer2022-GUI) - noVNC](https://github.com/WildCodeSchool/TSSR-2402-P3-G1-BuildYourInfra-BillU/assets/161461625/f888e9cc-0b77-42a7-b505-8c21479fabe8)

Vous allez transférer le dossier sur votre **Kali** et téléchargez les fichiers ZIP générés par SharpHound dans l'interface BloodHound. Utilisez l'option "Upload Data" pour importer les fichiers dans la base de données Neo4j.

Bonne chance pour la suite

