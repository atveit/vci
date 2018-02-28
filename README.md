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

## Appendix B - Output from vespa-logfmt

```[2018-02-28 23:01:38.239] INFO    : container-clustercontroller Container.com.yahoo.container.jdisc.ConfiguredApplication Starting container
[2018-02-28 23:01:44.785] INFO    : container-clustercontroller Container.com.yahoo.container.core.config.HandlersConfigurerDi	      Installing bundles from the latest application
[2018-02-28 23:01:44.797] INFO    : container-clustercontroller Container.com.yahoo.container.core.config.BundleLoader		      Installing bundle from disk with reference 'file:/opt/vespa/lib/jars/zkfacade-jar-with-dependencies.jar'
[2018-02-28 23:01:44.799] INFO    : container-clustercontroller Container.com.yahoo.container.core.config.BundleLoader		      Installing bundle from disk with reference 'file:/opt/vespa/lib/jars/clustercontroller-apps-jar-with-dependencies.jar'
[2018-02-28 23:01:44.840] INFO    : container-clustercontroller Container.com.yahoo.container.core.config.BundleLoader		      Installing bundle from disk with reference 'file:/opt/vespa/lib/jars/clustercontroller-apputil-jar-with-dependencies.jar'
[2018-02-28 23:01:44.881] INFO    : container-clustercontroller Container.com.yahoo.container.core.config.BundleLoader		      Installing bundle from disk with reference 'file:/opt/vespa/lib/jars/clustercontroller-utils-jar-with-dependencies.jar'
[2018-02-28 23:01:44.897] INFO    : container-clustercontroller Container.com.yahoo.container.core.config.BundleLoader		      Installing bundle from disk with reference 'file:/opt/vespa/lib/jars/clustercontroller-core-jar-with-dependencies.jar'
[2018-02-28 23:01:44.951] INFO    : container-clustercontroller Container.com.yahoo.container.core.config.BundleLoader		      0 bundles were removed, and 5 bundles were installed.
[2018-02-28 23:01:44.956] INFO    : container-clustercontroller Container.com.yahoo.container.core.config.BundleLoader		      Installed bundles: {[0]org.apache.felix.framework, [1]container-disc, [2]config-bundle, [3]configdefinitions, [4]container-jersey2, [5]container-search-and-docproc, [6]docprocs, [7]jdisc_http_service, [8]org.objectweb.asm.all.debug, [9]javax.servlet-api, [10]org.eclipse.jetty.continuation, [11]org.eclipse.jetty.http, [12]org.eclipse.jetty.io, [13]org.eclipse.jetty.jmx, [14]org.eclipse.jetty.security, [15]org.eclipse.jetty.server, [16]org.eclipse.jetty.servlet, [17]org.eclipse.jetty.servlets, [18]org.eclipse.jetty.util, [19]org.apache.aries.spifly.dynamic.bundle, [20]org.apache.aries.util, [21]component, [22]vespaclient-container-plugin, [23]simplemetrics, [24]defaults, [25]zkfacade, [26]org.glassfish.hk2.external.aopalliance-repackaged, [27]org.glassfish.hk2.api, [28]org.glassfish.hk2.locator, [29]org.glassfish.hk2.utils, [30]com.fasterxml.jackson.core.jackson-annotations, [31]com.fasterxml.jackson.core.jackson-core, [32]com.fasterxml.jackson.core.jackson-databind, [33]com.fasterxml.jackson.datatype.jackson-datatype-jdk8, [34]com.fasterxml.jackson.datatype.jackson-datatype-jsr310, [35]com.fasterxml.jackson.jaxrs.jackson-jaxrs-base, [36]com.fasterxml.jackson.jaxrs.jackson-jaxrs-json-provider, [37]com.fasterxml.jackson.module.jackson-module-jaxb-annotations, [38]javassist, [39]javax.ws.rs-api, [40]org.glassfish.jersey.core.jersey-client, [41]org.glassfish.jersey.core.jersey-common, [42]org.glassfish.jersey.containers.jersey-container-servlet, [43]org.glassfish.jersey.containers.jersey-container-servlet-core, [44]org.glassfish.jersey.ext.jersey-entity-filtering, [45]org.glassfish.jersey.bundles.repackaged.jersey-guava, [46]org.glassfish.jersey.media.jersey-media-jaxb, [47]org.glassfish.jersey.media.jersey-media-json-jackson, [48]org.glassfish.jersey.media.jersey-media-multipart, [49]org.jvnet.mimepull, [50]org.glassfish.jersey.core.jersey-server, [51]org.glassfish.jersey.ext.jersey-proxy-client, [52]org.glassfish.hk2.osgi-resource-locator, [53]javax.validation.api, [54]clustercontroller-apps, [55]clustercontroller-apputil, [56]clustercontroller-utils, [57]clustercontroller-core}
[2018-02-28 23:01:48.320] INFO    : container-clustercontroller stdout								      [GC (Allocation Failure)  209792K->16509K(498112K), 1.6672329 secs]
[2018-02-28 23:02:00.988] INFO    : container-clustercontroller stdout								      [GC (CMS Initial Mark)  85679K(498112K), 0.5150464 secs]
[2018-02-28 23:02:01.925] INFO    : container-clustercontroller Container.com.yahoo.container.osgi.ContainerRpcAdaptor		      Registered name 'vespa/service/admin/cluster-controllers/0' at tcp/admin0:19102 with: [tcp/stateless0:19099, tcp/stateless1:19099, tcp/admin0:19099]
[2018-02-28 23:02:02.271] INFO    : container-clustercontroller Container.com.yahoo.jrt.slobrok.api.Register			      RPC server tcp/admin0:19102 registering vespa/service/admin/cluster-controllers/0 with Slobrok server tcp/stateless0:19099 completed successfully
[2018-02-28 23:02:06.546] INFO    : container-clustercontroller stdout								      [GC (CMS Final Remark)  98706K(498112K), 0.3394256 secs]
[2018-02-28 23:02:11.911] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.FleetController      Starting up cluster controller 0 for cluster music
[2018-02-28 23:02:12.125] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.DatabaseHandler      Fleetcontroller 0: Setting up new ZooKeeper session at admin0:2181
[2018-02-28 23:02:13.471] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.ZooKeeperDatabase    Fleetcontroller 0: Connection to zookeeper server established. Refetching master data
[2018-02-28 23:02:13.879] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.ZooKeeperDatabase    Fleetcontroller 0: Creating ephemeral master vote node with vote to self.
[2018-02-28 23:02:13.963] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.DatabaseHandler      Fleetcontroller 0: Done setting up new ZooKeeper session at admin0:2181
[2018-02-28 23:02:14.050] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.ZooKeeperDatabase    Fleetcontroller 0: Stored new vote in ephemeral node. 0 -> 0
[2018-02-28 23:02:14.117] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.MasterDataGatherer   Fleetcontroller 0: Got node list response from /vespa/fleetcontroller/music/indexes version 0 with 1 nodes
[2018-02-28 23:02:14.121] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.ZooKeeperDatabase    Fleetcontroller 0: Read cluster state version 0 from ZooKeeper
[2018-02-28 23:02:14.149] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.MasterDataGatherer   Fleetcontroller 0: Got vote data from path /vespa/fleetcontroller/music/indexes/0 with code 0 and data 0
[2018-02-28 23:02:14.151] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.MasterDataGatherer   Fleetcontroller 0: Got vote from fleetcontroller 0. Altering vote from null to 0.
[2018-02-28 23:02:14.167] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Cluster event type MASTER_ELECTION @1519858934161: This node just became fleetcontroller master. Bumped version to 1 to be in line.
[2018-02-28 23:02:14.282] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: distributor.0: Node distributor.0 has a new address in slobrok: tcp/content0:19110
[2018-02-28 23:02:14.283] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: distributor.1: Node distributor.1 has a new address in slobrok: tcp/content1:19110
[2018-02-28 23:02:14.331] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: storage.0: Node storage.0 has a new address in slobrok: tcp/content0:19101
[2018-02-28 23:02:14.365] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: storage.1: Node storage.1 has a new address in slobrok: tcp/content1:19101
[2018-02-28 23:02:14.618] INFO    : container-clustercontroller Container.org.eclipse.jetty.util.log.javautil				       Logging initialized @80766ms to org.eclipse.jetty.util.log.JavaUtilLog
[2018-02-28 23:02:14.838] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Cluster event type SYSTEMSTATE @1519858934822: Too few storage nodes available in cluster. Setting cluster state down
[2018-02-28 23:02:15.003] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Cluster event type SYSTEMSTATE @1519858934822: New cluster state version 2. Change from last: version: 0 => 2, cluster: Up => Down, bits: 16 => 8, storage: [0: description:  => Node not seen in slobrok., 1: description:  => Node not seen in slobrok.], distributor: [0: description:  => Node not seen in slobrok., 1: description:  => Node not seen in slobrok.]
[2018-02-28 23:02:15.007] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Cluster event type SYSTEMSTATE @1519858934822: Altering distribution bits in system from 16 to 8
[2018-02-28 23:02:15.033] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.ZooKeeperDatabase    Fleetcontroller 0: Storing new cluster state version in ZooKeeper: 2
[2018-02-28 23:02:15.463] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.MasterElectionHandler	       Cluster controller 0: Got new fleet data with 1 entries: {0=0}
[2018-02-28 23:02:15.489] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: distributor.0: Altered min distribution bit count from 16 to 58
[2018-02-28 23:02:15.698] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: storage.0: Altered min distribution bit count from 16 to 58
[2018-02-28 23:02:15.816] INFO    : container-clustercontroller Container.com.yahoo.jdisc.http.server.jetty.JettyHttpServer		       Creating janitor executor with 6 threads
[2018-02-28 23:02:16.020] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: storage.1: Altered min distribution bit count from 16 to 58
[2018-02-28 23:02:16.041] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: distributor.1: Altered min distribution bit count from 16 to 58
[2018-02-28 23:02:16.070] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: storage.0: Altered node state in cluster state from 'D: Node not seen in slobrok.' to 'U, t 1519858855, b 58'
[2018-02-28 23:02:16.070] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: distributor.0: Altered node state in cluster state from 'D: Node not seen in slobrok.' to 'U, t 1519858849, b 58'
[2018-02-28 23:02:16.071] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: storage.1: Altered node state in cluster state from 'D: Node not seen in slobrok.' to 'U, t 1519858855, b 58'
[2018-02-28 23:02:16.071] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: distributor.1: Altered node state in cluster state from 'D: Node not seen in slobrok.' to 'U, t 1519858851, b 58'
[2018-02-28 23:02:16.071] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Cluster event type SYSTEMSTATE @1519858936059: Enough nodes available for system to become up
[2018-02-28 23:02:16.072] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Cluster event type SYSTEMSTATE @1519858936059: New cluster state version 3. Change from last: version: 2 => 3, cluster: Down => Up, storage: [0: [Down => Up, minUsedBits: 16 => 58, startTimestamp: 0 => 1519858855, disks: 0 => 1, description: Node not seen in slobrok. => ], 1: [Down => Up, minUsedBits: 16 => 58, startTimestamp: 0 => 1519858855, disks: 0 => 1, description: Node not seen in slobrok. => ]], distributor: [0: [Down => Up, minUsedBits: 16 => 58, startTimestamp: 0 => 1519858849, description: Node not seen in slobrok. => ], 1: [Down => Up, minUsedBits: 16 => 58, startTimestamp: 0 => 1519858851, description: Node not seen in slobrok. => ]]
[2018-02-28 23:02:16.078] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.ZooKeeperDatabase    Fleetcontroller 0: Storing new cluster state version in ZooKeeper: 3
[2018-02-28 23:02:16.092] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.SystemStateBroadcaster	       Publishing cluster state version 3
[2018-02-28 23:02:17.889] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Cluster event type SYSTEMSTATE @1519858937889: Reset 4 start timestamps as all available distributors have seen newest cluster state.
[2018-02-28 23:02:18.198] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: storage.0: Altered node state in cluster state from 'U, t 1519858855, b 58' to 'U, b 58'
[2018-02-28 23:02:18.199] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: distributor.0: Altered node state in cluster state from 'U, t 1519858849, b 58' to 'U, b 58'
[2018-02-28 23:02:18.199] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: storage.1: Altered node state in cluster state from 'U, t 1519858855, b 58' to 'U, b 58'
[2018-02-28 23:02:18.200] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Added node only event: Event: distributor.1: Altered node state in cluster state from 'U, t 1519858851, b 58' to 'U, b 58'
[2018-02-28 23:02:18.200] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.EventLog		       Cluster event type SYSTEMSTATE @1519858938197: New cluster state version 4. Change from last: version: 3 => 4, official: true => false, storage: [0: startTimestamp: 1519858855 => 0, 1: startTimestamp: 1519858855 => 0], distributor: [0: startTimestamp: 1519858849 => 0, 1: startTimestamp: 1519858851 => 0]
[2018-02-28 23:02:18.201] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.database.ZooKeeperDatabase    Fleetcontroller 0: Storing new cluster state version in ZooKeeper: 4
[2018-02-28 23:02:19.107] INFO    : container-clustercontroller Container.org.eclipse.jetty.server.Server				       jetty-9.4.8.v20171121, build timestamp: 2017-11-21T21:27:37Z, git hash: 82b8fb23f757335bb3329d540ce37a2a2615f0a8
[2018-02-28 23:02:19.458] INFO    : container-clustercontroller Container.org.eclipse.jetty.server.handler.ContextHandler		       Started o.e.j.s.ServletContextHandler@7a81065e{/,null,AVAILABLE}
[2018-02-28 23:02:19.465] INFO    : container-clustercontroller Container.com.yahoo.jdisc.http.server.jetty.JDiscServerConnector	       No channel set by activator, opening channel ourselves.
[2018-02-28 23:02:19.622] INFO    : container-clustercontroller Container.org.eclipse.jetty.server.AbstractConnector			       Started SearchServer@60e9c3a5{HTTP/1.1,[http/1.1]}{0.0.0.0:19050}
[2018-02-28 23:02:19.653] INFO    : container-clustercontroller Container.org.eclipse.jetty.server.Server				       Started @85774ms
[2018-02-28 23:02:19.657] INFO    : container-clustercontroller Container.com.yahoo.container.jdisc.ConfiguredApplication		       Switching to the latest deployed set of configurations and components. Application switch number: 0
[2018-02-28 23:02:26.175] INFO    : container-clustercontroller Container.com.yahoo.vespa.clustercontroller.core.SystemStateBroadcaster	       Publishing cluster state version 4
[2018-02-28 23:07:16.709] INFO    : slobrok          vespa-slobrok.rpcserver								       managed server null/default at tcp/admin0:36523 failed: disconnected
```


