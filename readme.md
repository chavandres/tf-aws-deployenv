# (WIP) Terraform and AWS - Deploy Dev Environment
This project is a learning experience based from the freeCodeCamp.org Terraform and AWS course in [Youtube](https://www.youtube.com/watch?v=iRaai1IBlB0).

## Setup

## What AWS resources are used?

## Basic Commands

`terraform init` -> Initializes the Terraform project in the directory. This pulls all of the providers defined in the provider blocks if they exist.<br>
`terraform plan` -> Checks the current state and lays out a list of all the changes that will be made in the environment i.e resources to create or destroy. Does not apply the changes.<br>
`terraform apply` -> Applies the changes that are defined in the terraform files that are still not present in the state. You can use a previous plan to apply that specific plan, otherwise Terraform checks the current plan and applies it.<br>
`terraform destroy` -> Destroys all of the resources defined in the plan. Another way of destroying single resources is to comment or delete them from the terraform files and apply the new environment using the *apply* command.<br>


`terraform show` -> Shows the state of the full deployment.<br>

`terraform state list` -> Display a list of resources currently deployed. <br>

`terraform state show <resource_name>` -> Display configuration information about the selected resource.<br>

`terraform console` -> <br>

## Data Sources

## Template Files


## A note on Provisioners


## Using Variables

## Adding Conditionals

## Outputs Values
