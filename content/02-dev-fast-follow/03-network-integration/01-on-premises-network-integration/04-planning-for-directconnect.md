---
title: 'Plan for Use of AWS Direct Connect'
menuTitle: 'Plan for Direct Connect'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section provides an overview how you can start the process for using AWS Direct Connect to either replace or augment your initial use of AWS Site-to-Site VPN as the basis for your on-premises and AWS network connectivity.

## Planning for AWS Direct Connect

Since there can be lead times of several weeks or more to establish AWS Direct Connect-based connectivity to your on-premises environment, you might want to start the process soon even if you don't intend to depend on AWS Direct Connect in support of your initial few production workloads on AWS.

## Transitioning to Using AWS Direct Connect

Based on the architecture outlined in this guide where AWS Transit Gateway is used as a means to integrate your on-premises connectivity to your AWS VPC, it will be straightforward for you to incorporate use of AWS Direct Connect into this architecture. Generally, your configuration of your AWS VPCs should not need to be modified to take advance of the transition to AWS DirectConnect.  Most of the changes will be limited to you setting up AWS Direct Connect and enhancing your AWS Transit Gateway configuration.

AWS Direct Connect can either supplant your initial AWS Site-to-Site VPN connection or be configured to use your AWS Site-to-Site VPN connection as a fail-over solution.

## Getting Started with AWS Direct Connect

See [Getting Started with AWS Direct Connect](https://aws.amazon.com/directconnect/getting-started/) for information on setting up an AWS Direct Connect connection.