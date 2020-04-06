# google-cloud-sdk-docker

[![Build Status](https://travis-ci.com/0hlov3/google-cloud-sdk-docker.svg?branch=master)](https://travis-ci.com/0hlov3/google-cloud-sdk-docker)

This is Docker image for the [Google Cloud SDK](https://cloud.google.com/sdk/) and [Terraform](https://www.terraform.io/docs/providers/google/index.html).

The :latest tag of this image is Alpine-based and includes default command line tools of Google Cloud SDK (gcloud, gsutil, bq) as well as all [additional components](https://cloud.google.com/sdk/downloads#apt-get) and Terraform.

## Usage

To use this image, pull from Container Registry and then run the following command:

```
docker pull 0hlov3s/google-sdk-terraform-alpine
```

Verify the install

```
docker run 0hlov3s/google-sdk-terraform-alpine gcloud version
```

### Authentication

You can Autheticate by running:

```
docker run -ti --name gcloud-config 0hlov3s/google-sdk-terraform-alpine gcloud auth login
```
Once you authenticate successfully, credentials are preserved in the volume of the gcloud-config container.
But since we want to user terraform, we will mount the key.json to /work/.creds
```
docker run -v key.json:/work/.creds 0hlov3s/google-sdk-terraform-alpine
```

### Terraform Usage

A full terraform plan or apply will be done by:
```
docker run -v key.json:/work/.creds -v terraform-folder:/work 0hlov3s/google-sdk-terraform-alpine terraform plan
```
