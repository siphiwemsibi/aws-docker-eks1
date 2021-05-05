Using Azure DevOps to dockerize and deploy an app to AWS EKS

What?

This project will assist you to use Azure DevOps pipeline(YAML) to containerize and deploy an application to AWS EKS(Elastic Kubernetes Service). 

Why?

The aim was to help the developers to automate applications deployments with an end-end visible, traceable manner(when deployments fail, how do we know which build and image was used?)  and a less to no pipeline changes and just focus on the code.
And obviously to show how awesome Azure DevOps is🙂


Prerequisites:-

	○ A running AWS EKS Cluster
	○ AWS ECR(Elastic Container Registry)
	○ AWS Kubernetes service connection
	○ AWS Services Connection
	○ An Azure DevOps account
	○ AWS Toolkit for Azure DevOps
	○ A Github account(or any Git based vcs)
	○ An application to be dockerized and deployed(free to use my sample)


Repo structure:-

	1. Source folder: contains my python sample app
	2. Root folder:
		○ Dockerfile: used to dockerize my python app
		○ App-manifest: a yaml Kubernetes deployment type(pod), application manifest
		○ Azure-pipelines: This is a multi-stage yaml which contains all the steps required for the pipeline
		○ Requirements: These are the application requirements
	

Usage:-

You are free to clone the repo and retrofit to your requirements, or you can copy any component but there are modifications required on the Azure-pipeline.

1. AWS Kubernetes service connection
- https://www.efficientclouds.com/post/how-to-connect-azure-devops-to-eks
2. AWS Services Connection
- Install AWS Toolkit for Azure DevOps https://aws.amazon.com/vsts/
- Requires an Access Key ID and Secret Access Keys
- https://docs.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml
	
	
3. Azure-pipeline
- Ensure your repo name presents your app(E.G aws-docker-eks1) - easier to reference during automation


- Build Stage
 a. Authenticates to AWS ECR using my AWS service connection(AWS-Connection-1) 
 b. Builds and tags the docker image from the dockerfile 
 c. Pushes the image to AWS ECR
 d. Copies the App-manifest.yaml to the staging directory for Release

- Deploy Stage
 a. Downloads the App-manifest.yaml for deployment
 b. Authenticates and deploys the YAML file to the AWS EKS cluster

Things to note on the Pipeline and App-manifest

- I am using the Azure DevOps Predefined variables[$(Build.BuildNumber), $(Build.Repository.Name)] for automation purposes(Image tagging on the YAML deployment & ECR repo) 
- I am using self-defined variables[$(AWS_REGION), $(ECR_ID)] for automation purposes. 
- I have also enabled Approvals for EKS deployment(continuous deploy)  


Ok, so how do you use this for testing without changing a lot??

- Meet the prerequisites 
- Change the self-defined variables
- Change the kubectl set "arguments" line 104 on the pipeline, to your own ECR
- Change the "image" to your own ECR


Please try and shout if you have problems as this is the 1st MVP, proper blog to come soon if the need arises. 