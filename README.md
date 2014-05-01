docker-drupal
=============

Run Drupal in Docker! This project contains a Dockerfile that will build a LAMP stack and configure a Drupal installation in it. It uses the phusion baseimage, which is a variant of Ubuntu designed to run in Docker.

Note: this image is meant to be used for development, so it doesn't download the Drupal codebase for you. Instead, you should mount the codebase at /var/www/ when running Docker.

To use, install Docker following the instructions at docker.io. Be sure to add your user to the docker group, so you can run these commands without sudo.

Then, change to the project directory and build the image:
```
docker build -t trellon/ableorganizer .
```

Finally, run the container:
```
docker run -d -P -v /path/to/drupal/root/on/host:/var/www:rw yourname/drupal
```
