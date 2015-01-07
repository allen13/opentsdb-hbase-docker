##opentsdb-hbase-docker
Standalone OpenTsdb docker image, Hbase included! Run it with port 4242 exposed and navigate to localhost:4242 20 seconds later for fully functional opentsdb
######Pull from Docker Hub
    docker pull allen13/opentsdb-hbase
######Build Image
    make
######Deploy Image
    make deploy
######Destroy Deployed Image
    make destroy
######Shell into container
    make shell
