#!/bin/bash
set -e

if [ "$1" == "-h" ]; then
  echo "Usage: ./build.sh <trademarked-solution-name> <destination-s3-bucket> <region> [<branch-name>]"
  echo "The 'branch-name' is meant to be used to have multiple versions of the solution under the same bucket."
  echo "If 'mainline' is provided as the 'branch-name', no suffix is added to the S3 destination."
  exit 0
fi

# Check to see if input has been provided:
if [ -z "$1" ] || [ -z "$2" ] || [ -z "$3" ]; then
    echo "Please provide the solution name as well as the base S3 bucket name and the region to run build script."
    echo "For example: ./build.sh trademarked-solution-name sagemaker-solutions-build us-west-2"
    exit 1
fi

solution_name=$1
solution_bucket=$2
region=$3
base_dir="$PWD"


if [ -z "$4" ] || [ "$4" == 'mainline' ]; then
    s3_prefix="s3://$2-$3/$1"
else
    s3_prefix="s3://$2-$3/$1-$4"
fi

echo "Cleaning existing build folder"
rm -rf build
mkdir -p build

# Prep solution assistant lambda environment
echo "Installing local requirements for solution assistant lambda function"
cd "$base_dir" || exit
cd ./deployment/solution-assistant && pip install -r requirements.txt -t ./src/site-packages
# Clean up pyc files, needed to avoid security issues. See: https://blog.jse.li/posts/pyc/
cd "$base_dir" || exit
find ./deployment/ -type f -name "*.pyc" -delete
find ./deployment/ -type d -name "__pycache__" -delete


# Package solution assistant lambda
cd "$base_dir" || exit
echo "Copying and packaging solution assistant lambda function"
cp -r ./deployment/solution-assistant/src build/
cd build/src || exit
zip -q -r9 "$base_dir"/build/solution_assistant.zip -- *


cd "$base_dir" || exit

# Run cfn-nag and viperlight scan locally if available, but don't cause build failures
{
    if command -v cfn_nag &> /dev/null
    then
        echo "Running cfn_nag scan"
        for y in `find ./deployment/* -name "*.yaml"`;  do
            echo "============= $y ================" ;
            cfn_nag --fail-on-warnings $y || ec1=$?;
        done
    fi

    if command -v viperlight &> /dev/null
    then
        echo "Running viperlight scan"
        viperlight scan
    fi
} || true

# Clean up existing artifacts under s3
echo "Clearing existing objects under $s3_prefix"
aws s3 rm --recursive "$s3_prefix"

# Copy data and artifacts
aws s3 sync s3://sagemaker-solutions-artifacts/Sagemaker-purchase-modelling/ "${s3_prefix}/"

# Clean up lambda folders
rm -rf build/src

echo "Copying folders to $s3_prefix"
aws s3 cp --recursive build "$s3_prefix"/build
aws s3 cp --recursive deployment "$s3_prefix"/deployment
aws s3 cp --recursive source "$s3_prefix"/source --exclude "source/notebooks/.ipynb_checkpoints/*" \
    --exclude ".DS_Store"
aws s3 cp --recursive test "$s3_prefix"/test --exclude "test/.ipynb_checkpoints/*"

echo "Build Successful!"
