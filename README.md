# AnsiblePy

## Pre-requirement
- Raspian
- Python

## Installation
**Host**  

Clone the repo: ```git clone https://github.com/fred-lab/Ansible.git```  

Install Ansible + Python: ```pacman -S ansible python```

Create **parameters.yml** file : ```cp parameters.yml parameters.yml.dist```  

Create **hosts** file : ```cp hosts.yml hosts.yml.dist```  

Create the **.vault-pass file** : ```touch .vault_pass```  

Update **hosts** with a server name and an IP adress  

Update **parameters.yml** with adequate information :
*TODO*

- In the **vault** section, you must replace the values with your passwords. You need a password for the database root access. You can encrypt your password with this command:
```ansible-vault encrypt_string -vvv --vault-password-file .vault_pass ```  

**Distant server**
- Connect to raspberry py using ssh with the default Pi user, to add the key to your local *~/.ssh/known_hosts file* (***Only do that at the first startup***) : ```ssh pi@raspberry_ip```  

*Note : if you reinstall from scratch the raspberry, you have to remove the corresponding key in ~/.ssh/known_hosts*

- Delog Pi user from the raspberry py

- Run the installation **for all the playbook** : ```ansible-playbook -i hosts install.yml --flush-cache --vault-password-file .vault_pass --force-handler```  

If you want to run a specific playbook, they are all in the **raspberry** folder, replace **install.yml** by the specific playbook, like :
```ansible-playbook -i hosts raspberry/docker.yml --flush-cache --vault-password-file .vault_pass --force-handler```   

## User
For security purpose, the logic is to have one superuser with Sudo privilege and create user with no password and no root access to each application. Their names correspond to the name application. 
This users can only access to theirs **home** folder, which contains the application.  
For the database, its the same logic, one user for one database, and the user can only access to his own database. 

## VIM
Go to insert mode : ```i```  
Echap insert mode : esc button  
Save (not in insert mode ): ```:x```

## Ansible Usefull commands
```ansible all -m ping -i hosts -u pi``` : Ping all host from the specified inventory **hosts** with the user **pi**  

```ansible-playbook -i hosts raspberry.yml``` : Run the playbook to install the raspberry

```ansible-vault encrypt_string -vvv ``` : Encrypt a string (like a password)

```ansible-vault encrypt_string -vvv --vault-password-file .vault_pass ``` : Encrypt a string (like a password) with a file who contain a password to decrypt encrypted passwords. You must create this file.

```ansible-playbook -i hosts raspberry.yml --flush-cache --ask-vault-pass``` : Run the playbook, and ask for a password to decrypt encrypted passwords.

```ansible-playbook -i hosts raspberry.yml --flush-cache --vault-password-file .vault_pass``` : Run the playbook, with a file who contain a password to decrypt encrypted passwords. You must create this file.

# Pihole & Openvpn  
To connect to my home network from outside, I can use Openvpn to reach my private network. Openvpn is bound to the Pihole's DNS, so ads are filtered.  

## Pihole  
My ISP modem don't allow me to use a custom DNS & use the Pi as a DHCP server don't work, so I use a static IP on each of my device and specify the LAN IP adress of the Pi as DNS to use.  

## Openvpn  
1 - On the ISP Modem, redirect all the trafic from the port 1194/UDP to the LAN IP of the raspeberry Pi.

2 - I use the kylemanna's Openvpn docker image, with a docker-compose, link to the doc : https://github.com/kylemanna/docker-openvpn/blob/master/docs/docker-compose.md

3 - Generate a Client certificate, connect to the Pi with SSH, and go to : ```cd pihole/install``` and run ```export CLIENTNAME="your_client_name"``` & ```docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME```

4 - Get the client certificate : ```docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > $CLIENTNAME.ovpn```  

5 - Copy the certificate to the host : ```scp pihole_username@raspberry_ip:pihole/install/your_client_name.ovpn ~/Documents```  
https://www.raspberrypi.org/documentation/remote-access/ssh/scp.md

6 - Use an Openvpn Client with the client certificate to connect to the home network.  

 ## Links
 https://demyx.sh/tutorial/how-to-run-openvpn-and-pi-hole-using-docker-in-a-vps/#settingup-openvpn  
 https://visibilityspots.org/dockerized-cloudflared-pi-hole.html  
