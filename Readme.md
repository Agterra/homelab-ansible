# Ansible for deploying containers and apps at home

This project aims to facilitate the deployment and maintenance of applications on an home server or others.

# Installation
- Run `make init`, it will create a `.passwords` folder at the root of your project, as well as initializing the githooks
- Inside the inventory folder, copy the `example` and adapt it to your convenience

And that's it !

# Usage
- From the root of this directory, you can create the stack by simply calling:
```
make deploy USER=xxxx PORT=xxx DOMAIN="xxxx.com" TAGS="all,create"
```

USER is the specified user for ssh connection, using local $USER otherwise

PORT is the ansible_port variable for ssh connection

DOMAIN is what your existing domain is. It will be used for routing containers with traefik (cf. the docker-compose.yml.j2 files in templates)

TAGS are all ansible tags we can use, there is a listing [here](#available-tags)

# Available Tags
You can specify which app you want to deploy, currently supporting:
- "traefik"
- "minio"
- "authentik"
- "gitea"
- "nextcloud"
- "pihole"
- "llm"
- "template" // For testing purposes

You also have to specify a tag that will tell the docker role which action he has to take. Currently avaible actions are:
- "create":
    - Creates the directories, copies the templates and starts the containers
- "update"
    - Deletes the containers while keeping the volumes, updates the templates and starts the containers
- "delete"
    - Deletes the containers, their volumes and the directory (Backup before if needed!)
- "restart"
    - Restarts the containers
- "stop"
    - Stop the containers

Some examples:

- I want to deploy traefik, authentik, minio:
```
make deploy USER=xxxx PORT=xxx DOMAIN="xxxx.com" TAGS="treafik,authentik,minio,create"
```

- Now, I want to delete minio:
```
make deploy USER=xxxx PORT=xxx DOMAIN="xxxx.com" TAGS="minio,delete"
```

- Oh I forgot something in my traefik conf, I want to update it:
```
make deploy USER=xxxx PORT=xxx DOMAIN="xxxx.com" TAGS="traefik,update"
```