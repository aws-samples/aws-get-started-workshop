---
title: 'Configure Customer Gateway and Transit Gateway'
menuTitle: '3. Configure Gateways'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section you'll create the following resources in your in the **`network-prod`** AWS account:

* Customer gateway
* Transit gateway
* VPN transit gateway attachment

After create these resources, in the next section, you'll set up your customer on-premises side of the site-to-site VPN connection.

{{< toc >}}

## 1. Create Customer Gateway

Register your on-premises customer gateway device in AWS.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`network-prod`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**
6. Select **`Customer Gateways`**
7. Select **`Create Customer Gateway`**
8. Provide the Customer Gateway details:

|Field|Recommendation|Notes|
|-----|---------------|----|
|**`Name`**|`infra-on-prem-dc1-gw1`|Accounting for the possibility of multiple customer gateway devices in each of multiple data centers.|
|**`Routing`**|`Dynamic Routing`||
|**`BGP ASN`**|`6500`||
|**`IP Address`**|Public IP Address of your on-premises customer gateway||   
|**`Certificate ARN`**|Leave empty||
|**`Device`**|Leave empty||

{{% notice info %}}
**Pre-shared Key and Certificate Options:** These example set up instructions use the pre-shared key option to authenticate your Site-to-Site VPN tunnel endpoints.  If you don't want to use pre-shared keys, you can use a private certificate from AWS Certificate Manager Private Certificate Authority to authenticate your VPN endpoints. See [Site-to-Site VPN tunnel authentication options](https://docs.aws.amazon.com/vpn/latest/s2svpn/vpn-tunnel-authentication-options.html).
{{% /notice %}}

## 2. Create a Transit Gateway

1. Select **`Transit Gateways`**
2. Select **`Create Transit Gateway`**
3. Provide the Transit Gateway details:

|Field|Recommendation|Notes|
|-----|---------------|----|
|**`Name tag`**|infra-main|You'll be able to use a single transit gateway for both on-premises integration and VPC-to-VPC routing if necessary.|
|**`Description`**|||
|**`Amazon side ASN`**|Consult your Network team|One consideration is to use a unique private ASN per transit gateway to provide more flexible routing options.|
|**`DNS support`**|checked||
|**`VPN ECMP support`**|checked|Enables you to use multiple VPN connections to aggregate VPN throughput.|
|**`Default route table association`**|**Unchecked**|Uncheck this option so you can specify which routing is allowed between accounts and environments|
|**`Default route table propagation`**|**Unchecked**|Uncheck this option so that you don't enable any-to-any connectivity between attachments by default.|
|**`Auto accept shared attachments`**|Unchecked||

4. Select **`Create Transit Gateway`**

{{% notice info %}}
**Default Table Association and Propagation:** Refer to the following VPC guides in regards to isolated VPCs and shared services. See [Isolated VPCs](https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-isolated.html) and [Isolated VPCs with shared services](https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-isolated-shared.html).  In cases where you want development environments to be able to communicate to one another (or like for like environments), but do not want dev to talk to test and/or prod, you will want to manage the route table associations manually.  This will take some additional effort, however, will ensure that you proper environment communication isolation in place.
{{% /notice %}}

## 4. Create VPN Transit Gateway Attachment

1. Select **`Transit Gateway Attachments`**
2. Select **`Create Transit Gateway Attachment`**
3. Provide the Transit Gateway Attachment form details:

|Field|Recommendation|
|-----|---------------|
|**`Transit Gateway ID`**|Select your transit gateway|
|**`Attachment Type`**|VPN|
|**`Customer Gateway`**|Existing|
|**`Customer Gateway ID`**|Select value from the list that matches the ID of the Customer Gateway you just created.|
|**`Routing options`**|Dynamic (requires BGP)|
|**`Enable acceleration`**|Leave unchecked|
|**`Tunnel Options`**|Leave unchecked|

4. Select **`Create attachment`**.
5. Once you're returned to the list of attachments, select the **`Name`** cell of the newly created attachment and assign a name to the attachment. For example, **`infra-on-prem-dc1-gw1`**, the same name as your customer gateway resource. 

{{% notice info %}}
**Site-to-Site VPN Connection:** As a result of the VPN attachment being provisioned, you will notice in the Site-to-Site VPN Connections area of the console that a new connection resource has been created. If you review the **`Tunnel Details`** of the connection, it will show both tunnels in the **`DOWN`** state because you have not yet configured the on-premises side of the connection.
{{% /notice %}}