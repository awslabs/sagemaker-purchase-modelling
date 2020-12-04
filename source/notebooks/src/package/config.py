# Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
# SPDX-License-Identifier: Apache-2.0
import json
from pathlib import Path

from package import utils

current_folder = utils.get_current_folder(globals())
cfn_stack_outputs_filepath = Path(current_folder, '../../../stack_outputs.json').resolve()
assert cfn_stack_outputs_filepath.exists(), "Could not find stack_outputs.json file at {}".format(
    str(cfn_stack_outputs_filepath))

with open(cfn_stack_outputs_filepath) as f:
    cfn_stack_outputs = json.load(f)

STACK_NAME = cfn_stack_outputs['StackName']
SOLUTION_PREFIX = cfn_stack_outputs['SolutionPrefix']
AWS_ACCOUNT_ID = cfn_stack_outputs['AwsAccountId']
AWS_REGION = cfn_stack_outputs['AwsRegion']
SAGEMAKER_IAM_ROLE = cfn_stack_outputs['IamRole']
MODEL_DATA_S3_BUCKET = cfn_stack_outputs['ModelDataBucket']
SOLUTIONS_S3_BUCKET = cfn_stack_outputs['SolutionsS3Bucket']
SOLUTION_NAME = cfn_stack_outputs['SolutionName']
TEST_OUTPUTS_S3_BUCKET = cfn_stack_outputs.get('TestOutputsS3Bucket', "")
