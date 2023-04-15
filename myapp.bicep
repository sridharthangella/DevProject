targetScope = 'subscription'
param location string = 'eastus'
param webAppName string
param appServicePlanName string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-02-01' = {
  name: appServicePlanName
  location: location
  kind: 'app'
  sku: {
    name: 'B1'
    tier: 'Basic'
  }
}

resource webApp 'Microsoft.Web/sites@2021-02-01' = {
  name: webAppName
  location: location
  kind: 'app'
  dependsOn: [appServicePlan]
  properties: {
    serverFarmId: appServicePlan.id
  }
}
