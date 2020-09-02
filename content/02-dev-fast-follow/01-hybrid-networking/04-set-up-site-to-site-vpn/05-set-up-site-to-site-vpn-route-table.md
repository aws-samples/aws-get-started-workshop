---
title: 'Configure Transit Gateway Route Table for VPN'
menuTitle: '5. Configure VPN Route Table'
disableToc: true
weight: 50
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section, you'll create a dedicated transit gateway route table in the **`network-prod`** AWS account so that you have sufficient control over which of your VPCs can access the site-to-site VPN connection and the infrastructure shared services VPC that you'll set up in a later section.

{{< toc >}}

Review the transit gateway route table to verify that routing information for the on-premises CIDR is included.

1. Select **`Transit Gateway Route Tables`**
2. Click **`Create Transit Gateway Route Table`**
3. Provide the Transit Gateway Route Table details:

|Field|Recommendation|
|-----|---------------|
|**`Name`**|vpn-infra-shared-services-vpc|
|**`Transit Gateway ID`**|Select your transit gateway from the list|

Click **`Create Transit Gateway Route Table`**

Once the Transit Gateway Route Table is **`available`**, click on the **`Associations`** table at the bottom of the screen.
1. Click **`Create association`**
2. Choose the attachment to associate

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to associate`**|Choose the transit Gateway attachment id for the VPN attachment. (Later, after you create the infrastructure shared services VPC, you will add a VPC attachment for that VPC to this route table).|

Click **`Create association`**

Once the Association is **`associated`**, click on the **`Propagations`** tab
1. Click **`Create propagation`**
2. Choose the attachment to propagate

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to propogate`**|Choose the transit Gateway attachment id for the VPN attachment|

Click **`Create propagation`**

Click on the **`Routes`** tab and you should see that there is a route entry for your on-prem/VPN CIDR.

If you configured your site-to-site VPN connection to use BGP, then your customer gateway and the transit gateway will propagate routes to each other. However, your on-premises routes will not be automatically propagated from the transit gateway to you VPC route tables of the attached VPCs. You need to manually configure these route entries.