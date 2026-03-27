## 📊 Infrastructure Flow Diagram

```mermaid
graph TD
    Client([Client Browser]) -->|HTTPS: 443| NginxFront[Nginx Frontend Proxy<br/>SSL Termination]
    
    NginxFront -->|HTTP: 8080| Varnish[Varnish Cache 7.1<br/>Port 8080]
    
    Varnish -->|Cache Miss - HTTP: 8008| NginxBack[Nginx Backend Server<br/>Port 8008]
    
    NginxBack -->|FastCGI| PHP[PHP 8.3-FPM<br/>Magento 2 App]
    
    PHP -->|Read/Write| MySQL[(MySQL Database)]
    
    NginxFront -.->|Bypass Cache<br/>Admin & phpMyAdmin| NginxBack
