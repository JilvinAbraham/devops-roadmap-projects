# Ansible Project: Server Configuration Management

This project is an Ansible-based solution for automating the configuration and management of servers. It includes roles for setting up a base environment, installing and configuring Nginx, deploying a static website, and managing SSH access.

## Roles Overview

### 1. Base Role
- Updates the apt cache and upgrades packages.
- Installs common utilities like `curl`, `htop`, `git`, and `unzip`.
- Installs and ensures the `fail2ban` service is running for security.

### 2. Nginx Role
- Installs the Nginx web server.
- Ensures the Nginx service is running and enabled.

### 3. App Role
- Uploads a static site archive (`site.tar.gz`) to the server.
- Extracts the archive to the Nginx root directory.
- Removes the archive after extraction.

### 4. SSH Role
- Creates the `.ssh` directory for the user if it doesn't exist.
- Adds a public SSH key to the `authorized_keys` file for secure access.

## Inventory

The inventory file ([inventory/host.ini](ansible-project/inventory/host.ini)) specifies the target hosts for the playbook. 


