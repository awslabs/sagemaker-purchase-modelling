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

## Getting Started for SageMaker Notebook Instances

This section applies to launching your own SageMaker notebook instance through CloudFormation. If you're using SageMaker Studio you can just on-click-launch the solution.

To get started quickly, use the following quick-launch link to launch a CloudFormation Stack create form and follow the instructions below to deploy the resources in this project.

| Region | Stack |
| ---- | ---- |
|US East (N. Virginia) | [<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">](https://us-east-1.console.aws.amazon.com/cloudformation/home?region=us-east-1#/stacks/create/review?templateURL=https://sagemaker-solutions-prod-us-east-1.s3.us-east-1.amazonaws.com/Sagemaker-purchase-modelling/deployment/sagemaker-purchase-modelling.yaml&stackName=sagemaker-soln-pmdl-awslabs) |
|US East (Ohio) | [<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">](https://us-east-2.console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/create/review?templateURL=https://sagemaker-solutions-prod-us-east-2.s3.us-east-2.us-east-2.amazonaws.com/Sagemaker-purchase-modelling/deployment/sagemaker-purchase-modelling.yaml&stackName=sagemaker-soln-pmdl-awslabs) |
|US West (Oregon) | [<img src="https://s3.amazonaws.com/cloudformation-examples/cloudformation-launch-stack.png">](https://us-west-2.console.aws.amazon.com/cloudformation/home?region=us-west-2#/stacks/create/review?templateURL=https://sagemaker-solutions-prod-us-west-2.s3.us-west-2.amazonaws.com/Sagemaker-purchase-modelling/deployment/sagemaker-purchase-modelling.yaml&stackName=sagemaker-soln-pmdl-awslabs) |


### Additional Instructions

* On the stack creation page, check the box to acknowledge creation of IAM resources, and click **Create Stack**. This should trigger the creation of the CloudFormation stack.

* Once the stack is created, go to the Outputs tab and click on the *SageMakerNotebook* link. This will open up a Jupyter notebook named `sagemaker-purchase-modelling` in a SageMaker Notebook instance where you can run the code. Follow the instructions in the notebook to run the solution. You can use `Cells->Run All` from the Jupyter menu to run all cells, and return to the notebook later after all cells have executed. The total time to run all cells should be around 40 minutes.

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


