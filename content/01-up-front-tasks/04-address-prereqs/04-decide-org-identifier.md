---
title: 'Decide on Organization Identifier for Resource Naming'
menuTitle: '4. Decide on Organization ID'
disableToc: true
weight: 40
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

Since you will be assigning names to centrally managed cloud resources while you follow the steps in this guide, it's useful for you to decide on a unique organizational identifier to assign as a prefix to those names so that:
* Names of your resources won't collide with other names when working in global namespaces.
* You'll be able to create security policies to restrict access based on resources with that prefix.

You likely already use a stock ticker or another similar abbreviation within technical names in support of current business and IT processes.  One of these existing identifiers might be appropriate to carry forward as you build out your cloud environment.

You should limit the length of the abbeviated organization identifier to a handful of characters. Using no more than 4-5 characters is a good guide.

As an example, this guide uses the prefix **`example`** throughout. As you progress through the guide, you're expected to replace this example prefix with your own identifier.

{{% notice tip %}}
**More extensive resource naming standards:** As you progress on your journey, you may find it useful to adopt more extensive cloud resource naming standards.
{{% /notice %}}