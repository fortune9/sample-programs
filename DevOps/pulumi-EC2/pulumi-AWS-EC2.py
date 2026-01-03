#!/usr/bin/env python3
"""
Pulumi program to create an AWS EC2 instance with configurable parameters.
"""

import pulumi
import pulumi_aws as aws

# Configuration
config = pulumi.Config()

# Get configuration values with defaults
instance_type = config.get("instance_type") or "t2.large"
iam_role = config.get("iam_role") or "s3-mounting-ec2-role"
volume_size = 100  # Default 100GB
availability_zone = "us-west-2b"
ami_id = "ami-03f65b8614a860c29"  # From cpu-instance-settings.json
key_name = "zzhang-exact"  # From cpu-instance-settings.json
security_group = "allow-all-internal-traffic"
vpc_id = "vpc-063511422db1cf89c"  # From cpu-instance-settings.json
subnet_id = "subnet-0370cd18645d08b5a"  # From cpu-instance-settings.json

# Get the security group
sg = aws.ec2.SecurityGroup.get(security_group,
    id="sg-0b1b534a999616b84")

# Get the IAM role
role = aws.iam.Role.get(iam_role,
    arn=f"arn:aws:iam::340995198511:role/{iam_role}")

# Create the EC2 instance
instance = aws.ec2.Instance("ec2-instance",
    ami=ami_id,
    instance_type=instance_type,
    key_name=key_name,
    subnet_id=subnet_id,
    vpc_security_group_ids=[sg.id],
    iam_instance_profile=aws.iam.InstanceProfile("ec2-instance-profile",
        role=role.name).name,
    root_block_device=aws.ec2.InstanceRootBlockDeviceArgs(
        volume_type="gp3",
        volume_size=volume_size,
        delete_on_termination=True,
    ),
    tags={
        "Name": "Zhang_sDNA_pipeline_dev",
        "owner": "zzhang",
    },
    opts=pulumi.ResourceOptions(depends_on=[role])
)

# Export the instance details
pulumi.export("instance_id", instance.id)
pulumi.export("private_ip", instance.private_ip)
pulumi.export("private_dns", instance.private_dns)
pulumi.export("instance_type", instance.instance_type)
pulumi.export("iam_role", iam_role)
