FROM gcr.io/tensorflow/tensorflow:latest-gpu-py3

WORKDIR "/notebooks"

ADD requirements.txt /notebooks

RUN apt-get update && \
    apt-get install -y mecab \ 
		       libmecab-dev \
		       mecab-ipadic \
		       mecab-ipadic-utf8 \
    		       python-mecab && \
    apt-get clean

RUN python3 -m pip install -r requirements.txt
