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

[![Site-to-Site VPN Connection - Attaching More VPCs](/images/05-optional/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-full.png)](/images/05-optional/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-full.png)

## Toplogy and Data Transfer Assumptions

* US East (Ohio) region
* 4 VPCs
  * Common team development VPC
  * Test workloads VPC
  * Production workloads VPC
  * Infrastructure shared services VPC
* On-premises network connectivity
  * Each VPC requires connecticity to your on-premises network
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

Monthly transit gateway cost = (5 transit gateway attachments x $36.50/month) + ((1,000 GB data transfer in via VPN + 1,000 GB data transfer in via VPCs) x $0.02/GB) = $182.50 + $40 = $222.50

## Example Site-to-Site VPN Costs

* Since the VPN connection fee is $0.05 per hour, a VPN connection for one month equates to about $36.50.
* Data transfer out of AWS over a VPN connection is $0.09 per GB with the first GB free.
* Data transfer into AWS over a VPN connection is free.

Monthly site-to-site VPN cost = (1 site-to-site VPN connection x $36.50/month) + (999 GB data transfer out/month x $0.09/GB) = $36.50 + $89.91 = $126.41

## Example Combined Costs

Combined monthly cost for site-to-site VPN + VPC peering: 

|Services|Month Cost|
|--------|----------|
|Transit Gateway|$222.50|
|Site-to-Site VPN|$126.41|
|Total monthly cost:|**$348.91**|