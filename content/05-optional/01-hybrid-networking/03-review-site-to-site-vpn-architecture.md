---
title: 'Review Site-to-Site VPN Architecture'
menuTitle: '3. Review Site-to-Site VPN Architecture'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section provides an overview of the recommended initial Site-to-Site VPN architecture and highlights several of the more important VPN connection options.  

{{< toc >}}

## Initial Architecture

The following architecture provides a starting point that you can evolve to meet your needs as you learn more about the AWS platform and expand adoption of AWS.  Even for your initial implementation, you may choose to customize this example architecture to meet your immediate needs.

### Using AWS Transit Gateway with AWS Site-to-Site VPN

Given that you'll likely want to enable your development, test, and production VPCs to have newtork connectivity to your on-premises environment, it's recommended that you use an AWS Site-to-Site VPN connection in conjunction with the [AWS Transit Gateway](https://docs.aws.amazon.com/vpc/latest/tgw/what-is-transit-gateway.html) service.  By doing so, you'll be able to easily reuse your site-to-site VPN connection across your VPCs and control which networks can connect to each other.

In the following diagram, your on-premises IPsec-capable VPN device is represented as the "Customer Gateway".  Your customer gateway device will initiate a site-to-site VPN connection using two IPsec tunnels with VPN Transit Gateway attachment in your **network-prod** AWS account.  

Initially, you'll configure your AWS Tranit Gateway to attach to your development VPC.  Later in this guide, you'll add attachments for your emerging set of infrastructure shared services, test, and production VPCs.

[![Site-to-Site VPN Connection - Multiple VPCs](/images/05-optional/01-hybrid-networking/site-to-site-vpn-high-level-generic.png?height=500px)](/images/05-optional/01-hybrid-networking/site-to-site-vpn-high-level-generic.png)

### Initial State: Development VPC Connected to On-premises Network

The following diagram depicts an initial architecture where only the common development VPC has connectivity to your on-premises networks.

[![Site-to-Site VPN Connection - Initial Development Connectivity](/images/05-optional/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-dev.png)](/images/05-optional/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-dev.png)

In this initial stage of establishing hybrid connectivity with your AWS environment, you'll need to work with your Network team to ensure that the necessary on-premises router configuration changes are made and tested.  

The following sections highlight common considerations for connectivity and routing between your on-premises and AWS cloud networks.

#### 1. Enabling Corporate Client Connectivity to Development Workloads in AWS

You might have a requirement to enable technologists and perhaps internal business users on your corporate network to access and test early development and test workloads hosted in your AWS development environment.

#### 2. Routing All Internet Outbound Traffic Through On-Premises Network Security Services

You might have a requirement to ensure that all egress traffic to the Internet from your development network in AWS flows through your existing network security services. In the initial build out of your development environment in AWS, the example architecture used a set of public subnets, Internet Gateway, and NAT Gateways to enable traffic to flow from your development network directly to the Internet. In this initial configuration, there's no built-in filtering of egress traffic.

Once you've established your hybrid connectivity to your AWS environment, you have the option to route all egress Internet traffic back through the site-to-site VPN connection and through your existing network security services before the traffic is sent over your existing on-premises connections to the Internet.

{{% notice info %}}
**Using cloud-based centralized egress filtering:** Typically, the approach of routing Internet egress traffic through your on-premises network security services is viewed as a temporary solution. As a longer term solution, you should consider establishing the necessary network security services in your AWS environment. This cloud-based solution can be more effective by avoiding the need to send Internet egress traffic to your on-premises environment.  See [Centralized Egress to the Internet](https://docs.aws.amazon.com/whitepapers/latest/building-scalable-secure-multi-vpc-network-infrastructure/centralized-egress-to-internet.html) for details on this more optimal architecture.
{{% /notice %}}

If you take this temporary approach to securing egress traffic to the Internet, then you'll be able to decommission the NAT Gateway(s), public subnets, and Internet Gateway in your common development VPC.  

To support this temporary architecture, you'll need to work with your Network team to ensure that the proper routing configuration is put in place in your on-premises network. You'll also need to adjust the development VPC routing configuration to forward all Internet bound traffic through your site-to-site VPN connection instead of through the NAT Gateway(s) in your development VPC.

#### 3. Segmenting Access Between Your On-premises and AWS Networks

You'll need to work with your Network team to ensure that your customer gateway router and/or firewall configurations are aligned with how you expect to segregate traffic between your on-premises and AWS environments.

For example, you may want to constrain resources in your development VPC to accessing only allowed infrastructure, builder services, and development quality on-premises services and data.  In the future, when you build out production VPCs in your AWS environment, you would likely need to constrain your production VPC to accessing only allowed on-premises production services and data. 

Similarly, you may need to configure your on-premises routers and/or firewalls to ensure that only certain on-premises networks or specific clients can access your AWS networks.

## Attaching Additional VPCs to Transit Gateway

Later in this guide, as you create VPCs for test and production environments and consider adding a VPC to house infrastructure shared services, you'll be able to easily attach those VPCs to your transit gateway.

In the following diagram, test and production VPCs are shown attached to the transit gateway.  An infrastructure shared services VPC is shown with hybrid DNS support and VPC endpoints.  The public subnet and internet gateway resources have been removed from the common development VPC based on the assumption that your traffic from all of your VPCs destined for the Internet will be routed across your site-to-site VPN connection.

[![Site-to-Site VPN Connection - Attaching More VPCs](/images/05-optional/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-full.png)](/images/05-optional/01-hybrid-networking/site-to-site-vpn-site-to-site-vpn-full.png)

## Extending the Architecture

As your use of AWS expands, some of the following enhancements of your on-premises network integration architecture may be of interest.

### Improving Resiliency of VPN Connections

Once you've established your initial AWS Site-to-Site VPN connection, it's recommended that you consider setting up a a second customer gateway to further enhance resiliency of your network connectivity between your on-premises and AWS environments. See [Resilience in AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/disaster-recovery-resiliency.html) for details.

### Accelerating VPN Connections

You may opt to use [Accelerated Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn/accelerated-vpn.html) which uses AWS Global Accelerator to improve the performance of VPN connections by intelligently routing traffic through the AWS Global Network and AWS edge locations. 

### Scaling VPN Throughput

If your initial use of a site-to-site VPN connection exceeds the 1.25 Gbps limit of a single IPsec tunnel, consider scaling VPN throughput via equal cost multi-path (ECMP) routing support over multiple VPN tunnels. See [Scaling VPN throughput using AWS Transit Gateway](https://aws.amazon.com/blogs/networking-and-content-delivery/scaling-vpn-throughput-using-aws-transit-gateway/) for more information.

## Reviewing Costs

If you would like to review an example set of costs for the network integration architecture, see [Network Integration Architecture Cost Example]({{< relref "01-network-integration-costs-example" >}}).

## Reviewing Alternative Architectures

If you would like to compare the recommended approach of using AWS Transit Gateway, see [Alternative Network Integration Architectures]({{< relref "02-alternative-network-integration-architectures" >}}) including operational and cost considerations.