Architecting a Multi-Tier Cloud E-Commerce Stack
Project Overview
This project demonstrates the architecture and deployment of a highly available, scalable, and secure Magento 2 e-commerce application. It utilizes a classic 3-tier architecture to separate the presentation, application, and data layers, optimized for cloud environments (AWS/Azure).

Architecture Tiers
Presentation Tier (Web):

Nginx acting as a high-performance web server and reverse proxy.

Varnish Cache for Full Page Caching (FPC) to reduce server load and improve response times.

Application Tier (App):

PHP-FPM processing the Magento core logic.

Optimized configurations for session management and background cron jobs.

Data Tier (DB & Storage):

MySQL/MariaDB for relational data storage.

Redis for distributed caching and session storage.

Key Technical Features
SSL/TLS Termination: Secure communication via Nginx.

Database Management: Includes magento_db.sql for automated schema deployment.

Cloud-Native Readiness: Infrastructure-agnostic design, ready for containerization (Docker) or VM-based deployment (EC2/Azure VMs).

Performance Tuning: Integrated Varnish and Nginx optimizations specifically for Magento's heavy architectural requirements.

Repository Structure
/configs: Contains environment-specific settings (magento-env.php) and database dumps.

/docs: Technical requirements and architectural documentation.
