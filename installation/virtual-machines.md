# Virtual Machines

## KVM

```sh
sudo apt install -y qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils virt-manager
sudo usermod -aG kvm,libvirt $USER
```

## VirtualBox

Install VirtualBox

```sh
sudo usermod -aG vboxusers $USER
```
