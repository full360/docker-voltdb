#! /usr/bin/env bash

if [ -z "$VOLTDB_COM_VERSION" ]; then
  echo "Setting up VoltDB version from the script..."
  VOLTDB_COM_VERSION=6.4
fi

if [ -z "$VOLTDB_DIR" ]; then
  VOLTDB_DIR=/home/ec2-user/voltdb
  echo "Current VoltDB dir $VOLTDB_DIR..."
fi

function copy_compiled_files {
  mkdir -p voltdb-com-${VOLTDB_DIR}/third_party

  cp -R $VOLTDB_DIR/{LICENSE,README.md,README.thirdparty,bin,bundles,doc,examples,lib,third_party/python,tools,version.txt,voltdb} \
    voltdb-com-${VOLTDB_COM_VERSION}/

  mv voltdb-com-${VOLTDB_COM_VERSION}/python voltdb-com-${VOLTDB_COM_VERSION}/third_party
}

copy_compiled_files
