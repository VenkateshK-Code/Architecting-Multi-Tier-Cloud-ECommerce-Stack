#  Enterprise Magento 2 Deployment Guide

This runbook documents the end-to-end provisioning and configuration of a high-performance Magento 2 e-commerce environment on AWS, utilizing a "Varnish Sandwich" architecture.



## Phase 1: AWS Infrastructure Provisioning
1. **Launch EC2 Instance:** Provisioned a Debian 12 (Bookworm) instance to serve as the application host.
2. **Network Security:** Configured AWS Security Groups to allow inbound traffic strictly on:
   * Port 22 (SSH - Restricted to Admin IP)
   * Port 80 (HTTP)
   * Port 443 (HTTPS)
3. **Elastic IP:** Attached an Elastic IP to ensure DNS stability during server reboots.

## Phase 2: Core Dependencies & Database Layer
1. **System Update:** Executed sudo apt update && sudo apt upgrade -y to secure the base OS.
2. **MySQL / MariaDB Deployment:**
   * Installed the database engine and ran mysql_secure_installation.
   * Provisioned a dedicated magento_user and magento_db with restricted local-only access.
3. **PHP-FPM Setup:** * Installed PHP 8.3-FPM along with all required Magento extensions (cmath, curl, gd, intl, mbstring, soap, xml, zip).
   * Tuned php.ini for enterprise workloads (memory_limit = 2G, max_execution_time = 300).

## Phase 3: High-Performance Search & Caching
1. **Redis Installation:** Deployed Redis to handle Magento session storage and backend caching, drastically reducing MySQL read-loads.
2. **Elasticsearch Deployment:** * Installed Java OpenJDK.
   * Deployed Elasticsearch (running on localhost:9200) to power Magento's advanced catalog search and indexing capabilities.

## Phase 4: The "Varnish Sandwich" Configuration
This architecture isolates SSL termination, caching, and application processing into distinct, highly optimized layers.

1. **Frontend Proxy (Nginx - Ports 80/443):**
   * Configured Nginx to listen on public ports.
   * Handled SSL/TLS termination.
   * Proxied all standard traffic internally to Varnish.
2. **Caching Layer (Varnish - Port 8080):**
   * Modified systemd service files to bind Varnish strictly to port 8080.
   * Imported Magento's optimized default.vcl to cache static assets and dynamic full-page loads.
3. **Backend Application Server (Nginx - Port 8008):**
   * Configured a secondary Nginx server block listening on port 8008.
   * Handled cache-misses passed down from Varnish and routed them directly to PHP 8.3-FPM via FastCGI.
4. **Security Bypass Rules:** Engineered strict location blocks on the frontend proxy to route sensitive paths (e.g., Magento Admin, phpMyAdmin) directly to the backend server, completely bypassing the Varnish cache.

## Phase 5: Magento Application Deployment
1. **Composer:** Installed Composer to manage Magento's PHP dependencies.
2. **File System Permissions:** Configured strict Linux ownership (chown -R www-data:www-data) and specific read/write permissions for ar, pub/static, and generated directories.
3. **CLI Installation:** Executed the in/magento setup:install command linking the database, Elasticsearch, and Redis configurations.
4. **Compilation:** Ran setup:di:compile and setup:static-content:deploy for production readiness.
