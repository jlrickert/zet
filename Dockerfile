FROM python:alpine3.18

RUN apk upgrade --update-cache -a && \
    apk add --no-cache git git-fast-import openssh

RUN pip install mkdocs
RUN pip install mkdocs-meta-manager
RUN pip install markdown-checklist
RUN pip install mkdocs-material

RUN git config --global --add safe.directory /docs &&\
    git config --global --add safe.directory /site

WORKDIR /docs
EXPOSE 8000

ENTRYPOINT ["mkdocs"]