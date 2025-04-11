# SSH Remote Server

## Multipass

Multipass allows you to launch and manage Ubuntu virtual machines easily. By using **bridged networking**, we can simulate real cloud VM behavior with direct IP access and SSH connections. This saves from relying on cloud environments for small projects.


## Steps to Set Up Your Local Cloud Environment

### 1. Install Multipass

Visit [https://multipass.run/](https://multipass.run/) and download the installer for your OS.


### 2. Launch Server


Run the following command to launch a server

```
multipass launch --name myvm
```
This will run a server on your local system to ssh into the machine you can run

```
multipass shell myvm
```

To simulate an actual server you would also require the username and ip of the server sadly running in this fashion will not give an IP address for your server you can confirm this by running the below command

```
multipass info myvm
```
You will see IP Address would be NA

To resolve this issue you can run the below command

```
multipass networks
```
This will provide a list of all available networks

Run a new server with 

```
multipass launch --name myvm-01 --network Wi-Fi <- Your Network Name
multipass info myvm-01
```
### 2. Working with SSH Key Pair

Creating ssh keys the following commad will create 2 files `cloud_vm` and `cloud_vm.pub`

```
ssh-keygen -t rsa -b 4096 -C "cloud_vm" -f ~/.ssh/cloud_vm
```

Copy the contents of `cloud_vm.pub` to `~/.ssh/authorized_keys` in server you can use multipass shell command mentioned above to do this.

Now you can login to you server using the below command similary you can create multiple keys and try it

```
ssh ubuntu@<ip_address>
```



