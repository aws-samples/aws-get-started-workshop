---
title: 'Address Pre-Requisites'
menuTitle: '2. Address Pre-Requisites'
disableToc: true
weight: 20
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

Before you start configuring the transit gateway and site-to-site VPN connection, ensure that the following pre-requisites are satisfied:

{{< toc >}}

## 1. Engage your on-premises network team

In order to effect the necessary on-premises network configuration changes required by your AWS Site-to-Site VPN connection, you'll need to engage your Network team.  It's recommended that you review the overall requirements and solution design with them before proceeding with the configuration work.

## 2. Use non-overlapping IP addresses

When you initially established your common development VPC, it was recommended that you use an IP range for CIDR block that does not overlap with other CIDR blocks in use by your organization. If you were not able to obtain a non-overlapping CIDR block or blocks for your AWS environment, it's recommended that you attempt to do so before proceeding further.  Otherwise, you'll need to prepare to perform some extent of Network Address Translation (NAT) in your on-premises environment to manage the use of overlapping IP address ranges.

See [Obtaining Non-Overlapping IP Address Range]({{< relref "04-address-prerequisites#ip-address-range" >}}) for more background and guidance.

## 3. Obtain static public IP address for your customer gateway

In your on-premises environment, you will need to identify a static public IP address that will be associated with your Customer Gateway that will act as the on-premises side of the VPN site-to-site connection.  You'll use this IP address in the subsequent steps when you register your Customer Gateway in your AWS environment.

## 4. Determine dynamic or static routing

You'll need to work with your Network team to determine whether dynamic or static routing will be used with your Site-to-Site VPN connection. You can review [Site-to-Site VPN routing options](https://docs.aws.amazon.com/vpn/latest/s2svpn/VPNRoutingTypes.html) for more details.

### Dynamic routing and route based VPNs

When you choose dynamic routing, you'll configure the Site-to-Site VPN connection to use Border Gateway Protocol (BGP) to automatically advertise routes across the connection.  In this scenario, you'll be using what is referred to as a "route based VPN".

It's recommended that you use BGP-capable customer gateway devices, when available, because the BGP protocol offers robust liveness detection checks that can assist failover to the second VPN tunnel if the first tunnel goes down.

In the dynamic routing and route based VPN configuration, both tunnels can be up at the same time. The BGP keep alive feature will bring up and keep the tunnel UP and active all the time. 

### Static routing and policy based VPNs

If your customer gateway device does not support BGP, then you will need to use static routing.

In this configuration only one tunnel will be up at a given time.  Depending on the features of your customer gateway device, you may be able to configure it to:
* Periodically send keep alive traffic to keep the tunnel active.
* Force a failover to the other tunnel in case of issues with the current tunnel.