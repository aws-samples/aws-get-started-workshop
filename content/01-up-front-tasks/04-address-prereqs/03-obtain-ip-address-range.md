---
title: 'Obtain Non-Overlapping IP Address Block'
menuTitle: '3. Obtain IP Address Block'
disableToc: true
weight: 30
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

If your initial proof of value workloads will require AWS networking resources, then you should address this prerequisite. If your initial workloads don't depend on AWS networking resources, you can skip this step.  For example, if your initial workloads use Amazon Simple Storage Service (Amazon S3), they might not need AWS networking resources.

In this step you should consult with your existing Network team to obtain a suitably sized, non-overlapping IP address range or [CIDR block](https://en.wikipedia.org/wiki/Classless_Inter-Domain_Routing) that can be used not only for the initial shared development network that will be set up in this guide, but also to accommodate test and and production networks that you will provision on AWS as you progress in your journey.

Since you will likely interconnect at least a portion of your on-premises networks to your emerging AWS hosted networks, a best practice is to assign a large IP address range or CIDR block for use in AWS that does not overlap with your existing allocated IP addresses. By using non-overlapping IP address ranges, you will avoid needing to introduce a complicated network address translation (NAT) solution.

## Recommended IP address range size

Ideally, taking into account future networks beyond the initial development network, you should obtain for your use of AWS overall, an IP address range or CIDR block of at least size `/18` to `/16`.

If the desired sizes of non-overlapping CIDR block cannot be obtained at this stage, you should obtain a block of at least size `/22` to address the initial shared development network.  You can obtain additional non-overlapping CIDR blocks later to support your build out of test and production networks.

{{% notice warning %}}
**Larger CIDR range is better:** Although 1,000 IP addresses may sound like a lot, don't assume that it's a sufficiently sized range even for your initial few workloads.  Since your initial shared development environment will likely have at least 4 subnets, when you divide a `/22` CIDR block across the 4 subnets, you end up with only 254 IP available addresses per subnet. Using a `/23` block would leave only 126 IP addresses per subnet. Depending on the number of workloads your infrastructure and workload builder teams will be experimenting and testing, these smaller ranges can end up being exhausted faster than you might expect.
{{% /notice %}}

## Unable to obtain non-overlapping IP address range

If you cannot obtain a non-overlapping CIDR block at this stage, you can temporarily use an overlapping block for your initial shared development network.

In the future, when you need to interconnect a portion of your existing on-premises network, you will need to create a new VPC with a non-overlapping CIDR block, migrate the workloads to the new VPC, and decommission the old VPC.

## Resources

* [VPC and Subnet Sizing for IPv4](https://docs.aws.amazon.com/vpc/latest/userguide//VPC_Subnets.html#vpc-sizing-ipv4)

* [Visual Subnet Calculator](http://www.davidc.net/sites/default/subnets/subnets.html)

