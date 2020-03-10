FROM node:alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash tini wget tzdata python3 build-base python3-dev linux-headers freetype freetype-dev \
    && pip3 install --upgrade pip \
    && pip3 install jupyter pandas numpy beautifulsoup4 \
    && pip3 install regex requests matplotlib \
    && apk add --no-cache py3-scipy \
    && cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime \
    && echo "Europe/Amsterdam" > /etc/timezone \
    && apk del tzdata

# omitted
# pip3 install h5py ### the hdf5 (dev) package which this needs is not available in alpine

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["jupyter", "notebook", "--allow-root", "--port=8888", "--ip='*'", "--no-browser", "--notebook-dir=/mnt/jupyternb-vol"]

EXPOSE 8888
