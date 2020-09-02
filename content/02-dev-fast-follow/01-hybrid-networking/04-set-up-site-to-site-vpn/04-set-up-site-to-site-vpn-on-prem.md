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

## 1. Download VPN Configuration File

1. Select **`Site-to-Site VPN Connections`**
2. Select the connection that was just created
3. Download the VPN configuration information by clicking **`Download Configuration`**. 
4. Select your Vendor, Platform, and Software of your customer gateway device from the menus.  If your specific device is not available, select **`Generic`**.

## 2. Configure Your On-Premises Customer Gateway

Use the configuration data to configure your on-premises customer gateway. See [Your customer gateway device](https://docs.aws.amazon.com/vpn/latest/s2svpn/your-cgw.html) in the [AWS Site-to-Site VPN](https://docs.aws.amazon.com/vpn/latest/s2svpn) documentation for details.

## 3. Configure Routing in Your On-Premises Environment

Ensure that your on-premises router configuration has been updated to route network traffic destined for the CIDR ranges allocated to your AWS environment to your customer gateway.

## 4. Confirm Status of the VPN Connection

After your on-premises customer gateway has been configured, check the status of your VPN connection.

1. Select **`Site-to-Site VPN Connections`**
2. Select the connection that was just created
3. Select **`Tunnel Details`**.
4. Monitor the status of the tunnels.  After several minutes, at least one of the two tunnels should transition to the **`UP`** state.

If at least one of the tunnels does not come up, then see [Troubleshooting your customer gateway device](https://docs.aws.amazon.com/vpn/latest/s2svpn/Troubleshooting.html)