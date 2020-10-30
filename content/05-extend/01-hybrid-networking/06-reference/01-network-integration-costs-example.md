---
title: 'Hybrid Networking Cost Example'
menuTitle: 'Cost Example'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section provides an overview of example costs for this architecture as it is applied to an AWS environment in which team development, test, production, and infrastructure shared services VPCs are connected to your on-premises network. It also assumes connectivity between your the team development, test, and production VPCs and an infrastructure shared services VPC.

[![Site-to-Site VPN Connection - Attaching More VPCs](/images/05-extend/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-full.png)](/images/05-extend/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-full.png)

## Topology and Data Transfer Assumptions {#topology-data-transfer-example}

The following architecture and data transfer numbers are examples. Your actual architecture and data transfer needs will vary.

* US East (Ohio) region
* 4 VPCs
  * Common team development VPC
  * Test workloads VPC
  * Production workloads VPC
  * Infrastructure shared services VPC
* On-premises network connectivity
  * Each VPC requires connectivity to your on-premises network
  * 1 TB/month of data is transferred in total per month in each direction across combined set of site-to-site VPN connections.
* The common development VPC and workloads VPCs require network connectivity to the infrastructure shared services VPC.
  * 1 TB/month of data is transferred in each direction between the common development VPC and workloads VPCs and the infrastructure shared services VPC.

## Pricing

When using AWS Transit Gateway with AWS Site-to-Site VPN, pricing for each service needs to be applied. See the following resources for the most up-to-date AWS pricing information. Prices are subject to change.

* [AWS Transit Gateway Pricing](https://aws.amazon.com/transit-gateway/pricing/) 
* [AWS VPN Pricing](https://aws.amazon.com/vpn/pricing/)
* [Data Transfer Out](https://aws.amazon.com/ec2/pricing/on-demand/)

## Example Transit Gateway Costs

* Since each VPC and VPN transit gateway attachment is priced at $0.05/hour, an attachment for one month equates to about $36.50.
* Data processing charges of $0.02 apply for each GB sent from a VPC, Direct Connect or VPN to the AWS Transit Gateway.

|Dimension|Unit Cost|Example Monthly Cost|
|---------|---------|------------|
|5 transit gateway attachments: Site-to-Site VPN + 4 VPC attachments|$36.50/month|$182.50|
|1,000 GB data processing for data received via VPN|$0.02/GB|$20|
|1,000 GB data processing for data received via Dev, Test, and Prod VPCs and destined for Infrastructure Shared Services VPC |$0.02/GB|$20|
|1,000 GB data processing for data received via Infrastructure Shared Services VPC and destined for Dev, Test, and Prod VPCs|$0.02/GB|$20|
|1,000 GB data processing for data received via all VPCs and destined for AWS Site-to-Site VPN connection|$0.02/GB|$20|
| | |**$262.50**|

## Example Site-to-Site VPN Costs

* Since the VPN connection fee is $0.05 per hour, a VPN connection for one month equates to about $36.50.
* Data transfer out of AWS over a VPN connection is $0.09 per GB with the first GB free.
* Data transfer into AWS over a VPN connection is free.

|Dimension|Unit Cost|Example Monthly Cost|
|---------|---------|------------|
|1 site-to-site VPN connection|$36.50/month|$36.50|
|999 GB data transfer out/month|$0.09/GB|$89.91|
| | |**$126.41**|

{{% notice info %}}
**Cost of additional site-to-site VPN connection:** If you choose to establish a second VPN connection to further improve resiliency, then you would add the second connection to your cost calculations. See [Resilience in AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/disaster-recovery-resiliency.html) for details on using a second VPN connection.
{{% /notice %}}

## Example Combined Costs

Combined monthly cost for site-to-site VPN + VPC peering: 

|Services|Example Monthly Cost|
|--------|----------|
|Transit Gateway|$262.50|
|Site-to-Site VPN|$126.41|
|Total monthly cost:|**$388.91**|

You can compare this example cost with [Alternative On-Premises Connectivity Architectures]({{< relref "02-alternative-network-integration-architectures" >}}).