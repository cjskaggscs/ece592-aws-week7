import boto3

client = boto3.client('ec2', region_name='es-east-1')
client.enable_ebs_encryption_by_default()
