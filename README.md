# Purchase Modelling with Amazon SageMaker

When customers visit an ecommerce website, they will perform certain actions and will eventually either make a
purchase or end their session without a purchase. Website operators can use the browsing behavior of their
customers to build machine learning models that allow them to target customers that are more likely to convert
with promotions. In this solution we will demonstrate how one can use SageMaker to perform the modelling part
to determine the likelihood of a customer making a purchse.

Specifically, we show how to use Amazon SageMaker to train a supervised machine learning model on historical
user sessions, and evaluate their performance. We also show how to deploy the models and monitor their input
and output to detect data problems. This project includes a demonstration of this process using a
[generated dataset](https://www.kaggle.com/benpowis/customer-propensity-to-purchase-data?select=training_sample.csv) of
visits to a fictional website, but can be easily modified to work with custom labelled or unlaballed data
provided as a relational table in csv format.

## Getting Started

You will need an AWS account to use this solution. Sign up for an account [here](https://aws.amazon.com/).

To run this JumpStart 1P Solution and have the infrastructure deploy to your AWS account you will need to create an active SageMaker Studio instance (see [Onboard to Amazon SageMaker Studio](https://docs.aws.amazon.com/sagemaker/latest/dg/gs-studio-onboard.html)). When your Studio instance is *Ready*, use the instructions in [SageMaker JumpStart](https://docs.aws.amazon.com/sagemaker/latest/dg/studio-jumpstart.html) to 1-Click Launch the solution.

The solution artifacts are included in this GitHub repository for reference.

*Note*: Solutions are available in most regions including us-west-2, and us-east-1.

**Caution**: Cloning this GitHub repository and running the code manually could lead to unexpected issues! Use the AWS CloudFormation template. You'll get an Amazon SageMaker Notebook instance that's been correctly setup and configured to access the other resources in the solution.

## Data

The example dataset used in this solution, "Customer propensity to purchase dataset", was released in the public domain by Ben Powis under the [CC0 license](https://creativecommons.org/publicdomain/zero/1.0/), original download source available [here](https://www.kaggle.com/benpowis/customer-propensity-to-purchase-data?select=training_sample.csv).

It includes 25 columns with binary features like `basket_icon_click` and `sign_in` that indicate whether
a particular session included a website action, with the label, `ordered`, indicating whether the customer
made a purchase during the session.

A copy of the license the data was released under is included in DATA-LICENSE.txt


## Contents

* `deployment/`
  * `sagemaker-purchase-modelling.yaml`: Creates AWS CloudFormation Stack for solution
* `source/`
  * `notebooks/`
    * `src`
      * `package`
        * `config.py`: Read in the environment variables set by cloudformation stack creation
  for inference
        * `utils.py`: Helper function and utilities
    * `sagemaker_purchase_modelling.ipynb`: Entry point of the solution. Trains the models and deploys the trained model.

## License

This project is licensed under the Apache-2.0 License.


