FROM tensorflow/tensorflow:2.2.0rc3-gpu-py3-jupyter

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

RUN pip uninstall umap-learn -y
RUN pip uninstall llvmlite -y
RUN pip install llvmlite==0.30.0 
RUN wget https://github.com/lmcinnes/umap/archive/master.zip
RUN unzip master.zip
RUN rm master.zip
RUN cd umap-master && python3 -m pip install -r requirements.txt && python3 setup.py install

RUN pip install modin[all]
ENV MODIN_ENGINE=ray

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/
