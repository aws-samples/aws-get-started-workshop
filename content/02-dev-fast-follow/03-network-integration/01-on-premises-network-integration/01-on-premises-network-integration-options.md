---
title: 'On-Premises Network Integration Options'
menuTitle: 'Network Integration Options'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

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

## AWS Site-to-Site VPN

See [Establishing Site-to-Site VPN Connection]({{< relref "02-site-to-site-vpn" >}})