@description('Specifies the location for resources.')
param location string = 'westeurope'

targetScope =  'subscription'

resource staticsite 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  location: location
  name: 'staticwebsite'
}

module site 'site.bicep' = {
  name: 'frontendsite'
  scope: staticsite
  params: {
    location: location
  }
}
