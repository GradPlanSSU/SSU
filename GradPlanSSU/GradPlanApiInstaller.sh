#!/bin/bash
echo "Extracting GradPlanSSUAPI"
tar -xvf GradPlanSSUAPI.tar 
echo "Running NPM Install"
cd GradPlanSSUAPI/
npm install
echo "Running NPM Update"
npm update
echo "Installing forever"
npm install forever --save
echo "Environment correctly set up. Execute with ./GradPlanApi.sh"
