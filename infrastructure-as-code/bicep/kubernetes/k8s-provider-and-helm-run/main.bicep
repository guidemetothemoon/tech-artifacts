// Work in progress...

@description('AKS cluster name.')
param clusterName string = 'aks-dev-ktcu'

@description('Region to deploy AKS cluster to.')
param location string = resourceGroup().location

@description('The size of the Virtual Machine.')
param nodePoolSize string = 'Standard_B2s'

resource aks 'Microsoft.ContainerService/managedClusters@2023-07-02-preview' = {
  name: clusterName
  location: location
  sku:{
    name: 'Base'
    tier: 'Free'
  }
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    dnsPrefix: '${clusterName}-dns'
    kubernetesVersion: '1.27.7'
    agentPoolProfiles: [
      {
        name: 'syspool'
        count: 1
        vmSize: nodePoolSize
        osType: 'Linux'
        mode: 'System'
      }
      {
        name: 'userpool'
        count: 1
        vmSize: nodePoolSize
        osType: 'Linux'
        mode: 'User'
      }
    ]
  }
}
