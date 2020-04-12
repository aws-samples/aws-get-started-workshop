---
title: "Custom Baseline Management"
disableToc: true
weight: 20
---

This section addresses options and resources to enable your foundation team to define and efficiently roll out new and updated cloud resources or "baselines" across your AWS accounts to further secure the overall environment and deliver useful common capabilities to your internal teams. 

## Content to be Rolled Out Across AWS Accounts Covered Separately

The actual security and compliance controls and typical common foundation resources that would be handled by the baseline mechanism are covered in other sections. For example:
* [Enhanced Security Monitoring and Compliance]({{< relref "02-enhanced-security-monitoring-and-compliance.md" >}})
* [Enhanced Access Controls]({{< relref "01-enhanced-access-controls.md" >}})

## Requirements

### Automation and Infrastructure as Code (IaC)

As the degree of customization and extent of your foundation resources expands over time, you'll benefit for having an automated means to roll out and manage such resources.  Additionally, you'll benefit from using Infrastructure as Code (IaC) and other common practices to treat such resources as code that progresses through a modern development and testing workflow.

### Ability to Target AWS Organization Units (OUs) and Independent AWS Accounts

...

### Ability to Test and Progressively Roll Out New and Updated Baselines

...

## Solution Options and Resources

*...position AWS Control Tower's guardrails feature in this context...*

### Customizations for AWS Control Tower

See [AWS Solutions Customizations for AWS Control Tower](https://aws.amazon.com/solutions/customizations-for-aws-control-tower/)

### AWS Deployment Framework

[AWS Deployment Framework](https://github.com/awslabs/aws-deployment-framework/)

### AWS CloudFormation StackSets

[AWS CloudFormation StackSets with AWS Organizations](https://aws.amazon.com/blogs/aws/new-use-aws-cloudformation-stacksets-for-multiple-accounts-in-an-aws-organization/) introduced the ability to automatically apply stacksets as member accounts join and leave OUs.

[AWS Control Tower Lifecycle Event Notifications](https://aws.amazon.com/about-aws/whats-new/2020/01/aws-control-tower-introduces-lifecycle-event-notifications/) can help trigger automation to manage the lifecyle of baselines.