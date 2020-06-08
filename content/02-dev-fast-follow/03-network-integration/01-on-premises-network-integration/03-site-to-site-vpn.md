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

Assuming that you'll want to enable your development, test, and production VPCs to have newtork connectivity to your on-premises environment, it's recommended that you use AWS Site-to-Site VPN connection in conjunction with the AWS Transit Gateway service.  By doing so, you'll be able to easily reuse your site-to-site VPN connection across your VPCs.

[![Site-to-Site VPN Connection](/images/02-dev-fast-follow/03-network-integration/01-on-premises-network-integration/site-to-site-vpn-generic.png)](/images/02-dev-fast-follow/03-network-integration/01-on-premises-network-integration/site-to-site-vpn-generic.png)

### Integration with Common Development VPC

Earlier, you established a centrally managed development VPC in your Network AWS account. In this section, you'll be connecting that VPC to your on-premises network via an AWS Transit Gateway and an AWS Site-to-Site VPN connection.

### Integration with Emerging Test and Production VPCs

Later in this guide, when you set up your test and production VPCs, the steps required to enable those VPCs to reuse your site-to-site VPN conection will be addressed.  The process in your AWS environment will be largely a repeat of the steps in this section that are used to connect your development VPC to your on-premises network.

### Your On-Premises Routing Configuration

Via your on-premises router and firewall configurations, you should be able to limit the connectivity between your AWS VPCs and on-premises networks and services. For example, you may want to constrain resources in your development VPC to accessing only allowed infrastructure, builder services, and development quality on-premises services and data.  Similarly, you would likely need to constrain your production VPC to accessing only allowed on-premises production services and data. 

{{% notice info %}}
**Using redundant Site-to-Site VPN connections to provide failover:** Once you've established your initial AWS Site-to-Site VPN connection, it's recommended that you consider setting up a a second customer gateway. See [Resilience in AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/disaster-recovery-resiliency.html) for details.
{{% /notice %}}

## 2. Ensure Pre-requisites Are Satisfied

### Non-overlapping IP Addresses

If you didn’t use a non-overlapping range from the start, you will need to either replace your initial set of development VPCs with VPCs that use non-overlapping IP addresses or implement Network Address Translation (NAT).

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

## 9. Enable resource sharing in your master account

You will need to enable sharing resources within your AWS Organizations from your master account.  THis will allow you to access Transit Gateway from each of your accounts created and maintained within Control Tower.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`master`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`Resource Access Manager`**
6. Click the **`Settings`** in the left navigation panel
7. Check the **`Enable sharing within your AWS Organizations`** checkbox, then click the **`Save settings`** button

{{% notice info %}}
**Find your Organization ID:** Navigate to AWS Organizations and click on any of the accounts to open the information panel on the right.  Within the **`ARN`**, after the word account, you will see your Organization ID (starts with **`o-`**).  Note this down for the next set of steps.
{{% /notice %}}

## 10. Sharing your Transit Gateway to your other accounts

You will use AWS Resource Access Manager (RAM) to share your Transit Gateway for VPC attachments across your accounts and/or your organizations in AWS Organizations.

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`Network`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`Resource Access Manager`**
2. Click the **`Create a resource share`** button
3. Fill out the resource share form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Name`**|acme-network-tgw-share-01|
|**`Select resource type`**|Transit Gateways (and select your Transit Gateway)|
|**`Allow external accounts`**|(checked)|
|**`Add AWS account number, OU or organization`**|Enter the Organization ID from your master account (captured in the above steps)|

## 11. Configure Transit Gateway with another one of your accounts in your organization

{{% notice info %}}
**VPC:** If you do not already have a VPC in your account, please create one.
{{% /notice %}}

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the desired AWS account to log into
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`** and click on **`Transit Gateway Attachments`** in the left navigation
6. Click the button **`Create Transit Gateway Attachment`**
7. Fill out the Transit Gateway Attachment form details.  Some suggested fields are below:

|Field|Recommendation|
|-----|---------------|
|**`Transit Gateway ID`**|Select value from dropdown that matched the ID of the Transit Gateway you just created.|
|**`Attachment Type`**|VPC|
|**`DNS support`**|enable (checked)|
|**`VPC ID`**|Select the value form the dropdown for that matches thee ID of the dev VPC in your account.|
|**`Subnet IDs`**|Select a subnet from each availability zone - preferrably a private subnet|

![TGW Attachment Other Account](/images/02-dev-fast-follow/03-network-integration/01-on-premises-network-integration/tgw-create-attachment.png)

{{% notice info %}}
**Transit Gateway Attachment - Pending Acceptance:** If your account is not setup as **`Auto accept shared attachments: enable`**, after you create the Transit Gateway Attachment, the status will show as **`pending acceptance`**.  You will need to log into your **`Network`** account and accept the Transit Gateway Attachment by selecting it in the VPC console and going to **`Actions|Accept`**.  Once this is done, the VPC will show up under the **`Transit Gateway Route Table - Associations`**.
{{% /notice %}}

{{% notice info %}}
**Transit Gateway Route Tables - Propagations:** If your Transit Gateway is configured for **`Default propagation route table: enable`**.  If not, you will need to log into your **`Network`** account, navigate to the **`Transit Gateway Route Tables`**, select your route table, go to the **`Propagations`** tab, and create a new propagation to the VPC in your attachment account.
{{% /notice %}}

## 12. Configure the Route Tables in the account you just setup a Transit Gateway Association

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the desired AWS account to log into
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`** and click on **`Route Tables`** in the left navigation
6. Select your route table in the list
7. Select the **`Routes`** tab at the bottom of the page and click **`Edit routes`**
8. Add a new route with the values below:

|Field|Recommendation|
|-----|---------------|
|**`Destination`**|Fill in with your on-premises CIDR range (i.e. 172.31.0.0/16|
|**`Target`**|Select value from dropdown that matched the ID of the Transit Gateway you just created.|

{{% notice info %}}
**Repeat for additional accounts:** You will repeat steps 9 and 10 for each of the accounts within your organization that you want to be able to communicate with your on-premises network.
{{% /notice %}}