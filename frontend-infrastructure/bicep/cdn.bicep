param location string = resourceGroup().location
param staticWebsiteUrl string = ''
param dnsZoneName string = ''
param cdnface string = 'cd-face'

var storageAccountHostName = replace(replace(staticWebsiteUrl, 'https://', ''), '/', '')
var profileName  = 'frontendcdn'
var endpointName = 'endpoint-${uniqueString(resourceGroup().id)}'

resource dnsZone 'Microsoft.Network/dnsZones@2018-05-01' existing = {
  name: dnsZoneName
}

resource cdnProfile 'Microsoft.Cdn/profiles@2022-05-01-preview' = {
  name: profileName
  location: location
  tags: {
    displayName: profileName
  }
  sku: {
    name: 'Standard_Verizon'
  }
}

resource endpoint 'Microsoft.Cdn/profiles/endpoints@2022-05-01-preview' = {
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

resource facerecog 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  parent: dnsZone
  name: cdnface
  properties: {
    targetResource: {
      id: endpoint.id
    }
    TTL: 15
  }
}

// resource customdomain 'Microsoft.Cdn/profiles/customDomains@2022-05-01-preview' = {
//   name: cdnface
//   parent: cdnProfile
//   properties: {
//     hostName: '${cdnface}.pankaagr.cloud'
//     tlsSettings: {
//       certificateType: 'AzureFirstPartyManagedCertificate'
//     }
//   }
// }

resource symbolicname 'Microsoft.Cdn/profiles/endpoints/customDomains@2022-05-01-preview' = {
  name: cdnface
  parent: endpoint
  properties: {
    hostName: '${cdnface}.pankaagr.cloud'
  }
}

output hostName string = endpoint.properties.hostName
output originHostHeader string = endpoint.properties.originHostHeader
