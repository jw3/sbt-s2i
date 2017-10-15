FROM registry.access.redhat.com/redhat-openjdk-18/openjdk18-openshift

MAINTAINER John Wass <jwass3@gmail.com>

ARG SBT_VERSION
ARG SCALA_VERSION

ENV SBT_S2I_BUILDER_VERSION 0.1

LABEL io.k8s.display-name="sbt-s2i $SBT_S2I_BUILDER_VERSION" \
      io.k8s.description="sbt:$SBT_VERSION,scala:$SCALA_VERSION" \
      io.openshift.expose-services="9000:http" \
      io.openshift.tags="builder,sbt,scala" \
      io.openshift.min-memory="512Mi"

USER root

RUN curl -s https://bintray.com/sbt/rpm/rpm > bintray-sbt-rpm.repo \
 && mv bintray-sbt-rpm.repo /etc/yum.repos.d/ \
 && yum install -y sbt-$SBT_VERSION \
 && yum clean all -y

RUN sbt -ivy /opt/app-root/src/.ivy2 \
 && chown -R 1001:1001 /opt/app-root \
 && chmod -R g+rw /opt/app-root

COPY ./s2i/bin/ /usr/libexec/s2i

USER 1001
EXPOSE 9000

CMD ["/usr/libexec/s2i/usage"]
