# inception

## Table of Contents

- [Overview](#overview)
- [Installation](#installation)
- [Project Architecture](#project-architecture)
- [Project Directory Structure](#project-directory-structure)
- [Bonus Features](#bonus-features)

## Overview

This project is a system administration exercise that demonstrates a comprehensive Docker infrastructure. The implementation sets up a small, robust infrastructure with multiple interconnected services running in isolated containers.

## Installation

### Clone the GitHub repository

```bash
git clone https://github.com/fanchymarin/inception.git
```

### Load the environment variables

This may be done by creating a `.env` file in the `srcs` directory with the following content:

```bash
DOMAIN_NAME=<your_domain_name>
WP_NAME=<your_wordpress_name>
WP_DATABASE=<your_wordpress_database>
WP_USER=<your_wordpress_user>
WP_PASSWORD=<your_wordpress_password>
WP_EMAIL=<your_wordpress_email>
WP_ADMIN_USER=<your_wordpress_admin_user>
WP_ADMIN_PASSWORD=<your_wordpress_admin_password>
WP_ADMIN_EMAIL=<your_wordpress_admin_email>
FTP_USER=<your_ftp_user>
FTP_PASSWORD=<your_ftp_password>
```

### Build the Docker containers

```bash
make
```

### Access the website

- Open a web browser and navigate to `https://<DOMAIN_NAME>`

### Access the database through Adminer

- Open a web browser and navigate to `https://<DOMAIN_NAME>/adminer.php`

### Access the FTP Server

- Use an FTP client to connect to the server with the following credentials:
  - Host: `<DOMAIN_NAME>`
  - Username: `<FTP_USER>`
  - Password: `<FTP_PASSWORD>`

### Clean Up

```bash
make fclean
```

## Architecture

### Infrastructure Components
- An NGINX container configured with TLSv1.2 or TLSv1.3
- A WordPress container running php-fpm
- A MariaDB container
- Two dedicated volumes:
  1. A volume for the WordPress database
  2. A volume for WordPress website files
- A custom Docker network connecting all containers

### Technical Implementation
- Developed within a Virtual Machine
- Orchestrated using Docker Compose
- Each service isolated in its own container
- Built using Alpine or Debian (penultimate stable version)
- Custom Dockerfiles are created for each service
- Implements a custom network configuration in `docker-compose.yml`

### Domain and Access
- Configured with a custom domain `login.42.fr`
- NGINX serves as the sole entry point
- Accessible exclusively via port 443
- Secured with TLSv1.2 or TLSv1.3 protocol

### Database Configuration
- MariaDB container is set up with two distinct users
- Administrator account is carefully named to avoid default patterns

### Security and Environment Management
- Utilizes environment variables for configuration
- Stores sensitive information in a `.env` file to ensure no passwords are hardcoded in Dockerfiles
- Volumes are made available in `/home/<user>/data`

## Directory structure

```bash
inception/
│
├── Makefile
│
└── srcs/
    ├── docker-compose.yml
    ├── .env
    └── requirements/
        ├── mariadb/
        │   ├── Dockerfile
        │   └── ...
        ├── nginx/
        │   ├── Dockerfile
        │   └── ...
        ├── wordpress/
        │   ├── Dockerfile
        │   └── ...
        └── bonus/
            ├── adminer/
            └── ...

```

## Bonus Features
Extended functionality includes:
- Redis cache integration for WordPress
- FTP server for WordPress volume management
- Static website deployment
- Adminer for database management
