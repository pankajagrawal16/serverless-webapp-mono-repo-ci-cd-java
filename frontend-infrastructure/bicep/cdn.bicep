param location string = resourceGroup().location
param staticBlobUrl string = ''

var storageAccountHostName = replace(replace(staticBlobUrl, 'https://', ''), '/', '')
var profileName  = 'frontendcdn'
var endpointName = 'endpoint-${uniqueString(resourceGroup().id)}'


resource cdnProfile 'Microsoft.Cdn/profiles@2021-06-01' = {
  name: profileName
  location: location
  tags: {
    displayName: profileName
  }
  sku: {
    name: 'Standard_Verizon'
  }
}

resource endpoint 'Microsoft.Cdn/profiles/endpoints@2021-06-01' = {
  parent: cdnProfile
  name: endpointName
  location: location
  tags: {
    displayName: endpointName
  }
  properties: {
    originHostHeader: storageAccountHostName
    isHttpAllowed: true
    isHttpsAllowed: true
    queryStringCachingBehavior: 'IgnoreQueryString'
    contentTypesToCompress: [
      'text/plain'
      'text/html'
      'text/css'
      'application/x-javascript'
      'text/javascript'
    ]
    isCompressionEnabled: true
    origins: [
      {
        name: 'origin1'
        properties: {
          hostName: storageAccountHostName
        }
      }
    ]
  }
}

output hostName string = endpoint.properties.hostName
output originHostHeader string = endpoint.properties.originHostHeader
