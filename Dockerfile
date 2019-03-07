FROM tensorflow/tensorflow:2.0.0a0-gpu-py3-jupyter

WORKDIR "/notebooks"

ADD requirements.txt /notebooks

RUN chown root:root /tmp && \
    chmod 1777 /tmp && \
    apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-dev \
                       wget \
                       libboost-all-dev \
                       mecab \ 
                       libmecab-dev \
                       mecab-ipadic \
                       mecab-ipadic-utf8 \
                       python-mecab \
                       cmake \
                       check \
                       cython \
                       python3-tk \
                       git && \
    apt-get clean

ENV LANG C.UTF-8
RUN python3 -m pip install --upgrade setuptools pip
RUN python3 -m pip install -r requirements.txt

RUN mkdir /tmp/pubmed_parser && \
    cd /tmp/pubmed_parser && \
    git clone https://github.com/titipata/pubmed_parser && \
    cd pubmed_parser && \
    python3 -m pip install -r requirements.txt && \
    python3 setup.py install

RUN mkdir /tmp/mecab-ipadic-neologd && \
    cd /tmp/mecab-ipadic-neologd && \
    git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd && \
    echo 'yes' | ./bin/install-mecab-ipadic-neologd -u -n

ADD fonts/. /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/fonts/ttf/

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/
