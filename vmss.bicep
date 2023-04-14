@description('Specifies the location for resources.')
param location string = resourceGroup().location

@description('Password for the Virtual Admin.')
@secure()
param adminUser string

@description('Password for the Virtual Machine.')
@minLength(12)
@secure()
param password string

// resourceGroup location 'westus'
// name 'myResourceGroup'

resource myImage 'Microsoft.Compute/images@2020-06-01' = {
  name: 'myImage'
  location: location
  properties: {
    storageProfile: {
      osDisk: {
        osType: 'Windows'
        osState: 'Generalized'
        name: 'myOsDisk'
        image: {
          uri: 'https://myStorageAccount.blob.core.windows.net/myContainer/myImage.vhd'
        }
      }
    }
  }
}

resource myScaleSet 'Microsoft.Compute/virtualMachineScaleSets@2020-06-01' = {
  name: 'myScaleSet'
  location: location
  properties: {
    sku: {
      name: 'Standard_DS1_v2'
      capacity: 1
    }
    storageProfile: {
      imageReference: {
        id: myImage.id
      }
      osDisk: {
        name: 'myOsDisk'
        caching: 'None'
        createOption: 'FromImage'
      }
    }
    osProfile: {
      computerNamePrefix: 'myVm'
      adminUsername: adminUser
      adminPassword: password
    }
    virtualMachineProfile: {
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: 'myNicConfig'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: 'myIpConfig'
                  properties: {
                    subnet: {
                      id: '/subscriptions/{subscriptionId}/resourceGroups/myResourceGroup/providers/Microsoft.Network/virtualNetworks/myVnet/subnets/mySubnet'
                    }
                    publicIPAddress: {
                      id: '/subscriptions/{subscriptionId}/resourceGroups/myResourceGroup/providers/Microsoft.Network/publicIPAddresses/myPublicIp'
                    }
                  }
                }
              ]
            }
          }
        ]
      }
      extensionProfile: {
        extensions: [
          {
            name: 'myExtension'
            properties: {
              settings: 'value1'
            }
          }
        ]
      }
    }
  }
}
