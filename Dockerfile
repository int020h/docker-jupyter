FROM node:alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash tini wget tzdata python3 build-base python3-dev linux-headers \
    && pip3 install --upgrade pip \
    && pip3 install jupyter \
    && cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime \
    && echo "Europe/Amsterdam" > /etc/timezone \
    && apk del tzdata

#CMD tail -f /dev/null

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["jupyter", "notebook", "--allow-root", "--port=8888", "--ip='*'", "--no-browser", "--notebook-dir=/mnt/jupyternb-vol"]

EXPOSE 8888
