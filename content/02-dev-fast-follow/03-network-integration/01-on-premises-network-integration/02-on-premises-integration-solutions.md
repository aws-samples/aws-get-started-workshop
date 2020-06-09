---
title: 'Review On-Premises Network Integration Solution Options'
menuTitle: 'Review Integration Options'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

In cases where your organization needs to quickly establish on-premises network integration with the VPCs in your emerging AWS environment, it's recommended that you consider starting with an AWS Site-to-Site VPN connection. Later, if you have needs that will be better served through the use of AWS Direct Connect, you can transition to using AWS Direct Connect with or without a site-to-site VPN connection.

## Advantages and Limitations

The following table provides a simplified comparison of your two primary netwokr integration options.

|Option|Description|Advantages|Limitations|
|------|-----------|----------|-----------|
|**AWS Site-to-Site VPN Connection**|AWS managed IPsec VPN connection over the internet to regional router for multiple VPCs|Relatively little time required to set up<br><br>Reuse existing VPN equipment and processes<br><br>Reuse existing internet connections<br><br>AWS managed high availability VPN service<br><br>Supports static routes or dynamic Border Gateway Protocol (BGP) peering and routing policies|Network latency, variability, and availability are dependent on internet conditions<br><br>Customer managed endpoint is responsible for implementing redundancy and failover (if required)<br><br>Customer device must support single-hop BGP (when leveraging BGP for dynamic routing)<br><br>|
|**AWS Direct Connect**|Dedicated network connection over private lines to regional router for multiple VPCs|More predictable network performance<br><br>Reduced bandwidth costs<br><br>Supports BGP peering and routing policies|May require additional telecom and hosting provider relationships or new network circuits to be provisioned|

{{% notice info %}}
**Learn more about VPC connectivity options:** To learn more about your options including more advanced configurations, see [Network-to-Amazon VPC Connectivity Options](https://docs.aws.amazon.com/whitepapers/latest/aws-vpc-connectivity-options/network-to-amazon-vpc-connectivity-options.html).
{{% /notice %}}

## Required Knowledge

If you intend to use either AWS Site-to-Site Connection or AWS Direct Connect, you'll typically need to work with your on-premises Network team to address your internal networking configuration.

## Establishing AWS Site-to-Site VPN Connection

See [Establishing a AWS Site-to-Site VPN Connection]({{< relref "03-site-to-site-vpn" >}}) to quickly get a VPN connection established in support of your first few production workloads.

## Planning for AWS Direct Connect

See [Planning for AWS Direct Connect]({{< relref "04-planning-for-directconnect" >}}) if you'd like to learn more about getting started with planning to use AWS Direct Connect.
