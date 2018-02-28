# vci

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

Sample output: see [output2_from_deploying_application_cluster.txt](1_from_creating_etc_hosts_file_on_all_nodes.txt)

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

Sample complete session and output: [output3_from_running_vespa_cluster_status_on_admin_node.txt](0_from_starting_vespa_cluster_before_application.txt)

## Appendix - Docker Compose file 
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


