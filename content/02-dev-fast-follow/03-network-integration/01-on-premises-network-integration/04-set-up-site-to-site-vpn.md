---
title: 'Establish Site-to-Site VPN Connection'
menuTitle: 'Establish Site-to-Site VPN'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section provides detailed step-by-step instructions for using AWS Site-to-Site VPN and AWS Transit Gateway as a means to quickly and securely establish network connectivity between your on-premises and AWS environments. 

By following these instructions, you will enable network connectivity between your on-premises environment and the centrally managed development VPC you established earlier in this guide.

Later in this guide, when you set up your test and production VPCs, the steps required to enable those VPCs to reuse your site-to-site VPN connection will be addressed.  The process in your AWS environment will be largely a repeat of the steps in this section that are used to connect your development VPC to your on-premises network.

{{% notice tip %}}
**Set up a virtual on-premises environment:** If you don't have access to an actual on-premises data center environment and you'd like to either evaluate or demonstrate the AWS Site-to-Site VPN capabilities, see [Setting Up a Virtual On-Premises Environment]({{< relref "05-virtual-on-premises" >}}) for instructions on how to set up a test on-premises environment in AWS.  You can deploy either open source or commercial VPN/router appliances in your virtual on-premises environment to act as the customer gateway device.
{{% /notice %}}

{{< toc >}}

## 1. Ensure Pre-requisites Are Satisfied

First, ensure that the following pre-requisites are satisfied:

### Engage Your On-Premises Network Team

In order to effect the necessary on-premises network configuration changes required by your AWS Site-to-Site VPN connection, you'll need to engage your Network team.  It's recommended that you review the overall requirements and solution design with them before proceeding with the configuration work.

### Use Non-overlapping IP Address Ranges

When you initially established your common development VPC, it was recommended that you use an IP range for CIDR block that does not overlap with other CIDR blocks in use by your organization.

If you were not able to obtain a non-overlapping CIDR block or blocks for your AWS environment, it's recommended that you attempt to do so before proceeding further.  

Otherwise, you'll need to prepare to perform some extent of Network Address Translation (NAT) in your on-premises environment to manage the use of overlapping IP address ranges.

### Obtain Static Public IP Address for Your Customer Gateway

In your on-premises environment, you will need to identify a static public IP address that will be associated with your Customer Gateway that will act as the on-premises side of the VPN site-to-site connection.  You'll use this IP address in the subsequent steps when you register your Customer Gateway in your AWS environment.

### Determine Dynamic or Static Routing

You'll need to work with your Network team to determine whether dynamic or static routing will be used with your Site-to-Site VPN connection. You can review [Site-to-Site VPN routing options](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPNRoutingTypes.html) for more details.

#### Dynamic Routing and Route Based VPNs

When you choose dynamic routing, you'll configure the Site-to-Site VPN connection to use Border Gateway Protocol (BGP) to automatically advertise routes across the connection.  In this scenario, you'll be using what is referred to as a "route based VPN".

It's recommended that you use BGP-capable customer gateway devices, when available, because the BGP protocol offers robust liveness detection checks that can assist failover to the second VPN tunnel if the first tunnel goes down.

In the dynamic routing and route based VPN configuration, both tunnels can be up at the same time. The BGP keep alive feature will bring up and keep the tunnel UP and active all the time. 

#### Static Routing and Policy Based VPNs

If your customer gateway device does not support BGP, then you will need to use static routing.

In this configuration only one tunnel will be up at a given time.  Depending on the features of your customer gateway device, you may be able to configure it to:
* Periodically send keep alive traffic to keep the tunnel active.
* Force a failover to the other tunnel in case of issues with the current tunnel.

## 2. Review the Resources to Configure

In this section you'll be configuring resources in the **`network-prod`** AWS account that you established earlier.  

In later sections, you'll be creating test and production VPCs in other AWS accounts and taking steps to attach those VPCs to the Transit Gateway that you're establishing in the **`network-prod`** AWS account.

The resources you'll be configuring in this section within the **`network-prod`** AWS account include:
* Customer gateway
* Transit gateway
* VPN transit gateway attachment
* VPC transit gateway attachment
* VPC route table entries

The VPC transit gateway attachment will attach your centrally managed development VPC with the transit gateway so that network traffic can be exchanged between the VPC and your on-premises network.

You'll need to update the VPC's route table so that traffic from the development VPC and destined for your on-premises environment is router to the transit gateway.

An optional step is to remove the public subnets and NAT gateways from the development VPC and route all Internet egress traffic from the development VPC to your on-premises network. You might choose this option as a short-term solution to direct the egress traffic through your existing network security filtering services in your on-premises environment. Longer term, you would likely host those filtering services in your AWS environment.

## 3. Create Customer Gateway

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
|**`Name`**|`base-on-prem-dc1-01`|Accounting for the possibility of multiple customer gateway devices in each of multiple data centers.|
|**`Routing`**|`Dynamic Routing`||
|**`BGP ASN`**|`6500`||
|**`IP Address`**|Public IP Address of your on-premises customer gateway||
|**`Certificate ARN`**|Leave empty||
|**`Device`**|Leave empty||

{{% notice info %}}
**Pre-shared Key and Certificate Options:** These example set up instructions use the pre-shared key option to authenticate your Site-to-Site VPN tunnel endpoints.  If you don't want to use pre-shared keys, you can use a private certificate from AWS Certificate Manager Private Certificate Authority to authenticate your VPN endpoints. See [Site-to-Site VPN tunnel authentication options](https://docs.aws.amazon.com/vpn/latest/s2svpn/vpn-tunnel-authentication-options.html).
{{% /notice %}}

## 4. Create a Transit Gateway

1. Select **`Transit Gateways`**
2. Select **`Create Transit Gateway`**
3. Provide the Transit Gateway form details:

|Field|Recommendation|Notes|
|-----|---------------|----|
|**`Name tag`**|base-main|You'll be able to use a single Transit Gateway for both on-premises integration and VPC-to-VPC routing if necessary.|
|**`Description`**|||
|**`Amazon side ASN`**|Accept default||
|**`DNS support`**|checked||
|**`VPN ECMP support`**|checked||
|**`Default route table association`**|checked||
|**`Default route table propagation`**|checked||
|**`Auto accept shared attachments`**|checked||

4. Select **`Create Transit Gateway`**

## 5. Create VPN Transit Gateway Attachment

1. Select **`Transit Gateway Attachments`**
2. Select **`Create Transit Gateway Attachment`**
3. Provide the Transit Gateway Attachment form details:

|Field|Recommendation|
|-----|---------------|
|**`Transit Gateway ID`**|Select value from the list that matches the ID of the Transit Gateway you just created.|
|**`Attachment Type`**|VPN|
|**`Customer Gateway`**|Existing|
|**`Customer Gateway ID`**|Select value from the list that matches the ID of the Customer Gateway you just created.|
|**`Routing options`**|Dynamic (requires BGP)|
|**`Enable acceleration`**|Leave unchecked|
|**`Tunnel Options`**|Leave unchecked|

4. Select **`Create attachment`**.
5. Once you're returned to the list of attachments, select the **`Name`** cell of the newly created attachment and assign a name to the attachment. For example, **`base-on-prem-dc1-01`**, the same name as your customer gateway resource. 

{{% notice info %}}
**Site-to-Site VPN Connection:** As a result of the VPN attachment being provisioned, you will notice in the Site-to-Site VPN Connections area of the console that a new connection resource has been created. If you review the **`Tunnel Details`** of the connection, it will show both tunnels in the **`DOWN`** state because you have not yet configured the on-premises side of the connection.
{{% /notice %}}

## 6. Configure Site-to-Site VPN Connection

Your next step is to obtain configuration data from the newly created site-to-site VPN connection and use it to configure your on-premises customer gateway device.

1. Select **`Site-to-Site VPN Connections`**
2. Select the connection that was just created
3. You can optionally name the connection. For example, **`base-on-prem-dc1-01`**, the same name as your customer gateway resource.
4. Download the VPN configuration information by clicking **` Download Configuration`**. 
5. Select your Vendor, Platform, and Software from the drop downs.  If you specific vendor is not available, select **`Generic`**.
6. Use the configuration data to configure your on-premises customer gateway.

## 7. Confirm Tunnels Are UP

Once your VPN is configured on-premises, 

1. Select **`Site-to-Site VPN Connections`**
2. Select the connection that was just created
3. Select **`Tunnel Details`**.
4. Monitor the status of the tunnels.  After several minutes, at least one of the two tunnels should transition to the **`UP`** state.

### Troubleshooting tips:
- Ensure that routing tables on AWS and router configurations (on-premises) are setup to allow communication.
- Ensure VPC route tables associated with subnets route traffic destined for the other site to the local VPN gateway instance.
- If using Transit Gateway on the remote site, ensure that VPC route tables are configured to route traffic destined for the other site to the Transit Gateway. (Although the built-in BGP support in this stack will ensure that both the local VPN gateway's route information and the remote Transit Gateway's route table will be automatically configured, you still need to ensure that the VPC route tables in both sites are properly configured).

## 8. Create a VPC Transit Gateway Attachment

1. While you are still in the **`VPN Console`** administration, click on **`Transit Gateway Attachments`** in the left navigation
2. Click the button **`Create Transit Gateway Attachment`**
3. Fill out the Transit Gateway Attachment form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Transit Gateway ID`**|Select value from dropdown that matched the ID of the Transit Gateway you just created.|
|**`Attachment Type`**|VPC|
|**`DNS support`**|enable (checked)|
|**`VPC ID`**|Select the value form the dropdown for that matches thee ID of the dev VPC in your account.|
|**`Subnet IDs`**|Select a subnet from each availability zone - preferably a private subnet|

## 9. Update VPC Route Table

1.   While you are still in the **`VPN Console`** administration, click on **`Route Tables`** under Virtual Private Cloud in the left navigation
2. Select your route table in the list
3. Select the **`Routes`** tab at the bottom of the page and click **`Edit routes`**
4. Add a new route with the values below:

|Field|Recommendation|
|-----|---------------|
|**`Destination`**|Fill in with your on-premises CIDR range (i.e. 172.31.0.0/16|
|**`Target`**|Select value from dropdown that matched the ID of the Transit Gateway you just created.|

{{% notice info %}}
**On-premises VPN Routes:** You will need to make similar types of changes to the routing rules with your on-premises infrastructure in order to route to the reserved CIDR ranges you have allocated for your AWS environment(s).
{{% /notice %}}

## 10. Test Connectivity

See [Testing the Site-to-Site VPN connection](https://docs.aws.amazon.com/vpn/latest/s2svpn/HowToTestEndToEnd_Linux.html).

## 11. Monitor Your VPN Connection

See [Monitoring Your Site-to-Site VPN connection](https://docs.aws.amazon.com/vpn/latest/s2svpn/monitoring-overview-vpn.html).
