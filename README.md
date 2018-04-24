# quorum-docker
Quorum node v2.0.0 using docker

## Setup
1. This is one node Quorum setup
2. Run multiple nodes by maintaining separate directory for each and adding required files into qdata.
3. `nodeKey` and `tm.pub` and `tm.key`(key-pair for Constellation node) can be generatedd using command line(Geth and Constellation).
4. Change url and add othernodes IP in tm.conf.
5. Update static-nodes.json.
6. run `docker-compose up -d node`
