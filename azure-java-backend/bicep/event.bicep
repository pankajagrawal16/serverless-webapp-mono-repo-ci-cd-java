param location string = resourceGroup().location
param storageId string = ''
param functionApp string = ''
param devSubsriptionUrl string = ''

resource faceStorageTopic 'Microsoft.EventGrid/systemTopics@2021-12-01' = {
  name: 'faceStorageTopic'
  location: location
  properties: {
    source: storageId
    topicType: 'Microsoft.Storage.StorageAccounts'
  }
}
resource faceApp 'Microsoft.Web/sites@2021-03-01' existing = {
  name: functionApp
}

var systemKeyBlobExtension = listkeys('${resourceId('Microsoft.Web/sites', faceApp.name)}/host/default/','2021-02-01').systemkeys.blobs_extension

resource eventSubscription 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2021-12-01' = {
  parent: faceStorageTopic
  name: 'fileUploadSubsciption'
  properties: {
    destination: {
      properties: {
        endpointUrl: 'https://${faceApp.properties.defaultHostName}/runtime/webhooks/blobs?functionName=Host.Functions.file-upload-processor&code=${systemKeyBlobExtension}'
      }
      endpointType: 'WebHook'
    }
    filter: {
      includedEventTypes: [
        'Microsoft.Storage.BlobCreated'
      ]
    }
  }
}

resource eventSubscriptionDev 'Microsoft.EventGrid/systemTopics/eventSubscriptions@2021-12-01' = if (!empty(devSubsriptionUrl)) {
  parent: faceStorageTopic
  name: 'fileUploadSubsciptionDev'
  properties: {
    destination: {
      properties: {
        endpointUrl: '${devSubsriptionUrl}/runtime/webhooks/blobs?functionName=Host.Functions.file-upload-processor'
      }
      endpointType: 'WebHook'
    }
    filter: {
      includedEventTypes: [
        'Microsoft.Storage.BlobCreated'
      ]
    }
  }
}

