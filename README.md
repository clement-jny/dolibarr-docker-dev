# docker-dolibarr-dev
A docker setting dedicated to developpement and maintain dolibarr core and module

## princip
* Load the dolibarr core version you need on dolibarr-core
* copy/paste the dolibarr-dev folders and define the specific setting
  * php version
  * dolibarr version
  * mysql version (you can change here your login password and database name)
  
* launch the docker-compose up, and connect on http://localhost/dolibarr/htdocs to launch the install
* on the database setting
  * use mysql on database server
  * tcheck "create database"
  * enter user "root" and root login password 2 times  

