# Strategy for learning

The trick to learning something fast is creating a model to represent the idea
and then validate it.

Steps to learn

- Create a domain modeling
- Validate the domain model

## Example

A company has many AWS accounts that individual business groups own. One of the
accounts was recently compromised. The attacker launched a large number of
instances, resulting in a high bill for that account. The company addressed the
security breach, but a solutions architect needs to develop a solution to
prevent excessive spending in all accounts. Each business group wants to retain
full control of its AWS account. Which solution should the solutions architect
recommend to meet these requirements?

1. Use AWS Organizations. Add each AWS account to the management account. Create
   an SCP that uses the ec2:instanceType condition key to prevent the launch of
   high-cost instance types in each account.

2. Attach a new customer-managed IAM policy to an IAM group in each account.
   Configure the policy to use the ec2:instanceType condition key to prevent the
   launch of high-cost instance types. Place all the existing IAM users in each
   group.

3. Turn on billing alerts for each AWS account. Create Amazon CloudWatch alarms
   that send an Amazon Simple Notification Service (Amazon SNS) notification to
   the account administrator whenever the account exceeds a designated spending
   threshold.

4. Turn on AWS Cost Explorer in each account. Review the Cost Explorer reports
   for each account on a regular basis to ensure that spending does not exceed
   the desired amount.

The answer is 3

### Domain model

- aws organization
- policy
- billing alerts
- cost explorer

Something that I added

- best practices

Question 1

## See also

- [Neuroscience on how learning occurs](../426)
- [Different types of learning](../345)
