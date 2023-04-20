// Parameters

// All
param location string = resourceGroup().location

param tags object

// Subnet
param vnetName string

param addressPrefixes array

param ipSubnets array

// Bastion
param bastionPubIpName string

param bastionName string


// Run

module serviceBusNamespace './servicebus/createservicebus.bicep' = {
  name: 'serviceBusNamespaceDeploy'
  params: {
    location: location
   // tags: tags
  }

}

module serviceBusQueue './servicebus/createservicebus.bicep' = {
  name: 'serviceBusQueueDeploy'
 
}





module vnet './vnet/vnet.bicep' = {
  name: 'vnetDeploy'
  params: {
    location: location
    tags: tags
    ipSubnets: ipSubnets
    vnetName: vnetName
    addressPrefixes: addressPrefixes
  }
}

module bastion './bastion/bastionhost.bicep' = {
  name: 'bastionDeploy'
  params: {
    bastionPubIpName: bastionPubIpName
    bastionName: bastionName
    location: location
    tags: tags
    vnetId: vnet.outputs.vnetId
  }
}

