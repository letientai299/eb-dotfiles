# the image on dockerhub does not come with the ec2-user and other stuff that
# we have on aws. Hence, we will use this file to prepare a playround env.
FROM amazonlinux:2
RUN yum update -y

# install other linux tools to make the env similar to the one on the cloud
RUN yum groupinstall -y Base

# Add ec2-user
RUN adduser ec2-user

# Alow ec2-user execute sudo command without password
RUN echo 'ec2-user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# change default user
USER ec2-user
WORKDIR /home/ec2-user

