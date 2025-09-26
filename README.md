# DevOps-Project-BankApp-terraform-upgrade-to-opentofu-secure-kubernetes-clusters

In AKS if EncryptionAtHost is not enabled at the subscription level then enable it using the command as shown below. when you set host_encryption_enabled = true in your terraform script then you should run the below command if EncryptionAtHost is not enabled in your Azure Account subscription.

az feature register --namespace Microsoft.Compute --name EncryptionAtHost
