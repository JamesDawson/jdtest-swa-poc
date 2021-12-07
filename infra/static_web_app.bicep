param appLocation string
param location string = resourceGroup().location
param siteName string
@secure()
param repositoryToken string
param repositoryUrl string
@allowed([
  'DevOps'
  'GitHub'
])
param provider string

param branch string = 'main'
param allowConfigFileUpdates bool = true
@allowed([
  'Free'
  'Standard'
])
param skuNme string = 'Free'
@allowed([
  'Enabled'
  'Disabled'
])
param stagingEnvironmentPolicy string = 'Enabled'

resource swa 'Microsoft.Web/staticSites@2021-02-01' = {
  name: siteName
  location: location
  sku: {
    name: skuNme
  }
  properties: {
    provider: provider
    repositoryToken: repositoryToken
    repositoryUrl: repositoryUrl
    branch: branch
    stagingEnvironmentPolicy: stagingEnvironmentPolicy
    allowConfigFileUpdates: allowConfigFileUpdates
    buildProperties: {
      appLocation: appLocation
      skipGithubActionWorkflowGeneration: false
    }
  }
}
