# testnetcoredocker
example dotnetcore with docker

About Dockerfile
dockerfile             ==> for build Docker with multiple project.
TestDocker/dockerfile  ==> for build Docker with a single project.

# Command #
on parent
# 1 #
>docker build -t <image_name_you_need> .
# 2 #
>docker run -p 8080:80 --name <container_name_you_need> <image_name_you_need>


