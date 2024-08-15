# Cow Wisdom Web Server

## Prerequisites

To set up the environment, install the following packages:

```bash
sudo apt install fortune-mod cowsay -y
How to Use
Run the script with ./wisecow.sh.
Open your browser and navigate to the server port (default: 4499).
What to Expect


Problem Statement
Deploy the wisecow application as a Kubernetes (k8s) application.

Requirements
Create a Dockerfile for the image and the corresponding Kubernetes manifest to deploy in a k8s environment. The wisecow service should be exposed as a k8s service.
Set up a GitHub Action to build a new image when changes are made to this repository.
Expected Artifacts
A GitHub repository containing the application with the Dockerfile, k8s manifest, and any other necessary artifacts.
A GitHub repository with the corresponding GitHub Action configuration.
