# Deploy Frontend and Backend Apps using Azure DevOps Pipeline


The pipeline was configured using Azure DevOps `yaml` editor to deploy to the Azure Inrastructure created by the terraform template in `Terraform-deployment` folder in this repository

There are two branches, the development branch should be used to deploy to Dev environment and the release/v1.0.0 is used to deploy to QA and then to Prod environment

The deployment pipelines for the frontend and backend applications are seperate and they require you have a project and service connections to the Azure Resource Manager using service principal identities on Azure DevOps

The variables are already declared in my pipeline and the description of the right values to be inserted

The pipelines are `azure-pipeline-frontend.yaml` and `azure-pipeline-backend.yaml` for frontend and backend deployment respectively with the `dockerfiles` for them

# Terraform Pipeline Deployment

The pipeline for terraform Infrastructure deployment has the following steps
- `Terraform Init`
- `Terraform Plan`
- `Terraform Apply`
- `Terraform Destroy` - Terraform Destroy (enabled) can be set to true once you can verify deployment and then you run the pipeline

The variables also have descriptions so they can fit into the Azure Resource deployment. 
# react-and-spring-data-rest

The application has a react frontend and a Spring Boot Rest API, packaged as a single module Maven application.

You can build the application running (`./mvnw clean verify`), that will generate a Spring Boot flat JAR in the target folder.

To start the application you can just run (`java -jar target/react-and-spring-data-rest-*.jar`), then you can call the API by using the following curl (shown with its output):

---

\$ curl -v -u greg:turnquist localhost:8080/api/employees/1
{
"firstName" : "Frodo",
"lastName" : "Baggins",
"description" : "ring bearer",
"manager" : {
"name" : "greg",
"roles" : [ "ROLE_MANAGER" ]
},
"\_links" : {
"self" : {
"href" : "http://localhost:8080/api/employees/1"
}
}
}

---

To see the frontend, navigate to http://localhost:8080. You are immediately redirected to a login form. Log in as `greg/turnquist`


# react-and-spring-data-rest