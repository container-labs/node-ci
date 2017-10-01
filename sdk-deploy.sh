#!/bin/bash

set +ex

# expected arguments are
# folder environment function name => then the rest

SOURCE_FOLDER=$1
NODE_ENV=$2
FUNCTION_NAME=$3

# transpile
cd $SOURCE_FOLDER
echo "transpiling $SOURCE_FOLDER for $NODE_ENV environment"
npm install
npm run "package-functions-${NODE_ENV}"

# TODO: create the source contexts
# this doesn't work right now because we'd need to
#   1. commit the transpiled code
#   2. create these source files
#   3. push that back to GitHub and do a deploy
# gcloud debug source gen-repo-info-file --output-directory functions

# deploy
DEPLOY_COMMAND="gcloud beta functions deploy ${FUNCTION_NAME}-${NODE_ENV} ${@:4} --stage-bucket test-charlotte"
echo "deploying $DEPLOY_COMMAND"
cd functions && $DEPLOY_COMMAND
