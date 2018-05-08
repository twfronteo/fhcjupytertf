FROM tensorflow/tensorflow:1.8.0-gpu-py3

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
RUN python3 -m pip install -r requirements.txt && \
    python3 -m pip install --no-cache-dir spacy && \
    python3 -m spacy download en_core_web_md && \
    python3 -m nltk.downloader all

RUN mkdir /tmp/forjumanpp && \
    cd /tmp/forjumanpp && \
    wget http://lotus.kuee.kyoto-u.ac.jp/nl-resource/jumanpp/jumanpp-1.02.tar.xz && \
    tar xJvf jumanpp-1.02.tar.xz && \
    cd jumanpp-1.02 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    wget http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/juman/juman-7.01.tar.bz2 && \
    tar jxvf juman-7.01.tar.bz2 && \
    cd juman-7.01 && \
    ./configure && \
    make && \
    make install && \
    echo "include /usr/local/lib" >> /etc/ld.so.conf && \
    ldconfig && \
    cd .. && \
    wget http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/knp-4.19.tar.bz2 && \
    tar jxvf knp-4.19.tar.bz2 && \
    cd knp-4.19 && \
    ./configure && \
    make && \
    make install && \
    cd .. && \
    wget http://nlp.ist.i.kyoto-u.ac.jp/nl-resource/knp/pyknp-0.3.tar.gz && \
    tar xvf pyknp-0.3.tar.gz && \
    cd pyknp-0.3 && \
    python3 setup.py install && \
    rm -rf /tmp/forjumanpp

RUN mkdir /tmp/pygpu && \
    cd /tmp/pygpu && \
    git clone https://github.com/Theano/libgpuarray.git && \
    cd libgpuarray && \
    mkdir Build && \
    cd Build && \
    cmake .. -DCMAKE_BUILD_TYPE=Release && \
    make && \
    make install && \
    cd .. && \
    python3 setup.py build && \
    python3 setup.py install && \
    ldconfig && \
    rm -rf /tmp/pygpu

RUN mkdir /tmp/pubmed_parser && \
    cd /tmp/pubmed_parser && \
    git clone https://github.com/titipata/pubmed_parser && \
    cd pubmed_parser && \
    python3 -m pip install -r requirements.txt && \
    python3 setup.py install

RUN echo "\n[global]\nfloatX=float32\ndevice=cuda0\n\n[lib]\ncnmem=0.95\n" >> /root/.theanorc

ADD fonts/. /usr/local/lib/python3.5/dist-packages/matplotlib/mpl-data/fonts/ttf/

# Set up our notebook config.
COPY jupyter_notebook_config.py /root/.jupyter/
