## 📊 Infrastructure Flow Diagram

```mermaid
graph TD
    %% Define Visual Styles (stroke color, fill color, text color, rounded corners)
    classDef client stroke:#333,fill:#555,color:#fff,rx:5,ry:5;
    classDef blue stroke:#003c6e,fill:#114e8a,color:#fff,rx:5,ry:5;
    classDef green stroke:#00513e,fill:#10624e,color:#fff,rx:5,ry:5;
    classDef purple stroke:#4e2f81,fill:#5e3f92,color:#fff,rx:5,ry:5;
    classDef brown stroke:#5e3f1e,fill:#6e4f2f,color:#fff;

    %% Define Nodes with distinct shapes and original text
    Client(Client Browser)
    NginxFront(Nginx Frontend Proxy<br/>SSL Termination)
    Varnish(Varnish Cache 7.1<br/>Port 8080)
    NginxBack(Nginx Backend Server<br/>Port 8008)
    PHP(PHP 8.3-FPM<br/>Magento 2 App)
    MySQL[(MySQL Database)] %% Special Cylinder Shape

    %% Apply Styles to Nodes
    class Client client;
    class NginxFront blue;
    class Varnish green;
    class NginxBack blue;
    class PHP purple;
    class MySQL brown;

    %% Define Infrastructure Flows with labels and line types
    Client -->|HTTPS: 443| NginxFront
    NginxFront -->|HTTP: 8080| Varnish
    NginxFront -.->|Bypass Cache<br/>Admin & phpMyAdmin| NginxBack %% Dotted bypass line
    Varnish -->|Cache Miss - HTTP: 8008| NginxBack
    NginxBack -->|FastCGI| PHP
    PHP -->|Read/Write| MySQL
