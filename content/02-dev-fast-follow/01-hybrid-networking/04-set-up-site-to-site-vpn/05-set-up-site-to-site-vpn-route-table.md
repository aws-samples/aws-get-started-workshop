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

In this section, you'll create the first of two transit gateway route tables in the **`network-prod`** AWS account so that you have control over which of your VPCs can access the site-to-site VPN connection and the infrastructure shared services VPC that you'll set up in a later section.

{{< toc >}}

## 1. Create Transit Gateway Route Table

Create a transit gateway route table for the site-to-site VPN connection and the infrastructure shared services VPC that you'll be creating in another section:

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`network-prod`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**
6. Select **`Transit Gateway Route Tables`**
7. Select **`Create Transit Gateway Route Table`**
8. Provide the Transit Gateway Route Table details:

|Field|Recommendation|
|-----|---------------|
|**`Name`**|vpn-infra-shared-services-vpc|
|**`Transit Gateway ID`**|Select your transit gateway from the list|

9. Select **`Create Transit Gateway Route Table`**

## 2. Associate Route Table with VPN Attachment

1. Once the state of the Transit Gateway Route Table transitions to **`available`**, select the **`Associations`** table at the bottom of the screen.  You might have to refresh the page to see the state change.
2. Select **`Create association`**
3. Select the attachment to associate:

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to associate`**|Choose the transit gateway attachment id for the VPN attachment. (Later, after you create the infrastructure shared services VPC, you will also associate the VPC attachment for that VPC with this route table).|

4. Select **`Create association`**

## 3. Create Propagation

1. Once the state of the Association transitions to **`associated`**, select on the **`Propagations`** tab. You might have to refresh the page to see the state change.
2. Select **`Create propagation`**
3. Select the attachment to propagate

|Field|Recommendation|
|-----|---------------|
|**`Choose attachment to propogate`**|Select the transit gateway attachment id for the VPN attachment|

4. Select **`Create propagation`**

## 4. Confirm Propagation of On-Premises Routing Information

1. Select the **`Routes`** tab.
2. If you configured your site-to-site VPN connection to use BGP, then you should see the routing information for your on-premises network listed in the **`Routes`** section.