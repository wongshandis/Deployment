# My set up
### Install
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
- cd docker_deployment
- sh ./local_start.sh 
Internally it runs the docker-compose file to start Postgresql + pgAdmin:
    - docker-compose -f docker-compose.yaml up -d
Check IP address, find the postgres container's IPAddress  
- docker inspect <container-name>
         eg. docker inspect postgres
         in my case it's "IPAddress": "172.19.0.2"

### Access PGadmin by accessing http://localhost:5001 on your browser
Login
- Username: admin@admin.com
- Password: admin
- Get the postgres IP to connect
Go to your terminal
- docker inspect postgres
Get the IPAddress 
- eg. 172.18.0.2 (this is an example, we are going to paste this later)
        
Connect to server
- Top left, right click, go to Register-> Server
General tab
- Name: postgresdb
Connection tab
    Connect to Postgres
        On the command-line 
        - docker inspect postgres
    Connection tab
    - Host name/address: 172.20.0.2 (paste the postgres IPAddress here)
    -  Port: 5432
    Maintenance database: postgres
    - Username: postgres
    - Password: postgres
    
    
Save!


Destroy server once you are done
- sh ./local_destroy.sh 

**Note: Logs can be viewed inside the docker container**


## Kubernetes deployment
### Start servers
- cd k8_deployment/services
- sh ./start_pgadmin.sh
- sh ./start_postgres.sh
Internally: It runs all the manifest .yaml file to start pdAgmin and Postgres
eg. kubectl apply -f deployment.yaml
kubectl apply -f services.yaml

Expose external IP
- minikube tunnel

Open another termial
- kubectl get all
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
- Host name/address:  <$ paste external  IP  of  posgres>
- Port: 5432
- Maintenance database: postgres
- Username: postgres
- Password: postgres
Save!

  
***Note: This method will also work with Helm, by adding the Charts.yaml and Values.yaml, etc, and make changes to the syntax.**

If given more time, I will complete the Helm portion.

## Races of Marvel comics and DC comic results
The tables are uploaded at Results_for_Marvel_DC_Comics.
result_top3_race_DC_comic.csv = Top 3 races of DC comics
result_top3_race_marvel_comic.csv = Top 3 races of Marvel comics
result_query.sql = Queries of the results above
data creation = Data used to create the tables in pgAdmin

***Note: In the pgAdmin database, all these data (raw + cleaned) are also mounted as volumes, so the data is persitent even if pgAdmin is closed, and open again, the data will still be there.**


