# Docker for Raspberry pi
Ansible playbook to install Docker and Docker-compose on a raspberry py (raspbian)

## Pre-requirement
- Raspian
- Python

## Installation 

- Edit *./defaults/main.yml* with yours information :

> docker_host_os: debian
> docker_host_os_release: stretch
> docker_host_arch: amd64
> docker_version: stable
> docker_users: 
>  - user1
>  - user2

- Run the playbook : ```ansible-playbook -i hosts raspberry/docker.yml --flush-cache  --force-handler``` 