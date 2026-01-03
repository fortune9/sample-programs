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
ami_id = "ami-############"  # AMI ID
key_name = "your-key-name"  # such as "my-aws-key"
security_group = "allow-all-internal-traffic"
vpc_id = "vpc-############"  # VPC ID
subnet_id = "subnet-############"  # Subnet ID

# Get the security group
sg = aws.ec2.SecurityGroup.get(security_group,
    id="sg-############")  # Security Group ID

# Get the existing IAM role
role = aws.iam.Role.get("existing-role",
    id=iam_role,
    name=iam_role
)

# Get existing instance InstanceProfile
instance_profile = aws.iam.get_instance_profile(
    name=iam_role
)

# Create the EC2 instance
instance = aws.ec2.Instance("ec2-instance",
    ami=ami_id,
    instance_type=instance_type,
    key_name=key_name,
    subnet_id=subnet_id,
    vpc_security_group_ids=[sg.id],
    iam_instance_profile=instance_profile.name,
    root_block_device=aws.ec2.InstanceRootBlockDeviceArgs(
        volume_type="gp3",
        volume_size=volume_size,
        delete_on_termination=True,
    ),
    tags={ # tags for the instance
        "Name": "my-pulumi-ec2-instance",
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
