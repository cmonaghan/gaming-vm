# gaming-vm
A general purpose Windows gaming VM

## Prerequisites

* You must install terraform: https://www.terraform.io/downloads.html
* [Download Steam](https://store.steampowered.com/about/)
* Download Windows Remote Desktop ([mac](https://apps.apple.com/us/app/microsoft-remote-desktop-10/id1295203466?mt=12), [windows](https://www.microsoft.com/en-us/p/microsoft-remote-desktop/9wzdncrfj3ps?activetab=pivot:overviewtab))

## Provisioning

Run these two commands:

    export TF_VAR_my_ip=`curl http://checkip.amazonaws.com`
    terraform apply

If you decide you want to use a more powerful machine (and pay more for it), then modify the second command to  `terraform apply -var="instance_type=g2.2xlarge"` which will override the default with a more powerful machine. (Note that this may require increasing your account limits by filing a ticket with AWS support.)

## Logging into your gaming VM

1. copy the exported DNS value from your terraform apply (e.g. "ec2-52-90-145-99.compute-1.amazonaws.com")
2. Open Windows Remote Desktop
3. Click the "+" sign then "Add PC"
4. Paste the DNS value into the "PC Name" field
5. Under the "User Account" dropdown, select "Add User Account...". Set Username to `Administrator`. Enter the password, which you can find in 1password.
6. Under the "Display" tab, select your desired resolution. For playing Age of Empires from a macbook, I suggest unchecking the box "Optimize for Retina displays" and selecting 1280x800.
