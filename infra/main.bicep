param appLocationInRepo string
param resourceGroupName string
param siteName string
@secure()
param repositoryToken string
param repositoryUrl string
@allowed([
  'DevOps'
  'GitHub'
])
param repoProvider string

param timestamp string = utcNow()

targetScope = 'subscription'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: deployment().location
}

module swa './static_web_app.bicep' = {
  scope: rg
  name: 'swa-${timestamp}'
  params: {
    appLocation: appLocationInRepo
    location: rg.location
    provider: repoProvider
    repositoryToken: repositoryToken
    repositoryUrl: repositoryUrl
    siteName: siteName
  }
}
