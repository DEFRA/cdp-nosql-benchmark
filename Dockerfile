FROM amazoncorretto:11

RUN yum install -y \
    git \
    curl \
    tar \
    gzip \
    python3 \
    bash \
 && yum clean all

RUN curl -L https://archive.apache.org/dist/maven/maven-3/3.9.4/binaries/apache-maven-3.9.4-bin.tar.gz \
    | tar -xz -C /opt/ \
 && ln -s /opt/apache-maven-3.9.4/bin/mvn /usr/bin/mvn
RUN mvn -v
RUN git clone https://github.com/mongodb-labs/YCSB.git /opt/YCSB

WORKDIR /opt/YCSB/ycsb-mongodb
RUN mvn -pl mongodb -am clean package -DskipTests
RUN mv /opt/YCSB/ycsb-mongodb /opt/ycsb

WORKDIR /opt/ycsb
ENV PATH="/opt/ycsb/bin:${PATH}"

COPY --chmod=755 entrypoint.sh /opt/entrypoint.sh

ENTRYPOINT ["/opt/entrypoint.sh"]
CMD ["bash"]
