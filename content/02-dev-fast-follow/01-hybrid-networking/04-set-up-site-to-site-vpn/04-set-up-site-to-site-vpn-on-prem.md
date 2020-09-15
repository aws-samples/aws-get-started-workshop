---
title: 'Configure On-premises Side of the VPN Connection'
menuTitle: '4. Configure VPN Connection'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

Your next step is to obtain VPN configuration data from the **`network-prod`** AWS account and use it to configure your on-premises customer gateway device.

{{< toc >}}

## 1. Download VPN configuration file

First, download a configuration file containing the details of the site-to-site VPN connection:

1. As a Cloud Administrator, use your personal user to log into AWS SSO.
2. Select the **`network-prod`** AWS account
3. Select **`Management console`** associated with the **`AWSAdministratorAccess`** role.
4. Select the appropriate AWS region.
5. Navigate to **`VPC`**
6. Select **`Site-to-Site VPN Connections`**
7. Select the connection that was just created
8. Download the VPN configuration information by clicking **`Download Configuration`**. 
9. Select your Vendor, Platform, and Software of your customer gateway device from the menus.  If your specific device is not available, select **`Generic`**.

## 2. Configure your on-premises customer gateway

Use the configuration data to configure your on-premises customer gateway. See [Your customer gateway device](https://docs.aws.amazon.com/vpn/latest/s2svpn/your-cgw.html) in the [AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn) documentation for details.

{{% notice tip %}}
**Simulating On-Premises Customer Gateway:** If you're either experimenting with AWS Site-to-Site VPN connections or demonstrating how they work, you can easily simulate a customer on-premises environment and customer gateway. See [Simulating Site-to-Site VPN Customer Gateways Using strongSwan](https://aws.amazon.com/blogs/networking-and-content-delivery/simulating-site-to-site-vpn-customer-gateways-strongswan/) for details on setting up an open source based VPN gateway in a separate VPC that simulates an on-premises environment.
{{% /notice %}}

## 3. Configure routing in your on-premises environment

Ensure that your on-premises router configuration has been updated to route network traffic destined for the CIDR ranges allocated to your AWS environment to your customer gateway.

## 4. Confirm status of the VPN connection

After your on-premises customer gateway has been configured, check the status of your VPN connection.

1. Select **`Site-to-Site VPN Connections`**
2. Select the connection that was just created
3. Select **`Tunnel Details`**.
4. Monitor the status of the tunnels.  After several minutes, at least one of the two tunnels should transition to the **`UP`** state.

If at least one of the tunnels does not come up, then see [Troubleshooting your customer gateway device](https://docs.aws.amazon.com/vpn/latest/s2svpn/Troubleshooting.html)