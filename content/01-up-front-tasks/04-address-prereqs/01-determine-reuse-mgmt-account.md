---
title: 'Decide Whether to Reuse Existing AWS Management Account'
menuTitle: '1. Decide on Reusing Account'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

Later in this guide you'll be using AWS Control Tower to set up an initial landing zone or basis of your AWS environment.  Since AWS Control Tower supports reusing existing AWS Organizations management AWS accounts and using newly created management AWS accounts, you need to decide which option best suites your needs.

Review [Plan Your AWS Control Tower Landing Zone](https://docs.aws.amazon.com/controltower/latest/userguide/planning-your-deployment.html) for guidance when considering whether or not to use an existing management AWS account.

If you have any doubts about the quality of an existing management AWS account, then it's recommended that you create a new management AWS account via this guide to support your new AWS environment. You can easily move existing AWS accounts into your new management AWS account later on.