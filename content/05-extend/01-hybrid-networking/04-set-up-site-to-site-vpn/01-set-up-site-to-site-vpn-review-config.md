---
title: 'Review Site-to-Site VPN and Transit Gateway Configuration'
menuTitle: '1. Review Configuration'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In this section you'll be configuring resources in the **`network-prod`** AWS account that you established earlier.  

In later sections, you'll be creating test and production VPCs in other AWS accounts and taking steps to attach those VPCs to the transit gateway that you're establishing in the **`network-prod`** AWS account.

The resources you'll be configuring in the **`network-prod`** AWS account include:
* Customer gateway
* Transit gateway
* VPN transit gateway attachment
* Development VPC transit gateway attachment
* Network services transit gateway route table
* Workloads VPCs transit gateway route table
* Development VPC route table entries

Once you create test and production workloads AWS accounts and VPCs, you'll also attach those VPCs to your transit gateway and update the newtork services route table accordingly.

The overall configuration in this guide is patterned after the example [Isolated VPCs with shared services](https://docs.aws.amazon.com/vpc/latest/tgw/transit-gateway-isolated-shared.html).

The following diagram represents a transit gateway and related resources that enable defined connectivity between VPCs and your on-premises network.  Based on the configuration of the transit gateway routing tables, you have control over which VPCs have connectivty to each other and with your on-premises network.

[![Site-to-Site VPN with Transit Gateway](/images/05-extend/01-hybrid-networking/site-to-site-vpn-tgw-route-tables.png?height=500px)](/images/05-extend/01-hybrid-networking/site-to-site-vpn-tgw-route-tables.png)

The transit gateway and routing configuration shown in the diagram above supports the following connectivity scenarios:

* Your team development and workload VPCs cannot connect to each other.
* Your team development and workload VPCs can connect to your infrastructure shared services VPC and on-premises network via the site-to-site VPN connection.
* Your on-premises network can connect to all of the VPCs.
* Your infrastructure shared services VPC can connect to your team development and workload VPCs and to your on-premises network via the site-to-site VPN connection.

|Source|On-Premises via Site-to-Site VPN|Infrastructure Shared Services VPC|Team Development VPC|Test VPC|Production VPC|
|-|:-:|:-:|:-:|:-:|:-:|
|**On-Premises via Site-to-Site VPN**|NA|Y|Y|Y|Y|
|**Infrastructure Shared Services VPC**|Y|NA|Y|Y|Y|
|**Team Development VPC**|Y|Y|NA|N|N|N|
|**Test VPC**|Y|Y|N|NA|N|
|**Production VPC**|Y|Y|N|N|NA|

By adjusting the configuration of your transit gateway route tables, you can modify the allowed connectivity.

{{% notice note %}}
**Role of VPC security groups and network access control lists (NACLs):** In addition to controlling connectivity between VPCs and between VPCs and your on-premises network via use of transit gateway route tables, you would likely use security groups and NACLs in your VPCs to provide another layer of control.
{{% /notice %}}

The subsequent sections in this guide lead you through the detailed set up steps to establish this configuration.

{{% notice tip %}}
**Detailed traffic flow examples:** If you'd like to walk through detailed traffic flow examples when using AWS Tranist Gateway, see [Field Notes: Working with Route Tables in AWS Transit Gateway](https://aws.amazon.com/blogs/architecture/field-notes-working-with-route-tables-in-aws-transit-gateway/).
{{% /notice %}}

{{% notice tip %}}
**Routing internet egress traffic to your on-premises network:** An optional step is to remove the public subnets and NAT gateways from the development VPC and route all Internet egress traffic from the development VPC to your on-premises network. You might choose this option as a short-term solution to direct the egress traffic through your existing network security filtering services in your on-premises environment. Longer term, you would likely host those filtering services in your AWS environment.
{{% /notice %}}