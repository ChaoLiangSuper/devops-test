#!/bin/bash

# This file is used for simulating the CI process
cd test-app
yarn test --watchAll=false
yarn build