---
title: 'Alternative On-Premises Connectivity Architectures'
menuTitle: 'Alternative Architectures'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section provides an overview of several alternative architectures to consolidate site-to-site VPN connections from your on-premises network to your AWS environment and support connectivity between your team develpment and workload hosting VPCs and your infrastructure shared services VPC.  This information is intended to help you make a more informed decision as you considered the recommended approach of using AWS Transit Gateway.

{{< toc >}}

## AWS Site-to-Site VPN Virtual Private Gateway per VPC and VPC Peering

{{% notice warning %}}
We don't recommend using the following architecture. It's included only to demonstrate the implications of using more of a point-to-point approach to integrating site-to-site VPN connections with VPCs.  We recommend that you consolidate such connections by using either the [AWS Transit Gateway based architecture]({{< relref "03-review-site-to-site-vpn-architecture" >}}) or, if conditions warrant, a transit VPC architecture that is introduced below.
{{% /notice %}}

In this architecture, you establish a site-to-site VPN connection to each of your VPCs and use VPC peering to provide network connecticity between your team development and workload hosting VPCs and an infrastructure shared services VPC.

* You establish a distinct VPN connection from your on-premises environment to a virtual private gateway in each VPC.
* You use VPC peering to enable VPCs to interact with services in the infrastructure shared services VPC.

[![VPN Connection Per VPC](/images/02-dev-fast-follow/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-each-vpc.png?height=600px)](/images/02-dev-fast-follow/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-each-vpc.png)

### Operational Considerations

* You need to manage and monitor a distinct VPN connection for each VPC.
* As you add VPCs that need connectivity to on-premises resources, you need to add more VPN connections. Doing so will involve work both in your on-premises router and AWS environments.
* As you add VPCs that need connectivity to the infrastructure shared services VPC, you'll need to configure VPC peering relationships.
* If and when you need to enable connectivity between VPCs, you will need to add and manage more VPC peering relationships.
* If and when you decide to use AWS Direct Connect in place of AWS Site-to-Site VPN to integrate your on-premises network with your AWS environment, you will have to migrate all of your VPCs from using VPN connections to another solution.

### Cost Considerations

#### AWS Costs

We'll use the same assumptions concerning the number of VPCs, their dependencies, and the amount of data transferred that are used in the Transit Gateway architecture [Cost Example]({{< relref "01-network-integration-costs-example" >}}) section.

**Pricing**

See the following resources for the most up-to-date AWS pricing information. Prices are subject to change.

* [AWS VPN Pricing](https://aws.amazon.com/vpn/pricing/)
* [Data Transfer Out](https://aws.amazon.com/ec2/pricing/on-demand/)
* [VPC Peering](https://docs.aws.amazon.com/vpc/latest/peering/vpc-peering-basics.html#vpc-peering-pricing)

**Site-to-Site VPN Costs**

* Since the VPN connection fee is $0.05 per hour, a VPN connection for one month equates to about $36.50.
* Data transfer out for data flowing from AWS to your on-premises environment is $0.09 per GB with the first GB free.
* Data transfer into AWS over a VPN connection is free.

Monthly site-to-site VPN cost = ((4 site-to-site VPN connections x $36.50/month) + (999 GB out/month x $0.09/GB) = $146 + $89.91 = $235.91/month

**VPC Peering Costs**

VPC Peering connections in the same AWS Region is charged at $0.01/GB in each direction. The same as inter-AZ pricing within the same AWS region.

Monthly VPC peering cost = 2,000 GB/month x $0.01/GB = $20/month

**Combined Costs**

Combined monthly cost for site-to-site VPN + VPC peering: 

|Services|Month Cost|
|--------|----------|
|Site-to-Site VPN|$235.91|
|VPC Peering|$20.00|
|Total monthly cost:|**$255.91** (as compared to **$348.91** for [transit gateway-based example]({{< relref "01-network-integration-costs-example" >}}))|

## Transit VPC and Commercial Router Virtual Appliances

See the [AWS Global Transit Network](https://aws.amazon.com/solutions/implementations/aws-global-transit-network/) solution for an architecture and solution that uses commercial router virtual appliances in a transit VPC. This architecture was a common pattern used by customers prior to the advent of AWS Transit Gateway.

In this architecture, you establish a site-to-site VPN connection directly from your on-premises network to several commercial router virtual appliances that you manage in a central infrastucture transit VPC. AWS Site-to-Site VPN is not used for the on-premises to commercial router integration.

AWS Site-to-Site VPN connections are established between the router virtual appliances and a virtual private gateway in each of your VPCs.

[![Transit VPC Architecture](/images/02-dev-fast-follow/01-hybrid-networking/transit-vpc-architecture.png?height=600px)](/images/02-dev-fast-follow/01-hybrid-networking/transit-vpc-architecture.png)

### Operational Considerations

* You need to manage and monitor a set of commercial router virtual appliances in a transit VPC.
* You need to ensure that the router deployment meets your performance and availability requirements.

### Cost Considerations

The [AWS Global Transit Network](https://docs.aws.amazon.com/solutions/latest/cisco-based-transit-vpc/overview.html) solution documentation outlines cost considerations.