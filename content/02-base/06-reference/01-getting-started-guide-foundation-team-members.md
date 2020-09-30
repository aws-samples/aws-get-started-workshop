---
title: 'Getting Started Guide for Foundation Team'
menuTitle: 'Gettting Started: Foundation'
disableToc: true
weight: 10
---

{{% comment %}}
Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
SPDX-License-Identifier: CC-BY-SA-4.0
{{% /comment %}}

{{% notice tip %}}
**An Example Getting Started Guide:** This document represents an example that can help you develop and publish your own getting started guide internally for cloud foundation team members that are onboarding to your AWS environment.  You are free to copy this content into your own internal wiki or other system and modify it to meet your needs. As you progress on your cloud adoption journey, you will likely significantly expand your internal documentation to help communicate additional and increasingly sophisticated capabilities and associated best practices that are available to teams.
{{% /notice %}}

This document is intended to provide foundation team members with awareness of the typical day-to-day tasks and supporting methods, tools, and AWS services to help them manage and monitor your new AWS environment.

{{< toc >}}

## All foundation team members

### Understanding your team's initial development environment

Since your team will need to experiment, develop, and perform early testing of changes to foundation resources and may need to reproduce issues as you support other teams using the environment, your team also needs a development environment.

Just like other builder teams, your foundation team has been allocated a team developer AWS account. The only differences between your team's development AWS account and other teams are:

* Only the foundation team has permissions to access its team development AWS account.
* Service Control Policies (SCPs) to restrict the creation of VPC resources has not been applied to your foundation team development AWS account.

{{% notice tip %}}
**Use Team Development Access Permissions for Most of Your Work**: When you're needing to experiment, develop, and test foundation changes and/or reproduce user issues, you're strongly encouraged to use the team development access permission and your team development AWS account as opposed to using your cloud administrative access permissions in any AWS account. You should only use your cloud administrative access permissions for cloud administrative work.
{{% /notice %}}

See [Getting Started Guide for Builder Teams]({{< relref "01-getting-started-guide-builder-team-members" >}}) for information on using your team development environment.

## Cloud administrators

### Gain more familiarity with AWS Control Tower

Since AWS Control Tower is the primary means by which you'll be creating AWS accounts, organizing them in OUs, and managing guardrails, it's important that you become familiar with recurring tasks.

#### Making changes to OUs and AWS account names

When you make changes to AWS account names and AWS Organizations OU names outside of AWS Control Tower, you'll need to take steps in AWS Control Tower to ensure that it us up-to-date. See [Managing Resources Outside of AWS Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/external-resources.html) for details.

#### Other AWS Control Tower tasks

* Applying [AWS Control Tower updates](https://docs.aws.amazon.com/controltower/latest/userguide/configuration-updates.html).
  * Note that you may need to [disable AWS Control Tower's creation of VPCs](https://docs.aws.amazon.com/controltower/latest/userguide/configure-without-vpc.html) after you apply AWS Control Tower updates.
* Deleting [default VPCs created by AWS Control Tower](https://docs.aws.amazon.com/controltower/latest/userguide/configure-without-vpc.html) in the master AWS account.
* Responding to alerts from AWS Control Tower guardrails and other AWS platform monitoring services.
* Monitoring costs across accounts on at least a weekly basis.

## Security administrators

By following this guide, your foundation team has already established a foundation for security:

* Leveraged AWS Control Tower to set up and govern a secure, compliant, multi-account AWS environment based on best practices established by working with thousands of enterprises.
* Established mandatory [Guardrails](https://docs.aws.amazon.com/controltower/latest/userguide/guardrails.html) to provide ongoing governance for your overall AWS environment. Additional guardrails are available and should be reviewed by your security administrator and team.
* Established [AWS CloudTrail](https://docs.aws.amazon.com/awscloudtrail/latest/userguide/cloudtrail-user-guide.html) logging to capture all actions taken by users, roles and services across all of your AWS accounts.
* Secured the root user of your AWS accounts with multi-factor authentication (MFA).
* Set up an initial degree of AWS platform access management.

### Identify day-to-day tasks for this role

Consider starting with the following list:

* Responding to alerts from AWS Control Tower guardrails and other AWS platform monitoring services.
* Onboarding and de-provisioning users and groups via AWS SSO.
* Developing, testing, and rolling out access permissions via:
  * AWS SSO Permission Sets.
  * AWS Organizations Service Control Policies (SCPs) 

### Review and enable foundational security services

While security is weaved within all AWS services and capabilities, a few explicit AWS Security, Identity, & Compliance services you should be aware of at this point in your journey are:

****[Amazon GuardDuty](https://docs.aws.amazon.com/guardduty/latest/ug/what-is-guardduty.html)**** is our threat detection service that continuously monitors for malicious activity and unauthorized behavior to protect your AWS accounts and workloads. To use GuardDuty, it is a service that needs to be enabled. We recommend [enabling](https://docs.aws.amazon.com/guardduty/latest/ug/guardduty_settingup.html) the service for the 30-day free trial and see the visibility and value it brings to your security practice.

****[AWS Shield](https://docs.aws.amazon.com/waf/latest/developerguide/shield-chapter.html)**** is a managed Distributed Denial of Service (DDoS) protection service that safeguards applications running on AWS. AWS Shield provides always-on detection and automatic inline mitigations that minimize application downtime and latency, so there is no need to engage AWS Support to benefit from DDoS protection. There are two tiers of AWS Shield - Standard and Advanced. All AWS customers benefit from the automatic protections of AWS Shield Standard, at no additional charge.

****[AWS Security Hub](https://docs.aws.amazon.com/securityhub/index.html)**** AWS Security Hub provides you with a comprehensive view of the security state of your AWS resources. Security Hub collects security data from across AWS accounts and services, and helps you analyze your security trends to identify and prioritize the security issues across your AWS environment.

### Access AWS CloudTrail

[AWS CloudTrail](https://aws.amazon.com/cloudtrail/) is an AWS service that helps you enable governance, compliance, and operational and risk auditing of your AWS account. Actions taken by a user, role, or an AWS service are recorded as events in CloudTrail. Events include actions taken in the AWS Management Console, AWS Command Line Interface, and AWS SDKs and APIs.

1. Sign in to the AWS Management Console and open the CloudTrail console at https://console.aws.amazon.com/cloudtrail/home/.
2. Review the information in your dashboard about the most recent events that have occurred in your AWS account. One of these events should be a "ConsoleLogin" event, showing that you just signed in to the AWS Management Console.
3. Expand the event to see additional information.
4. As your usage of the platform grows you will find value in additional capabilities like search, filtering, and exporting the CloudTrail data.

### Develop and hone your AWS IAM skills

{{% notice note %}}
**Review Note: Provide guidance on developing and honing IAM skills:** Provide pointers about how to learn more about effective use of IAM. For example, IAM Policy Simulator, testing policy changes before promoting them, IaC code techniques, etc. Reference how [AWS Access Analyzer](https://docs.aws.amazon.com/IAM/latest/UserGuide/what-is-access-analyzer.html) can be used to help identify the resources in organization and accounts, such as Amazon S3 buckets or IAM roles, that are shared with an external entity.
{{% /notice %}}

### Perform periodic reviews of the AWS security configuration

Although some of the detective guardrails deployed through AWS Control Tower help continuously monitor and audit aspects of your AWS environment, it’s a best practice to periodically audit your security configuration to make sure that it meets your current business needs. See AWS [Security Audit Guidelines](https://docs.aws.amazon.com/general/latest/gr/aws-security-audit-guide.html) for best practices.

### Monitor and manage resource configuration state

As resources are deployed in your account, managing the growing inventory of resources and ensuring that they are deployed consistently and maintained consistently can become a challenge. [AWS Config](https://docs.aws.amazon.com/config/latest/developerguide/WhatIsConfig.html) is a Management and Governance tool available to help you with:

* Resource Administration and Governance
* Auditing and Compliance
* Managing and Troubleshooting Configuration changes
* Security Analysis

More specifically, you can do the following with AWS Config:

* Evaluate your AWS resource configurations for desired settings.
* Get a snapshot of the current configurations of the supported resources that are associated with your AWS account.
* Retrieve configurations of one or more resources that exist in your account.
* Retrieve historical configurations of one or more resources.
* Receive a notification whenever a resource is created, modified, or deleted.
* View relationships between resources. For example, you might want to find all resources that use a particular security group.

Once you have resources deployed in your account, consider [Getting Started with AWS Config](https://docs.aws.amazon.com/config/latest/developerguide/getting-started.html).

## Cost managers

AWS Cost Management tools give you and your team visibility into AWS account costs and usage. Each account you create will have access to view their individual account costs and usage. The Master account can see the total organizational cost and usage rollup.

### Access the billing and cost management dashboard

Sign in to the AWS Management Console and open the Billing and Cost Management console at [https://console.aws.amazon.com/billing/home#/](https://console.aws.amazon.com/billing/home)

There are a range of AWS Cost Management tools to help you access, organize, understand, control, and optimize your costs. You start to access detailed information about your AWS costs and usage using the built-in dashboard in the Billing and Management area of the AWS Management Console.

### Enable AWS Cost Explorer

To see more detailed cost information for the entire organization of AWS accounts and to enable builder teams to access cost reporting within their own AWS accounts, you should enable the [AWS Cost Explorer](https://aws.amazon.com/aws-cost-management/aws-cost-explorer/):

1. As a **Cost Manager**, use your personal user to log into AWS SSO.
2. Select the AWS **master** account.
3. Select `Management console` associated with the `Billing` role.
4. Access the `Billing` service.
5. Select `Cost Explorer`.
6. Choose `Enable Cost Explorer`.

### Enable EC2 right sizing recommendations

Enable [Amazon EC2 Right Sizing Recommendations](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/ce-rightsizing.html) so that the foundation and workload builder teams can gain insight into recommendedations for downsizing and terminating EC2 instances.

### Create a budget

For more proactive management of your AWS costs, set up budgets within the Billing and Management console. Budgets allow you to:

* View your usage against a planned/budgeted amount.
* See where your usage is within free tier limits and limits you set.
* Estimate your usage each month based on consumption of the budget
* Make decisions on frequently updated usage and cost data. Budget data is updated three times each day to give you the most accurate information.
* Create alerts based on a budget to notify you or others as budget thresholds are reached. Each budget alert notification can be sent to up to 10 email addresses and 1 SNS topic for subscribers.

Take a few minutes and create an initial basic budget by following this guide [Create your first Budget](https://docs.aws.amazon.com/awsaccountbilling/latest/aboutv2/budgets-create.html).