# vci

## 1. create docker-compose cluster with 1x admin, 2x stateless and 2x content nodes (tested on macos)

```
make ci
```
(See docker-compose-ci.yml for deployment info and 

## 2. update /etc/hosts on all nodes in cluster (in addition to built in dns)
```
make cihosts
```

## 3. deploy (basic-search) application on docker-compose cluster 
```
make runci
```

## 4. login into admin node and check cluster state
```
make shell
[root@admin0 vespascripts]# /opt/vespa/bin/vespa-get-cluster-state 

Cluster music:
music/distributor/0: up
music/distributor/1: up
music/storage/0: up
music/storage/1: up
```

