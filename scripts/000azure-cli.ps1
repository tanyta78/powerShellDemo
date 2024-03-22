####### NEEDS AZURE ACCOUNT AND LOCAL INSTALL #######

###### Exersize #####
# create an azure website using the cli
# az login
# az group create
# created varables needed for commands
export RESOURCE_GROUP=learn-bd231283-454a-4f0b-896a-0869b5fa2358
export AZURE_REGION=eastus
export AZURE_APP_PLAN=popupappplan-$RANDOM
export AZURE_WEB_APP=popupwebapp-$RANDOM

# list group resources in a table
az group list --output table

# with this command we can see plans prices and so on
az appservice plan create --help

# create app service plan to run an  - free 
az appservice plan create --name $AZURE_APP_PLAN --resource-group $RESOURCE_GROUP --location $AZURE_REGION --sku FREE

# check plan creation
az appservice plan list --output table

# create a web app
az webapp create --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --plan $AZURE_APP_PLAN

# check creation
az webapp list --output table

# deploy code from github
az webapp deployment source config --name $AZURE_WEB_APP --resource-group $RESOURCE_GROUP --repo-url "https://github.com/Azure-Samples/php-docs-hello-world" --branch master --manual-integration