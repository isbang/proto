#!/bin/sh

syncGoogleProto() {
  echo "[sync] google/protobuf"
  git clone https://github.com/protocolbuffers/protobuf.git .tmp/protobuf
  rm -rf ./google/protobuf
  cp -r .tmp/protobuf/src/google/protobuf ./google/protobuf

  find google/protobuf -mindepth 1 -maxdepth 1 -type d -exec rm -r {} \;
  find google -type f -not -name "*.proto" -delete
  find google -type f -name "*test*" -delete

  rm -rf .tmp/protobuf
}

syncGoogleApi() {
  echo "[sync] google/api, google/type"
  git clone https://github.com/googleapis/googleapis.git .tmp/googleapis
  rm -rf ./google/api ./google/type
  cp -r .tmp/googleapis/google/api ./google/api
  cp -r .tmp/googleapis/google/type ./google/type

  find google/api -type f -not -name "*.proto" -delete
  find google/api -type d -empty -delete

  find google/type -type f -not -name "*.proto" -delete
  find google/type -type d -empty -delete

  rm -rf .tmp/googleapis
}

syncEnvoyValidation() {
  echo "[sync] validate"
  git clone https://github.com/envoyproxy/protoc-gen-validate.git .tmp/protoc-gen-validate
  rm -rf ./validate
  cp -r .tmp/protoc-gen-validate/validate ./validate

  find validate -type f -not -name "*.proto" -delete

  rm -rf .tmp/protoc-gen-validate
}

syncGoogleProto \
&& syncGoogleApi \
&& syncEnvoyValidation
