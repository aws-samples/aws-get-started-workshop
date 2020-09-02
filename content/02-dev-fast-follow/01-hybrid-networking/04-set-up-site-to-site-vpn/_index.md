---
title: 'Establish Site-to-Site VPN Connection with AWS Transit Gateway'
menuTitle: 'Establish VPN Integration'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

This section provides detailed step-by-step instructions for using AWS Site-to-Site VPN and AWS Transit Gateway as a means to quickly and securely establish network connectivity between your on-premises and AWS environments. 

By following these instructions, you will enable network connectivity between your on-premises environment and the centrally managed development VPC you established earlier in this guide.

Later in this guide, when you set up your test and production VPCs, the steps required to enable those VPCs to reuse your site-to-site VPN connection will be addressed.  The process in your AWS environment will be largely a repeat of the steps in this section that are used to connect your development VPC to your on-premises network.

{{% notice tip %}}
**Set up a virtual on-premises environment:** If you don't have access to an actual on-premises data center environment and you'd like to either evaluate or demonstrate the AWS Site-to-Site VPN capabilities, see [Setting Up a Virtual On-Premises Environment]({{< relref "05-virtual-on-premises" >}}) for instructions on how to set up a test on-premises environment in AWS.  You can deploy either open source or commercial VPN/router appliances in your virtual on-premises environment to act as the customer gateway device.
{{% /notice %}}

{{% children showhidden="false" %}}