
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
- ```cd docker_deployment```

Start server
- ```sh ./local_start.sh ```
Internally it runs the docker-compose file to start Postgresql + pgAdmin:
    - it runs this docker-compose -f docker-compose.yaml up -d
    - I created the shell script is because I want to encapsulate it, so user don't have to type in the docker compose commads
    
Check IP address, find the postgres container's IPAddress  
- ```docker inspect <container-name>```
         eg. docker inspect postgres
         example in my case is "IPAddress": "172.19.0.4"

### Access PGadmin by accessing http://localhost:5001 on your browser


Login
- Username: admin@admin.com
- Password: admin

Get the postgres IP to connect
- Go to your terminal
    - ```docker inspect postgres```

Copy the Postgres IPAddress 
- eg. 172.18.0.2 
- We are going to paste this later to connect

### Connect Postgres to pgAdmin
Inside the pgADmin server
- Right click and click on Register-> Server

General tab
- Name: postgresdb
 
On the command-line 
-```docker inspect postgres```

Connection tab
- Host name/address: <$Postgres IPAddress>
    eg. 172.18.0.2 
-  Port: 5432
- Maintenance database: postgres
- Username: postgres
- Password: postgres
  

Done!

Destroy all servers once you are done easily
```sh ./local_destroy.sh ```

**Note: Logs can be viewed inside the docker container**


# Kubernetes deployment
### Start servers
Start kubernetes cluster
- ```minikube start```

Go to directory
- ```cd k8_deployment/services```

Runs all the manifest .yaml file to start pdAgmin and Postgres
- ```sh ./start_pgadmin.sh```
- ```sh ./start_postgres.sh```
Internally it is running kubectl apply -f deployment.yaml, kubectl apply -f services.yaml, ...etc

Expose external IP as I am using load balancer 
- ```minikube tunnel```
- Leave it running, don't close it

### Connect to pgAdmin
Open another termial
- ```kubectl get all```

Copy the External IP of pdagmin and paste the **External IP** on your browser to access pgAdmin
Open another command-line 
- ```docker inspect pdagmin```

Go back to the pgAdmin
Login
- Username: admin@admin.com
- Password: admin

### Connect to Postgres

On the command-line 
- ```docker inspect postgres```
- Copy the External IP of postgres (Will be needed for later)

 
Inside the pgADmin server
- Right click and click on Register-> Server


General tab
- Name: postgresdb

Connection tab
- Host name/address:  <$Postgres External IP>
- Port: 5432
- Maintenance database: postgres
- Username: postgres
- Password: postgres

Done!

***Note: This method will also work with Helm, by adding the Charts.yaml and Values.yaml, etc, and make changes to the syntax.**

If given more time, I will complete it using Helm charts. Manage to get to postgresql helm charts working in helm, but its really messy now so will use the kubernetes for demo

# Races of Marvel comics and DC comic results
The results are uploaded at Results_for_Marvel_DC_Comics. All raw data and cleaned data is also mounted as volumes.

### Findings:
- Data is incomplete
    - Names from different .csv tables don't match up 
- I used marvel_characters_info.csv as the base, as that has the Race column that we need for the results 
    - Race column has missing race, so in my query, I've excluded race that is '-' (In other words, it's NULL)
- Only include data that durability is TRUE


### Steps to get results of top 3 races for Marvel Comics and DC comics respectively
- The .csv data has been stored into tables in pgAdmin by creating tables using postgresql
- Created a table with cleaned data that is needed for query (eg. removing unrelevant data)
        - data_creation/cleaned_superhero_info.sql
- Using (raw data + cleaned data) with postgresql query, collate them and I created another table out of it
        - data_creation/cleaned_superhero_info.sql
- Finally, using that table to get top 3 races for Marvel Comics and DC comics respectively
    - ***result_top3_race_DC_comic.csv***
    - ***result_top3_race_marvel_comic.csv***
    
The queries are here to achieve the results: 
- ***result_query.sql***

All the tables are added into pgAdmin for easy accessible for analyst data scientist.

''''
***Note: In the pgAdmin database, all these data  (raw + cleaned) are also mounted as volumes, so the data is persistent even if pgAdmin is closed, and reopen again, the data will still exist.**


