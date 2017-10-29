FROM openshift/base-centos7

MAINTAINER John Wass <jwass3@gmail.com>

ARG SBT_VERSION
ARG SCALA_VERSION

ENV SBT_S2I_BUILDER_VERSION=0.1
ENV IVY_DIR=/opt/app-root/src/.ivy2
ENV SBT_DIR=/opt/app-root/src/.sbt

LABEL io.k8s.display-name="sbt-s2i $SBT_S2I_BUILDER_VERSION" \
      io.k8s.description="S2I Builder with cached SBT $SBT_VERSION and Scala $SCALA_VERSION" \
      io.openshift.expose-services="9000:http" \
      io.openshift.tags="builder,sbt,scala" \
      io.openshift.min-memory="1Gi"

USER root

RUN INSTALL_PKGS="nano curl net-tools tar unzip which lsof java-1.8.0-openjdk java-1.8.0-openjdk-devel sbt-$SBT_VERSION" \
 && curl -s https://bintray.com/sbt/rpm/rpm > bintray-sbt-rpm.repo \
 && mv bintray-sbt-rpm.repo /etc/yum.repos.d/ \
 && yum install -y --enablerepo=centosplus $INSTALL_PKGS \
 && rpm -V $INSTALL_PKGS \
 && yum clean all -y

COPY plugins.sbt /tmp

RUN mkdir -p /tmp/caching/project \
 && cd /tmp/caching \
 && echo "sbt.version = $SBT_VERSION" > project/build.properties \
 && echo "scalaVersion := \"$SCALA_VERSION\"" > build.sbt \
 && mv /tmp/plugins.sbt project \
 && sbt -v -sbt-dir $SBT_DIR -sbt-boot $SBT_DIR/boot -ivy $IVY_DIR compile \
 && chown -R 1001:0 /opt/app-root \
 && chmod -R g+rw /opt/app-root \
 && rm -rf /tmp/*

COPY ./s2i/bin/ /usr/libexec/s2i

USER 1001
EXPOSE 9000

CMD ["/usr/libexec/s2i/usage"]
