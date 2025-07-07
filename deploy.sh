#!/bin/bash

RESOURCE_GROUP="myapp-rg"
APP_NAME="myapp-react-node$RANDOM"
LOCATION="eastus"
PLAN_NAME="myapp-plan"

az group create --name $RESOURCE_GROUP --location $LOCATION
az appservice plan create --name $PLAN_NAME --resource-group $RESOURCE_GROUP --sku B1 --is-linux

az webapp create --resource-group $RESOURCE_GROUP \
  --plan $PLAN_NAME \
  --name $APP_NAME \
  --runtime "NODE|18-lts"

cd client
npm install
npm run build
cd ..

cd server
npm install
cd ..

zip -r app.zip .

az webapp deployment source config-zip \
  --resource-group $RESOURCE_GROUP \
  --name $APP_NAME \
  --src app.zip

az webapp browse --name $APP_NAME --resource-group $RESOURCE_GROUP