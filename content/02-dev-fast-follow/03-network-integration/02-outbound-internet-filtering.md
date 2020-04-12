---
title: "Outbound Internet Content Filtering for Development Environments"
menuTitle: "Outbound Internet Filtering"
disableToc: true
weight: 20
---

This section addresses options and resources to enable you to further secure Internet integration in support of your initial development environments.

{{% notice note %}}
**Review Note: For now add ideas and references to existing publicly available resources:** Let's build up ideas and refine as we go.
{{% /notice %}}

## Requirements

In the initial stage of your foundation, you may have enabled development team AWS accounts outbound access to the Internet via use of private subnets, an AWS Internet Gateway, and AWS NAT Gateways.  Organizations that desire to filter outbound traffic to the Internet typically route suhc traffic traffic through centrally controlled proxies and security services.

Since your corporate intellectual property in the form of private source code will likely be present in your team development environments along with early forms of proprietary applications and services, your organization might not want to allow for direct access to the Internet from the development environments.

Additionally, download of software packages from the Internet should be filtered to help ensure that malicious code is not introduced into your development environments.

## Solution Options and Resources

### Tactical Routing of Outbound Internet Traffic Through Existing On-Premises Security Services
Under these circumstances, it is often most expedient to reuse your existing on-premises Internet security filtering capabilities to minimize the risk of IP and other information being leaked from your development environments to the Internet.   For example, as a tactical step, all egress traffic destined for the Internet from the cloud hosted development environments can be routed back on-premises over a site-to-site VPN connection and through existing network and security layers before being sent to the Internet.

The primary downsides of this tactical approach are:
* Increased in latency.
* Increased dependency on on-premises infrastructure.

### Longer Term Cloud Hosted Ingress and Egress Security Services

See [Nick Matthews' re:Invent 2019 talk](https://youtu.be/9Nikqn_02Oc?t=2304) on the role that AWS Transit Gateway can play in this regard.

### Impact to Development VPC Design

From a builder team's perspective, nothing should need to change other than the fact that their outbound requests to Internet service may fail when the security filtering services detect an issue.

Behind the scenes, your Network team would have modified routing entries so that traffic from the development private subnets and destined for the Internet would be routed back on-premises.

Both the NAT Gateway(s) formerly provisioned to the development public subnets and the public subnets themselves could likely be decommissioned.