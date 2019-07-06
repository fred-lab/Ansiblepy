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

Create the .vault-pass file : ```touch .vault_pass```  

Update **hosts** with a server name and an IP adress  

Update **parameters.yml** with adequate information :
TODO

- In the **vault** section, you must replace the values with your passwords. You need a password for the database root access. You can encrypt your password with this command:
```ansible-vault encrypt_string -vvv --vault-password-file .vault_pass ```  

Connect to the Raspberry serveur with SSH. To run Ansible, the raspberry must have **Python** : ```ssh username@raspberry_adress``` 

**Distant server**

Run the installation : ```ansible-playbook -i hosts raspberry.yml --flush-cache --vault-password-file .vault_pass --force-handler```  

Deploy an app : ```ansible-playbook -i hosts deploy_bokehlicious_prod.yml  --flush-cache --vault-password-file .vault_pass --force-handler```  
 

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
