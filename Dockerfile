FROM node:alpine

RUN apk update \
    && apk upgrade \
    && apk add --no-cache bash tini wget tzdata python3 build-base python3-dev linux-headers freetype freetype-dev py3-scipy \
    && pip3 install --upgrade pip \
    && pip3 install jupyter pandas numpy beautifulsoup4 \
    && pip3 install regex requests matplotlib \
    && cp /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime \
    && echo "Europe/Amsterdam" > /etc/timezone \
    && apk del tzdata

# maybe we can skip numpy installation using pip3 as it is already installed as a dependency for py3-scipy

# omitted
# pip3 install h5py ### the hdf5 (dev) package which this needs is not available in alpine

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["jupyter", "notebook", "--allow-root", "--port=8888", "--ip='*'", "--no-browser", "--notebook-dir=/mnt/jupyternb-vol"]

EXPOSE 8888
