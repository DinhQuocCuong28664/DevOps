# Midterm Project: Software Deployment, Operations And Maintenance

This repository constitutes the comprehensive framework for the Midterm project of the **Software Deployment, Operations And Maintenance** course. It contains the source code for the application (Product API + UI) alongside deployment configurations progressively implemented across different phases.

## Directory Structure

- `src/`: Source code of the Node.js application (Express + MongoDB). Refer to [src/README.md](src/README.md) for detailed information.
- `scripts/`: Contains automation shell scripts, such as `setup.sh` for environment preparation (installing Node.js, MongoDB, Nginx, etc.).
- `phase1/`: Storage for resources related to Phase 1 deployment requirements (typically includes initial infrastructure configurations and graphical evidence).
- `phase2/`: Configurations for Phase 2 (implementing Nginx as a Reverse Proxy, advanced configurations, and PM2 process management).
- `phase3/`: Docker-based Phase 3 directory (contains `Dockerfile`, `docker-compose.yml`, etc.). It provides Containerization capabilities for the Node.js application and MongoDB database.

## Application (Product API + UI)

This is an MVC structured project built with Node.js + Express, utilizing MongoDB as the data store (with an in-memory fallback mechanism in case of database connection failure). The application supports Product CRUD operations and serves a server-side rendered interface using EJS integrated with Bootstrap.

For details on how to run the source code locally and the list of API endpoints, please see [src/README.md](src/README.md).

## Deployment Phases

The project is designed to incrementally apply deployment techniques across three phases:
1. **Phase 1**: (Basic Deployment) Installing the application natively on an Ubuntu/Linux Virtual Machine (VM).
2. **Phase 2**: (Reverse Proxy & Process management) Deploying Nginx and PM2 to manage processes and logs, ensuring high availability.
3. **Phase 3**: (Containerization) utilizing Docker to containerize the application (App + MongoDB). Launching consistently via `docker-compose`.

## Quick Start (Docker Launch - Phase 3)

If Docker and Docker Compose are installed on your system, you can deploy the project rapidly using the following commands:

```bash
cd phase3
docker-compose up -d
```

Once the containers are running, the web application will be accessible at `http://localhost:3000`. The Docker configuration automatically handles port mapping, persistent database volume caching, and mapped volumes for user uploads.

---
*Note: This project serves reference and practical implementation purposes for automated deployment configurations (CI/CD, Web Server, Docker). Please update the environmental variables appropriately before deploying to Production.*
