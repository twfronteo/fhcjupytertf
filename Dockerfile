FROM gcr.io/tensorflow/tensorflow:latest-gpu-py3

WORKDIR "/notebooks"

ADD requirements.txt /notebooks

RUN apt-get update && \
    apt-get upgrade -y && \
    apt-get install -y python-dev \
                       mecab \ 
		       libmecab-dev \
		       mecab-ipadic \
		       mecab-ipadic-utf8 \
    		       python-mecab && \
    apt-get clean

ENV LANG C.UTF-8
RUN python3 -m pip install -r requirements.txt
RUN python3 -m spacy download en
RUN python3 -m spacy download en_core_web_md
RUN python3 -m nltk.downloader all
