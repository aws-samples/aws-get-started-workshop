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

## 1. Create customer gateway

Your first step is to register the on-premises side of your site-to-site VPN connection as a customer gateway in your AWS environment.

{{% notice tip %}}
**Simulating on-premises customer gateway:** If you're either experimenting with AWS Site-to-Site VPN connections or demonstrating how they work, you can easily simulate a customer on-premises environment and customer gateway. See [Simulating Site-to-Site VPN Customer Gateways Using strongSwan](https://aws.amazon.com/blogs/networking-and-content-delivery/simulating-site-to-site-vpn-customer-gateways-strongswan/) for details on setting up an open source based VPN gateway in a separate VPC that simulates an on-premises environment.
{{% /notice %}}

Register your on-premises customer gateway device in AWS:

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
|**`Name`**|`infra-dc1-01`|Accounting for the possibility of multiple customer gateway devices in each of multiple data centers.|
|**`Routing`**|`Dynamic Routing`||
|**`BGP ASN`**|`6500`|This is an example value.  Consult your Network team for the proper value that is assigned to the customer gateway in your on-premises environment.|
|**`IP Address`**|Public IP Address of your on-premises customer gateway||   
|**`Certificate ARN`**|If you're using certificate-based authentication, select the private certificate that you created to represent your customer gateway.<br><br>If you're using pre-shared key (PSK)-based authentication, leave blank.||
|**`Device`**|Leave empty||

## 2. Create a transit gateway

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
|**`Default route table association`**|**Unchecked**|Deselect this option so that you can have greater control over routing between your VPCs.|
|**`Default route table propagation`**|**Unchecked**|Since we're not using the transit gateway's default route table, deselect this option.|
|**`Auto accept shared attachments`**|Unchecked||

4. Select **`Create Transit Gateway`**

{{% notice info %}}
**Default Table Association and Propagation:** In this guide a single transit gateway is configured to enable your VPCs to reuse a common site-to-site VPN connection with your on-premises environment.  However, by default, we don't want to allow your production, test, and team development VPCs to connect to each other.  In this scenario, you'll want to avoid use of the transit gateway's default route table. Instead, this guide leads you through the set up of two transit gateway route tables so that you have greater control over connectivity and routing between your VPCs. Refer to the following VPC guides in regards to isolated VPCs and shared services. See [Isolated VPCs](https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-isolated.html) and [Isolated VPCs with shared services](https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-isolated-shared.html).
{{% /notice %}}

## 4. Create VPN transit gateway attachment

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
5. Once you're returned to the list of attachments, select the **`Name`** cell of the newly created attachment and assign a name to the attachment. For example, **`infra-dc1-01`**, the same name as your customer gateway resource. 

## 5. Assign name to site-to-Site VPN connection

As a result of the VPN attachment being provisioned, you will notice in the Site-to-Site VPN Connections area of the console that a new connection resource has been created. If you review the **`Tunnel Details`** of the connection, it will show both tunnels in the **`DOWN`** state because you have not yet configured the on-premises side of the connection.

Before you configure the on-premises side of the site-to-site VPN connection, assign a name to the site-to-site VPN connection:

1. Select **`Site-to-Site VPN Connections`**
2. Select the **`Name`** cell of the newly created site-to-site VPN connection and assign a name to it. For example, **`infra-dc1-01`**, the same name as your customer gateway resource.