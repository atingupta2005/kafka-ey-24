subscriptions="ey-kafka-1,ey-kafka-2,ey-kafka-3"
subscriptions="ey-trng-1,ey-trng-2,ey-trng-2-new"


readarray -d "," -t all_subscriptions <<< "$subscriptions"

az account show
locations="eastus,eastus2,centralus,northeurope,japaneast,uksouth,southcentralus,australiaeast,koreacentral"
locations="eastus,centralus"

readarray -d "," -t all_locations <<< "$locations"

username="atingupta2005"
password="Azure@123456" # Replace with your desired password
vm_size="Standard_B2ms"
image="Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest"

# Define the number of VMs to create

num_vms=3

for current_subscription in ${all_subscriptions[@]}
do
 echo "Working on Subscription: $current_subscription"
 az account set --subscription $current_subscription
 for location in ${all_locations[@]}
 do
  echo "Working on location: $location"
  resource_group="rg-kafka-vms-$location"
  # echo az group create --name $resource_group --location $location
  az group create --name $resource_group --location $location
  for ((i=1; i<=$num_vms; i++)); do
      vm_name="vm-kafka$i"
      vm_dns_name="vm-jkp-kfk$i"

      # Create the VM
      az vm create --resource-group $resource_group --name $vm_name --image $image --admin-username $username --admin-password $password --location $location --size $vm_size --authentication-type password --storage-sku Standard_LRS --public-ip-sku Basic --public-ip-address-allocation static --no-wait
  done
  
  az vm list -o table

 done
done