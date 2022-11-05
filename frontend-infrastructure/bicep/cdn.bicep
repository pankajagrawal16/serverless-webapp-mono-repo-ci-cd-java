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

resource msCdn 'Microsoft.Cdn/profiles@2022-05-01-preview' = {
  name: 'ms${profileName}'
  location: location
  tags: {
    displayName: 'ms${profileName}'
  }
  sku: {
    name: 'Standard_Microsoft'
  }
}

resource msEndpoint 'Microsoft.Cdn/profiles/endpoints@2022-05-01-preview' = {
  parent: msCdn
  name: 'ms${endpointName}'
  location: location
  tags: {
    displayName: 'ms${endpointName}'
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
    deliveryPolicy: {
      rules:  [
       {
        actions: [
          {
            name: 'UrlRedirect'
            parameters: {
              redirectType: 'Found'
              typeName: 'DeliveryRuleUrlRedirectActionParameters'
              destinationProtocol:'Https'
            }
          }
        ]
        conditions:[
          {
            name: 'RequestScheme'
            parameters: {
              operator: 'Equal'
              typeName: 'DeliveryRuleRequestSchemeConditionParameters'
              matchValues: [
                'HTTP'
              ]
              negateCondition:false
            }
          }
        ]
        order: 1
        name: 'redirect'
       } 
      ]
    }
  }
}

resource msfacerecog 'Microsoft.Network/dnsZones/CNAME@2018-05-01' = {
  parent: dnsZone
  name: 'ms${cdnface}'
  properties: {
    targetResource: {
      id: msEndpoint.id
    }
    TTL: 15
  }
}

resource msSymbolicName 'Microsoft.Cdn/profiles/endpoints/customDomains@2022-05-01-preview' = {
  name: 'ms${cdnface}'
  parent: msEndpoint
  properties: {
    hostName: 'ms${cdnface}.pankaagr.cloud'
  }
  dependsOn: [
    msfacerecog
  ]
}

output hostName string = msEndpoint.properties.hostName
output originHostHeader string = msEndpoint.properties.originHostHeader
