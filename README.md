# google-cloud-sdk-docker

[![Build Status](https://travis-ci.com/0h-lov3s/google-cloud-sdk-docker.svg)](https://travis-ci.com/0h-lov3s/google-cloud-sdk-docker)

This is Docker image for the [Google Cloud SDK](https://cloud.google.com/sdk/) and [Terraform](https://www.terraform.io/docs/providers/google/index.html).

The :latest tag of this image is Debian-based and includes default command line tools of Google Cloud SDK (gcloud, gsutil, bq) as well as all [additional components](https://cloud.google.com/sdk/downloads#apt-get) and Terraform.

## Usage

To use this image, pull from Container Registry and then run the following command:

```
docker pull customer-cloud-docker-general.psmanaged.com/plusserver/gcp-dev:master
```

Verify the install

```
docker run customer-cloud-docker-general.psmanaged.com/plusserver/gcp-dev:master gcloud version
```

### Authentication

You can Autheticate by running:

```
docker run -ti --name gcloud-config customer-cloud-docker-general.psmanaged.com/plusserver/gcp-dev:master gcloud auth login
```
Once you authenticate successfully, credentials are preserved in the volume of the gcloud-config container.
But since we want to user terraform, we will mount the key.json to /work/.creds
```
docker run -v key.json:/work/.creds customer-cloud-docker-general.psmanaged.com/plusserver/gcp-dev:master
```

### Terraform Usage

A full terraform plan or apply will be done by:
```
docker run -v key.json:/work/.creds -v terraform-folder:/work customer-cloud-docker-general.psmanaged.com/plusserver/gcp-dev:master terraform plan
```
