FROM python:3.6-stretch as build

# pyltp build-env
RUN apt-get update && \
    apt-get install -y git && \
    apt-get install -y cmake g++

# pyltp
RUN mkdir /install && \
    git clone https://github.com/HIT-SCIR/pyltp.git && \
    cd pyltp && git checkout tags/0.2.0 -b build && git submodule init && git submodule update && \
    python setup.py install

# pack
RUN mkdir -p /fs && \
    cd /usr/local/lib/python3.6/site-packages && \
    ls | egrep "pyltp-.*\.egg" | xargs -i wheel convert {} && \
    mv -f pyltp-*.whl /fs/

FROM alpine

RUN mkdir -p /fs
COPY --from=build /fs/pyltp-*.whl /fs/

RUN cd /fs/ && \
    mv pyltp-*.whl pyltp-0.2.0-py3-none-any.whl
