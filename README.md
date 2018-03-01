# vci

## Prerequisites: 
have a working docker-compose setup (this was tested on mac), might need user/login to docker.com etc.

```
make prepare # checks out vespa sample-apps
```

## 0. create docker-compose cluster with 1x admin, 2x stateless and 2x content nodes (tested on macos)

```
make ci
```

Sample output: see [output0_from_starting_vespa_cluster_before_application.txt](output0_from_starting_vespa_cluster_before_application.txt)


## 1. update /etc/hosts on all nodes in cluster (in addition to built in dns)
```
make cihosts
```

Sample output: see [output1_from_creating_etc_hosts_file_on_all_nodes.txt](output1_from_creating_etc_hosts_file_on_all_nodes.txt)

## 2. deploy (basic-search) application on docker-compose cluster 
```
make runci
```

Sample output: see [output2_from_deploying_application_cluster.txt](output2_from_deploying_application_cluster.txt)

## 3. login into admin node and check cluster state
```
make shell
[root@admin0 vespascripts]# /opt/vespa/bin/vespa-get-cluster-state 

Cluster music:
music/distributor/0: up
music/distributor/1: up
music/storage/0: up
music/storage/1: up
```

Sample complete session and output: [output3_from_running_vespa_cluster_status_on_admin_node.txt](output3_from_running_vespa_cluster_status_on_admin_node.txt)

## Appendix A - Docker Compose file 
```
version: '3'

services:
  admin0:
    image: vespaengine/vespa # centos:7
    hostname: admin0
    volumes:
      - ./sample-apps:/vespaapp
      - ./vespascripts:/vespascripts
    environment:
    - VESPA_CONFIGSERVERS=admin0
    entrypoint: /usr/local/bin/start-container.sh
    command: configserver 

  stateless0:
    image: vespaengine/vespa # centos:7
    hostname: stateless0
    volumes:
      - ./sample-apps:/vespaapp
      - ./vespascripts:/vespascripts
    environment:
    - VESPA_CONFIGSERVERS=admin0
    entrypoint: /usr/local/bin/start-container.sh
    command: services

  content0:
    image: vespaengine/vespa # centos:7
    hostname: content0
    volumes:
      - ./sample-apps:/vespaapp
      - ./vespascripts:/vespascripts
    environment:
    - VESPA_CONFIGSERVERS=admin0
    entrypoint: /usr/local/bin/start-container.sh
    command: services

  stateless1:
    image: vespaengine/vespa # centos:7
    hostname: stateless1
    volumes:
      - ./sample-apps:/vespaapp
      - ./vespascripts:/vespascripts
    environment:
    - VESPA_CONFIGSERVERS=admin0
    entrypoint: /usr/local/bin/start-container.sh
    command: services

  content1:
    image: vespaengine/vespa # centos:7
    hostname: content1
    volumes:
      - ./sample-apps:/vespaapp
      - ./vespascripts:/vespascripts
    environment:
    - VESPA_CONFIGSERVERS=admin0
    entrypoint: /usr/local/bin/start-container.sh
    command: services
```

# Appendix B - Output from complete run
```
$ make prepare ci cihosts runcì
```

```
git clone https://github.com/vespa-engine/sample-apps.git
Cloning into 'sample-apps'...
remote: Counting objects: 1362, done.
remote: Compressing objects: 100% (91/91), done.
remote: Total 1362 (delta 161), reused 191 (delta 131), pack-reused 1140
Receiving objects: 100% (1362/1362), 1.83 MiB | 0 bytes/s, done.
Resolving deltas: 100% (731/731), done.
Checking connectivity... done.
sudo docker-compose -f docker-compose-ci.yml up -d # -d # with/without -d??
Creating network "vci_default" with the default driver
Creating vci_admin0_1     ... done
Creating vci_stateless0_1 ... done
Creating vci_stateless1_1 ... done
Creating vci_content1_1   ... done
Creating vci_content0_1   ... done
docker-compose -f docker-compose-ci.yml exec admin0 /bin/bash /vespascripts/create_hosts.sh
host admin0 =
admin0 has address 172.20.0.2
Host admin0 not found: 3(NXDOMAIN)
host content0 =
content0 has address 172.20.0.4
Host content0 not found: 3(NXDOMAIN)
host content1 =
content1 has address 172.20.0.5
Host content1 not found: 3(NXDOMAIN)
host stateless0 =
stateless0 has address 172.20.0.3
Host stateless0 not found: 3(NXDOMAIN)
host stateless1 =
stateless1 has address 172.20.0.6
Host stateless1 not found: 3(NXDOMAIN)
docker-compose -f docker-compose-ci.yml exec stateless0 /bin/bash /vespascripts/create_hosts.sh
host admin0 =
admin0 has address 172.20.0.2
Host admin0 not found: 3(NXDOMAIN)
host content0 =
content0 has address 172.20.0.4
Host content0 not found: 3(NXDOMAIN)
host content1 =
content1 has address 172.20.0.5
Host content1 not found: 3(NXDOMAIN)
host stateless0 =
stateless0 has address 172.20.0.3
Host stateless0 not found: 3(NXDOMAIN)
host stateless1 =
stateless1 has address 172.20.0.6
Host stateless1 not found: 3(NXDOMAIN)
docker-compose -f docker-compose-ci.yml exec stateless1 /bin/bash /vespascripts/create_hosts.sh
host admin0 =
admin0 has address 172.20.0.2
Host admin0 not found: 3(NXDOMAIN)
host content0 =
content0 has address 172.20.0.4
Host content0 not found: 3(NXDOMAIN)
host content1 =
content1 has address 172.20.0.5
Host content1 not found: 3(NXDOMAIN)
host stateless0 =
stateless0 has address 172.20.0.3
Host stateless0 not found: 3(NXDOMAIN)
host stateless1 =
stateless1 has address 172.20.0.6
Host stateless1 not found: 3(NXDOMAIN)
docker-compose -f docker-compose-ci.yml exec content0 /bin/bash /vespascripts/create_hosts.sh
host admin0 =
admin0 has address 172.20.0.2
Host admin0 not found: 3(NXDOMAIN)
host content0 =
content0 has address 172.20.0.4
Host content0 not found: 3(NXDOMAIN)
host content1 =
content1 has address 172.20.0.5
Host content1 not found: 3(NXDOMAIN)
host stateless0 =
stateless0 has address 172.20.0.3
Host stateless0 not found: 3(NXDOMAIN)
host stateless1 =
stateless1 has address 172.20.0.6
Host stateless1 not found: 3(NXDOMAIN)
docker-compose -f docker-compose-ci.yml exec content1 /bin/bash /vespascripts/create_hosts.sh
host admin0 =
admin0 has address 172.20.0.2
Host admin0 not found: 3(NXDOMAIN)
host content0 =
content0 has address 172.20.0.4
Host content0 not found: 3(NXDOMAIN)
host content1 =
content1 has address 172.20.0.5
Host content1 not found: 3(NXDOMAIN)
host stateless0 =
stateless0 has address 172.20.0.3
Host stateless0 not found: 3(NXDOMAIN)
host stateless1 =
stateless1 has address 172.20.0.6
Host stateless1 not found: 3(NXDOMAIN)
docker-compose -f docker-compose-ci.yml exec admin0 /bin/bash /vespascripts/run-ci.sh
copying changed configuration files (services and hosts) to support distributed vespa
Thu Mar  1 15:38:22 UTC 2018
waiting 15 seconds for vespa to come up - attempt: 1
vespa-deploy prepare /vespaapp/basic-search/src/main/application/ && break
Uploading application '/vespaapp/basic-search/src/main/application/' using http://admin0:19071/application/v2/tenant/default/session?name=application
Session 2 for tenant 'default' created.
Preparing session 2 using http://admin0:19071/application/v2/tenant/default/session/2/prepared
Session 2 for tenant 'default' prepared.
Activating session 2 using http://admin0:19071/application/v2/tenant/default/session/2/active
Session 2 for tenant 'default' activated.
Checksum:   58b4d23e0859b23f451d8538134c49ae
Timestamp:  1519918717449
Generation: 2
Checking Vespa Application Status on port 19071
Checking Vespa Application Status on port 8080 on stateless0 (can take a few seconds)
.............{
    "id": "id:music:music::1",
    "pathId": "/document/v1/music/music/docid/1"
}
{
    "id": "id:music:music::2",
    "pathId": "/document/v1/music/music/docid/2"
}
{
    "root": {
        "children": [
            {
                "fields": {
                    "artist": "Michael Jackson",
                    "documentid": "id:music:music::1",
                    "duration": 247,
                    "sddocname": "music",
                    "title": "Bad",
                    "year": 1987
                },
                "id": "id:music:music::1",
                "relevance": 0.254574922399675,
                "source": "music"
            },
            {
                "fields": {
                    "artist": "Eminem",
                    "documentid": "id:music:music::2",
                    "sddocname": "music",
                    "title": "So Bad",
                    "year": 2010
                },
                "id": "id:music:music::2",
                "relevance": 0.05447959677335429,
                "source": "music"
            }
        ],
        "coverage": {
            "coverage": 100,
            "documents": 2,
            "full": true,
            "nodes": 2,
            "results": 1,
            "resultsFull": 1
        },
        "fields": {
            "totalCount": 2
        },
        "id": "toplevel",
        "relevance": 1.0
    }
}
```