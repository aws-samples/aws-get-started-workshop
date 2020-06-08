---
title: 'Establish Site-to-Site VPN Connection'
menuTitle: 'Establish Site-to-Site VPN'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section provides an overview and detailed step-by-step instructions for using AWS Site-to-Site VPN and AWS Transit Gateway as a means to quickly and securely establish network connectivity between your on-premises and AWS environments.  

{{< toc >}}

## 1. Review the Solution

### Use AWS Transit Gateway with AWS Site-to-Site VPN

Assuming that you'll want to enable your development, test, and production VPCs to have newtork connectivity to your on-premises environment, it's recommended that you use an AWS Site-to-Site VPN connection in conjunction with the AWS Transit Gateway service.  By doing so, you'll be able to easily reuse your site-to-site VPN connection across your VPCs.

In the following diagram, your on-premises IPsec-capable device is represented as the "Customer Gateway".  Your customer gateway device will initiate a site-to-site VPN connection using two IPsec tunnels with VPN Transit Gateway attachment in your Network AWS account.  

Initially, you'll configure your AWS Tranit Gateway to attach to your development VPC.  Later in this guide, you'll add attachments for your emerging set of test and production VPCs.

[![Site-to-Site VPN Connection](/images/02-dev-fast-follow/03-network-integration/01-on-premises-network-integration/site-to-site-vpn-generic.png)](/images/02-dev-fast-follow/03-network-integration/01-on-premises-network-integration/site-to-site-vpn-generic.png)

### Integration with Common Development VPC

Earlier in this guide, you established a centrally managed development VPC in your Network AWS account. In this section, you'll be connecting that VPC to your on-premises network via an AWS Transit Gateway and an AWS Site-to-Site VPN connection.

...insert enhanced networking diagram here showing common dev VPC attached to TGW...

### Integration with Emerging Test and Production VPCs

Later in this guide, when you set up your test and production VPCs, the steps required to enable those VPCs to reuse your site-to-site VPN conection will be addressed.  The process in your AWS environment will be largely a repeat of the steps in this section that are used to connect your development VPC to your on-premises network.

...insert enhanced networking diagram here showing test and production VPCs attached to TGW...

### Segmenting Your On-Premises Access

Via your on-premises router and firewall configurations, you should be able to limit the connectivity between your AWS VPCs and on-premises networks and services. For example, you may want to constrain resources in your development VPC to accessing only allowed infrastructure, builder services, and development quality on-premises services and data.  Similarly, you would likely need to constrain your production VPC to accessing only allowed on-premises production services and data. 

{{% notice info %}}
**Using redundant Site-to-Site VPN connections to provide failover:** Once you've established your initial AWS Site-to-Site VPN connection, it's recommended that you consider setting up a a second customer gateway to further enhance resiliency of your network connectivity to AWS. See [Resilience in AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/disaster-recovery-resiliency.html) for details.
{{% /notice %}}

## 2. Ensure Pre-requisites Are Satisfied

First, ensure that the following pre-requisites are satisfied.

### Engage Your On-Premises Network Team

In order to effect the necessary on-premises network configuration changes required by your AWS Site-to-Site VPN connection, you'll need to engage your Network team.  It's recommended that you review the overall requirements and solution design with them before proceeding with the configuration work.

### Non-overlapping IP Address Ranges

When you initially established your common development VPC, it was recommended that you use an IP range for CIDR block that does not overlap with other CIDR blocks in use by your organization.

If you were not able to obtain a non-overlapping CIDR block or blocks for your AWS environment, it's recommended that you attempt to do so before proceding further.  

Otherwise, you'll need to prepare to perform some extent of Network Address Translation (NAT) in your on-premises environmnet to manage the use of overlapping IP address ranges.

### Static Public IP Address for Your Customer Gateway

In your on-premises environment, you will need to identify a static public IP address that will be associated with your Customer Gateway that will act as the on-premises side of the VPN site-to-site connection.  You'll use this IP address in the subsequent steps when you register your Customer Gateway in your AWS environment.

## 3. Register Your Customer Gateway in AWS

You will begin by making changes in the **`network-prod`** account you set up earlier.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`network-prod`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`** and click on **`Customer Gateways`** in the left navigation
6. Click the button **`Create Customer Gateway`**
7. Fill out the Customer Gateway form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Name`**|example-network-on-prem-01|
|**`Routing`**|Dynamic Routing|
|**`BGP ASN`**|6500|
|**`IP Address`**|Enter the value of the public IP Address of your on-premises gateway address for your VPN |
|**`Certificate ARN`**|Leave empty|
|**`Device`**|Leave empty|

{{% notice info %}}
**Customer Gateway ID:** Note the Customer Gateway ID for the newly created Customer Gateway.  You will use this in later steps.
{{% /notice %}}

## 4. Create a Transit Gateway in your Network account

1. While you are still in the **`VPN Console`** administration, click on **`Transit Gateways`** in the left navigation
2. Click the button **`Create Transit Gateway`**
3. Fill out the Transit Gateway form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Name tag`**|acme-network-tgw-01|
|**`Description`**|Transit Gateway in order to route traffic to/from On-Prem network as well as within VPCs |

{{% notice info %}}
**Transit Gateway ID:** Please note down the Transit Gateway ID for the recently created Transit Gateway.  You will use this in later steps.
{{% /notice %}}

## 5. Create a VPN Transit Gateway Attachment in your Network account

1. While you are still in the **`VPN Console`** administration, click on **`Transit Gateway Attachments`** in the left navigation
2. Click the button **`Create Transit Gateway Attachment`**
3. Fill out the Transit Gateway Attachment form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Transit Gateway ID`**|Select value from dropdown that matched the ID of the Transit Gateway you just created.|
|**`Attachment Type`**|VPN|
|**`Customer Gateway`**|Existing|
|**`Customer Gateway ID`**|Select value from dropdown that matched the ID of the Customer Gateway you just created.|
|**`Routing options`**|Dynamic (requires BGP)|

{{% notice info %}}
**Transit Gateway Attachment Name:** Once created, it is recommended to provide a name to the Transit Gateway Attachment.  To do this, select the checkbox of the row for the attachment you just created.  Click the **`pencil`** icon under the **`Name`** column.  Enter a name (i.e. acme-routing-tgw-vpn-01).
{{% /notice %}}

{{% notice info %}}
**VPN:** As a result of the VPN attachment being provisioned, you will notice that a Site-to-Site VPN Connection resource has been created for the attachment.
{{% /notice %}}

## 6. Configure your Site-to-Site VPN connection

1. While you are still in the **`VPN Console`** administration, click on **`Site-to-Site VPN Connections`** in the left navigation
2. Select the VPN just created in the list of VPN connections
3. Click on the **`Actions`** button and select **`Modify VPN Connection`**
4. Edit the name for your VPN connection.  (Suggestion: acme-routing-vpn-onprem-01)
5. Download the VPN configuration information by clicking **` Download Configuration`**
6. Use the configuration to configure you on-premises VPN gateway.

{{% notice info %}}
**VPN Configuration:** Select your Vendor, Platform, and Software from the dropdowns.  If you specific vendor is not available, select **`Generic`**.  As a best practice, AWS provides your configuration file with a primary and secondary VPN configuration.  This allows for redundancy of your VPN connection.
{{% /notice %}}

Once your VPN is configured on-premises, navigate back to the Site-to-Site VPN Connections within the VPC console.  Select the row of your VPN connection.  At the botton of the page, select the **`Tunnel Details`** tab.  Verify that the Status has changed from "DOWN" to "UP" (this may take a few minutes).

### Troubleshooting tips:
- Ensure that routing tables on AWS and router configurations (on-premises) are setup to allow communication.
- Ensure VPC route tables associated with subnets route traffic destined for the other site to the local VPN gateway instance.
- If using Transit Gateway on the remote site, ensure that VPC route tables are configured to route traffic destined for the other site to the Transit Gateway. (Although the built-in BGP support in this stack will ensure that both the local VPN gateway's route information and the remote Transit Gateway's route table will be automatically configuired, you still need to ensure that the VPC route tables in both sites are properly configured).

## 7. Create a Transit Gateway Attachment to connect to your VPC

1. While you are still in the **`VPN Console`** administration, click on **`Transit Gateway Attachments`** in the left navigation
2. Click the button **`Create Transit Gateway Attachment`**
3. Fill out the Transit Gateway Attachment form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Transit Gateway ID`**|Select value from dropdown that matched the ID of the Transit Gateway you just created.|
|**`Attachment Type`**|VPC|
|**`DNS support`**|enable (checked)|
|**`VPC ID`**|Select the value form the dropdown for that matches thee ID of the dev VPC in your account.|
|**`Subnet IDs`**|Select a subnet from each availability zone - preferrably a private subnet|

## 8. Edit your VPC Route Table to add a route for your On-Premises CIDR

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

## 9. Test Connectivity

...