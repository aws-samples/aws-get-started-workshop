---
title: "On-Premises Network Integration"
disableToc: true
weight: 10
---

This section addresses options and resources to enable network connectivity between your on-premises networks and AWS environment.

{{% notice note %}}
**Review Note: For now add ideas and references to existing publicly available resources:** Let's build up ideas and refine as we go.
{{% /notice %}}

## Requirements

In many cases, organizations require that applications and workloads hosted in AWS can connect to workloads and shared services hosted on-premises and vice versa.  

* Cloud client access to defined non-prod application and data services.
* On-premises access to newly deployed cloud hosted development, pre-production test, prod workloads and services.
* Cloud client access to on-premises source code management access.
* Hybrid DNS resolution:
  * On-premises clients resolve custom FQDNs for cloud hosted services.
  * Cloud clients resolve customer FQDNs on on-premises services.
  
* Security
  * Protect against external attack vectors from the Internet.
  * Protect against internal data loss/exfiltration to the Internet.
  * Ensure that only appropriate cloud networks and cloud hosted services can have connectivity to appropriate internal networks and services and vice vesa.
  
* Non-overlapping allocation of IP address ranges for use by cloud environments.

## Solution Options and Resources

Typically, as an initial means to quickly establish this connectivity, one pr more VPN connections are established using existing on-premises network appliances and the AWS Site-to-Site VPN capability in conjunction with AWS Transit Gateway.  AWS Transit Gateway centralizes and simplifies sharing on-premises to AWS network integration across multiple VPCs.

Introduction of a new Network AWS account is a common approach in which shared network resources such as the AWS Transit Gateway configuration can be isolated and managed separately from team oriented AWS accounts and the other shared accounts.

Longer term, as your on-premises to AWS network connectivity needs expand, you will typically transition from using site-to-site VPN connections to AWS Direct Connect.  When using AWS Transit Gateway as the termination point for VPN and AWS Direct Connect connections, a migration from using VPN to AWS Direct Connect has no impact on the VPCs behind the Transit Gateway.

If you didn’t use a non-overlapping range from the start, you will need to either replace your initial set of development VPCs with VPCs that use non-overlapping IP addresses or implement Network Address Translation (NAT).

*...defer to existing documentation including decision trees, blog posts, formal AWS docs, etc. as much as feasible...*

*...if the customer started with the use of temporary VPCs in support of their first few development environments, highlight considerations when migrating to the use of a set of new networks to support their development,pre-production test, and production environments...*