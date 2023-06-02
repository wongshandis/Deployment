
# TASK
## My Installations
- virtualbox 
- ubuntu
- python
- helm
- minikube
- kubectl 
- docker
- docker compose
- docker desktop
- docker engine
- python
- vscode

# Docker deployment
### Start servers
Go to directory
```cd docker_deployment```
Start server
```sh ./local_start.sh ```
Internally it runs the docker-compose file to start Postgresql + pgAdmin:
    - it runs this docker-compose -f docker-compose.yaml up -d
    - I created the shell script is because I want to encapsulate it, so user don't have to type in the docker compose commads
    
Check IP address, find the postgres container's IPAddress  
- ```docker inspect <container-name>```
         eg. docker inspect postgres
         in my case it's "IPAddress": "172.19.0.2"

### Access PGadmin by accessing http://localhost:5001 on your browser
Login
- Username: admin@admin.com
- Password: admin
- Get the postgres IP to connect
Go to your terminal
- ```docker inspect postgres```
Copy the Postgres IPAddress 
- eg. 172.18.0.2 (This is an example, we are going to paste this later to connect)
   
### Connect Postgres so pgAdmin
Connect to server
- Top left, right click, go to Register-> Server
General tab
- Name: postgresdb
Connection tab
    Connect to Postgres
        On the command-line 
        - ```docker inspect postgres```
    Connection tab
    - Host name/address: 172.20.0.2 <$Postgres IPAddress>
    -  Port: 5432
    - Maintenance database: postgres
    - Username: postgres
    - Password: postgres
  
Destroy all servers once you are done easily
```sh ./local_destroy.sh ```

**Note: Logs can be viewed inside the docker container**


# Kubernetes deployment
### Start servers
Start kubernetes cluster
```minikube start```
Go to directory
```cd k8_deployment/services```
Runs all the manifest .yaml file to start pdAgmin and Postgres
```sh ./start_pgadmin.sh```
```sh ./start_postgres.sh```
Internally it is running kubectl apply -f deployment.yaml, kubectl apply -f services.yaml, ...etc

Expose external IP as I am using a load balancer
```minikube tunnel```

Open another termial
```kubectl get all```
Copy the External IP of pdagmin


### Connect to pgAdmin
Paste the External IP it on your browser to access pgAdmin
Login
- Username: admin@admin.com
- Password: admin

### Connect to Postgres
Top left, right click, go to 
- Register-> Server
General tab
- Name: postgresdb
- Connection tab
Copy the External IP of postgres
- Host name/address:  <$Postgres IPAddress >
- Port: 5432
- Maintenance database: postgres
- Username: postgres
- Password: postgres


***Note: This method will also work with Helm, by adding the Charts.yaml and Values.yaml, etc, and make changes to the syntax.**

If given more time, I will complete it using Helm charts. Manage to get to postgresql helm charts working in helm, but its really messy now so will use the kubernetes for demo

# Races of Marvel comics and DC comic results

The tables are uploaded at Results_for_Marvel_DC_Comics.
```sh
result_top3_race_DC_comic.csv ===> Top 3 races of DC comics
result_top3_race_marvel_comic.csv ===> Top 3 races of Marvel comics
result_query.sql ===> Queries of the results above
data creation ===> Data used to create the tables in pgAdmin
```

***Note: In the pgAdmin database, all these data (raw + cleaned) are also mounted as volumes, so the data is persitent even if pgAdmin is closed, and open again, the data will still be there.**


