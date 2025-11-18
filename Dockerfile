FROM amazoncorretto:11

RUN yum install -y \
    maven \
    curl \
    tar \
    gzip \
 && yum clean all

ENV YCSB_VERSION=0.17.0
RUN curl -L https://github.com/brianfrankcooper/YCSB/releases/download/${YCSB_VERSION}/ycsb-${YCSB_VERSION}.tar.gz \
    | tar -xz -C /opt \
 && mv /opt/ycsb-${YCSB_VERSION} /opt/ycsb

WORKDIR /opt/ycsb

ENV PATH="/opt/ycsb/bin:${PATH}"

ENTRYPOINT ["bash"]
