// Work in progress...

metadata description = 'Create a simple AKS cluster with two app deployments, where one application is deployed with Kubernetes manifests and Bicep Kubernetes provider and the other application is diplayed with Helm chart and AKS run Helm script for Bicep.'

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
        osSKU: 'AzureLinux'
        mode: 'System'
      }
      {
        name: 'userpool'
        count: 1
        vmSize: nodePoolSize
        osType: 'Linux'
        osSKU: 'AzureLinux'
        mode: 'User'
      }
    ]
  }
}
