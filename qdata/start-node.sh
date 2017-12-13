#!/bin/bash

set -u
set -e

rm -rf /qdata/logs
rm -rf /qdata/dd
mkdir -p /qdata/logs

echo "================ Configuring node ================"
mkdir -p /qdata/dd/keystore
mkdir -p /qdata/dd/geth
cp /qdata/static-nodes.json /qdata/dd
cp /qdata/key /qdata/dd/keystore
cp /qdata/nodekey /qdata/dd/geth/nodekey
geth --datadir /qdata/dd init /qdata/genesis.json
sleep 4
GLOBAL_ARGS="--raft --rpc --rpcaddr 0.0.0.0 --rpcapi admin,db,eth,debug,miner,net,shh,txpool,personal,web3,quorum --emitcheckpoints"
echo "================ Starting Constellation process ================"
nohup constellation-node /qdata/tm.conf 2>> /qdata/logs/constellation.log &
sleep 4
echo "================ Starting Geth process================"
PRIVATE_CONFIG=/qdata/tm.conf nohup geth --datadir /qdata/dd $GLOBAL_ARGS --raftport 50401 --rpcport 22000 --port 21000 --unlock 0 --password /qdata/passwords.txt 2

