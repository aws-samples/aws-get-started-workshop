---
title: 'Review Site-to-Site VPN Architecture'
menuTitle: 'Review Site-to-Site VPN Architecture'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section provides an overview of the recommended Site-to-Site VPN architecture and highlights several of the more importan VPN connection options.  

## Recommended Architecture

### Use AWS Transit Gateway with AWS Site-to-Site VPN

Assuming that you'll want to enable your development, test, and production VPCs to have newtork connectivity to your on-premises environment, it's recommended that you use an AWS Site-to-Site VPN connection in conjunction with the AWS Transit Gateway service.  By doing so, you'll be able to easily reuse your site-to-site VPN connection across your VPCs.

In the following diagram, your on-premises IPsec-capable VPN device is represented as the "Customer Gateway".  Your customer gateway device will initiate a site-to-site VPN connection using two IPsec tunnels with VPN Transit Gateway attachment in your Network AWS account.  

Initially, you'll configure your AWS Tranit Gateway to attach to your development VPC.  Later in this guide, you'll add attachments for your emerging set of test and production VPCs.

[![Site-to-Site VPN Connection](/images/02-dev-fast-follow/03-network-integration/01-on-premises-network-integration/site-to-site-vpn-generic.png)](/images/02-dev-fast-follow/03-network-integration/01-on-premises-network-integration/site-to-site-vpn-generic.png)

...introduce and show more detailed diagram for the getting started use case here... if it makes sense, it could supplant the use of the diagram above...

### Segment Your On-Premises Access

Via your on-premises router and firewall configurations, you should be able to limit the connectivity between your AWS VPCs and on-premises networks and services. For example, you may want to constrain resources in your development VPC to accessing only allowed infrastructure, builder services, and development quality on-premises services and data.  Similarly, you would likely need to constrain your production VPC to accessing only allowed on-premises production services and data. 

### Consider Redundant VPN Connections

Once you've established your initial AWS Site-to-Site VPN connection, it's recommended that you consider setting up a a second customer gateway to further enhance resiliency of your network connectivity to AWS. See [Resilience in AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/disaster-recovery-resiliency.html) for details.

## Site-to-Site VPN Connection Options

### Route and Policy Based VPNs

...

### Authentication Options

...

