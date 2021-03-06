FROM huanghw/pyltp:py37 as ltp

FROM python:3.7-stretch

# pyltp
RUN mkdir -p /opt/pyltp
COPY --from=ltp /fs/pyltp-*.whl /opt/pyltp/
RUN cd /opt/pyltp && \
    ls | egrep "pyltp-.*\.whl" | xargs -i pip install {} && \
    rm -rf /opt/pyltp