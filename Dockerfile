# golang-builder
FROM openshift/base-centos7

# TODO: Put the maintainer name in the image metadata
LABEL maintainer="Yoël Cornamusaz <yoel.cornamusaz@gmail.com>"

# TODO: Rename the builder environment variable to inform users about application you provide them
# ENV BUILDER_VERSION 1.0

# TODO: Set labels used in OpenShift to describe the builder image
#LABEL io.k8s.description="Platform for building xyz" \
#      io.k8s.display-name="builder x.y.z" \
#      io.openshift.expose-services="8080:http" \
#      io.openshift.tags="builder,x.y.z,etc."

# TODO: Install required packages here:
# RUN yum install -y ... && yum clean all -y
#RUN yum install -y rubygems && yum clean all -y
RUN curl -O https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz 
RUN tar -C /usr/local -xzf go*.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"
RUN mkdir "/opt/app-root/go"
ENV GOPATH="/opt/app-root/go" 
ENV GOBIN=$GOPATH/bin

# TODO (optional): Copy the builder files into /opt/app-root
COPY ./ /opt/app-root/src

# TODO: Copy the S2I scripts to /usr/libexec/s2i, since openshift/base-centos7 image
# sets io.openshift.s2i.scripts-url label that way, or update that label
COPY ./s2i/bin/ /usr/libexec/s2i

# TODO: Drop the root user and make the content of /opt/app-root owned by user 1001
RUN chown -R 1001:1001 /opt/app-root

# This default user is created in the openshift/base-centos7 image
USER 1001

# TODO: Set the default port for applications built using this image
# EXPOSE 8080

# TODO: Set the default CMD for the image
# CMD ["/usr/libexec/s2i/usage"]
