---
title: 'Review Site-to-Site VPN Architecture and Connection Options'
menuTitle: 'Review Site-to-Site VPN Architecture'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section provides an overview of the recommended Site-to-Site VPN architecture and highlights several of the more important VPN connection options.  

{{< toc >}}

## Recommended Architecture

This architecture is a recommended starting point for your network connectivity between your on-premises and AWS environment.

### Use AWS Transit Gateway with AWS Site-to-Site VPN

Assuming that you'll want to enable your development, test, and production VPCs to have newtork connectivity to your on-premises environment, it's recommended that you use an AWS Site-to-Site VPN connection in conjunction with the AWS Transit Gateway service.  By doing so, you'll be able to easily reuse your site-to-site VPN connection across your VPCs.

In the following diagram, your on-premises IPsec-capable VPN device is represented as the "Customer Gateway".  Your customer gateway device will initiate a site-to-site VPN connection using two IPsec tunnels with VPN Transit Gateway attachment in your Network AWS account.  

Initially, you'll configure your AWS Tranit Gateway to attach to your development VPC.  Later in this guide, you'll add attachments for your emerging set of test and production VPCs.

[![Site-to-Site VPN Connection](/images/02-dev-fast-follow/03-network-integration/01-on-premises-network-integration/site-to-site-vpn-generic.png)](/images/02-dev-fast-follow/03-network-integration/01-on-premises-network-integration/site-to-site-vpn-generic.png)

...introduce and show more detailed diagram for the getting started use case here... if it makes sense, it could supplant the use of the diagram above...

### Segment Your On-Premises Access

You'll need to work with your Network team to ensure that your customer gateway router and/or firewall configurations are aligned with how your organization expects to segregate traffic between your on-premises and AWS environments.

For example, you may want to constrain resources in your development VPC to accessing only allowed infrastructure, builder services, and development quality on-premises services and data.  Similarly, you would likely need to constrain your production VPC to accessing only allowed on-premises production services and data. 

## More Advanced Architectures

You should review the following more advanced architecures in case you have requirements in the near term that might be satisfied by these approaches.

### Improving Resiliency of VPN Connections

Once you've established your initial AWS Site-to-Site VPN connection, it's recommended that you consider setting up a a second customer gateway to further enhance resiliency of your network connectivity between your on-premises and AWS environments. See [Resilience in AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/disaster-recovery-resiliency.html) for details.

### Accelerating VPN Connections

You may opt to use [Accelerated Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/accelerated-vpn.html) which uses AWS Global Accelerator to improve the performance of VPN connections by intelligently routing traffic through the AWS Global Network and AWS edge locations. 

### Scaling VPN Throughput

If your initial use of a site-to-site VPN connection exceeds the 1.25 Gbps limit of a single IPsec tunnel, consider scaling VPN throughput via equal cost multi-path (ECMP) routing support over multiple VPN tunnels. See [Scaling VPN throughput using AWS Transit Gateway](https://aws.amazon.com/blogs/networking-and-content-delivery/scaling-vpn-throughput-using-aws-transit-gateway/) for more information.

## Site-to-Site VPN Connection Options

You'll need to review the following VPN connection options with your Network team.

### Route and Policy Based VPNs

...

### Authentication Options

...

