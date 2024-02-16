az account show
resource_group="rg-kafka-vms"
location="eastus"
username="atingupta2005"
password="Azure@123456" # Replace with your desired password
vm_size="Standard_B2s"
image="Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest"

# Define the number of VMs to create

num_vms=3

az group create --name $resource_group --location $location

# Loop to create multiple VMs

for ((i=1; i<=$num_vms; i++)); do
    vm_name="ubuntu-vm-kafka$i"

    # Create the VM
    az vm create \
        --resource-group $resource_group \
        --name $vm_name \
        --image $image \
        --admin-username $username \
        --admin-password $password \
        --location $location \
        --size $vm_size \
        --authentication-type password \
        --storage-sku Standard_LRS \
        --public-ip-sku Basic \
        --public-ip-address-dns-name $vm_name
        --no-wait

done

az vm list --resource-group $resource_group -o table
az vm list --resource-group $resource_group -o yaml

