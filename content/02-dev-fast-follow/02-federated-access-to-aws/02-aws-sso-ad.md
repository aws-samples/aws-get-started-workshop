---
title: 'AWS SSO and Microsoft Active Directory'
menuTitle: 'AWS SSO and Active Directory'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section explores the detailed design to connect AWS SSO with Self-Managed Active Directory or AWS Managed Active Directory solutions.


## AWS SSO and AWS Managed Active Directory

In this configuration, AWS SSO is configured to use AD Connector as an identity source. AD Connector is running in shared subnets from the Infrastructure Shared Services VPC. The subnets are shared using [Resource Access Manager](https://aws.amazon.com/ram/) from the Shared Services account to the Master account. To learn how to share subnets (or other resources), review the [RAM Documentation](https://docs.aws.amazon.com/ram/latest/userguide/getting-started-sharing.html) or review the existing ["Getting Started" guidance on sharing subnets](/01-dev/02-establish-initial-foundation/05-set-up-common-dev-network.html#8-share-private-subnets-with-development-ou). This keeps Active Directory in an Infrastructure Shared Services VPC and does not require a dedicated VPC in the Master account, which simplifies the network. Consider the following diagram:
[![AWS SSO Managed AD](/images/02-dev-fast-follow/02-federated-access-to-aws/awsssomad.png)](/images/02-dev-fast-follow/02-federated-access-to-aws/awsssomad.png)
In this diagram, we have a Corporate Datacenter on the left with two self-managed Active Directory Domain Controllers configured in an Active Directory Site (let's call it CorpDC). It is connected to an AWS Network account over a VPN or Direct Connect connection. For most customers starting off, VPN will work fine here and is the faster option to set up. See [On-premises Network Integration]({{< relref "01-hybrid-networking" >}}) for details on establishing a site-to-site VPN connection.

A Transit Gateway (TGW) is hosted in the Network account and is shared using Resource Access Manager with the Infrastructure Shared Services account. The Transit Gateway has an attachment to the Infrastructure Shared Services VPC. The Transit Gateway Route Tables (not shown) allow communication with On-Premises over the VPN or Direct Connect connection, and the Infrastructure Shared Services Account VPC has route tables allowing communication with On-Premises subnets over the Transit Gateway attachment. You have configured AWS Managed Active Directory in the Shared Services and it is deployed across multiple Availability Zones.

In this configuration you could define a two-way or one-way trust with your existing self-managed Active Directory Domain Controllers that live on-premises so that existing users can authenticate to AWS SSO, or other Computers that are joined to the AWS Managed Active Directory domain. Alternatively, AWS Managed Active Directory could house **both** users and computers, which would not require a VPN or Direct Connect (however you may want this for other purposes like reachback).

From here you can [share out AWS Managed Active Directory to other AWS Accounts in your Organization to enable Windows seamless domain join](https://docs.aws.amazon.com/directoryservice/latest/admin-guide/ms_ad_tutorial_directory_sharing.html), so long as VPCs in other accounts are also connected by Transit Gateway to the Shared Services VPC. This is a cool feature that is especially useful for Windows-based EC2s.

The advantage of this design is that you do not need a dedicated VPC in the Master account for AWS SSO. AWS Managed Active Directory and AD Connector are effectively in the same subnets, reducing network egress traffic, and simplifying the network design. AWS SSO must link to a Directory that is created in its own account, and that Directory in this case is AD Connector.

{{% notice info %}}
You do not have "Domain Admin" or "Enterprise Admin" permissions in AWS Managed Active Directory. This is so AWS can manage the operating system and domain functionality on your behalf. Consider this trade-off when evaluating AWS Managed Active Directory. However, an OU is pre-created where you will have full Administrative privileges. You will store computers, users, other OUs and resources in this OU.
{{% /notice %}}

## AWS SSO and On-Premises Self-Managed Active Directory

This is a similar configuration to above, simply replacing AWS Managed Active Directory with self-managed Active Directory.
[![AWS SSO Managed AD](/images/02-dev-fast-follow/02-federated-access-to-aws/AWSSSO_AD.png)](/images/02-dev-fast-follow/02-federated-access-to-aws/AWSSSO_AD.png)

In this diagram, we have a Corporate Datacenter on the left with two self-managed Active Directory Domain Controllers configured in an Active Directory Site (let's call it CorpDC). It is connected to an AWS Network account over a VPN or Direct Connect connection. Transit Gateway is shared across 2 AWS accounts: Network and Shared Services with attachments to VPCs hosted in each account (attachments not shown for diagram clarity). Appropriate route tables are in place on the Transit Gateway and the VPCs to allow on-premises and communication from Shared Services VPC (ie, they must be part of the same TGW propogation table).

Self-Managed Active Directory Domain Controllers are hosted in a Shared Services VPC. These Domain Controllers are part of the same Active Directory Forest as those hosted on-premises, however they are part of a different AD Site (in AD Sites and Services). This is done so that resources in AWS authenticate to domain controllers in AWS, avoiding data transfer across the VPN or DX link. To promote new Domain Controllers, the VPC must have an appropriate DHCP option set configuring DNS to point to the existing Domain Controllers hosted on-premises.

AD Connector has been deployed from the Master account into the subnets shared from the Shared Services account, pointing to the IP addresses of the self-managed Active Directory domain controllers in the Shared Services VPC. AWS SSO has been configured to use AD Connector in the Master account as a directory.

The advantage of this design is that customers retain Domain Admin / Enterprise Admin privileges across the whole domain. It also extends the existing directory versus setting up a new Directory/Forest. Additionally these Domain Controllers could be used as a [centralized DNS service for all connected VPCs](https://aws.amazon.com/blogs/security/simplify-dns-management-in-a-multiaccount-environment-with-route-53-resolver/). You also have a second copy of the directory in the cloud, meaning that if there was a network connectivity issue on the VPN or Direct Connect, users can still authenticate.
The disadvantage of this design is the added overhead for you to patch and maintain the Domain Controller EC2 instances.

To get started with a step-by-step guide, here are some resources:
* [Extend a self-managed Active Directory to AWS Control Tower](https://aws.amazon.com/blogs/mt/extend-a-self-managed-active-directory-to-aws-control-tower/)
* [Connect AWS SSO to AWS Managed Active Directory](https://docs.aws.amazon.com/singlesignon/latest/userguide/connectawsad.html) running in a VPC in the Master account
* [Connect AWS SSO to an On-Premises Active Directory](https://docs.aws.amazon.com/singlesignon/latest/userguide/connectonpremad.html) using a VPC in the Master Account that has an established VPN or Direct Connect connection to the on-premises datacenter.
* [How to Connect Your On-Premises Active Directory Using AD Connector](https://aws.amazon.com/blogs/security/how-to-connect-your-hybrid-active-directory-to-aws-using-ad-connector/)
