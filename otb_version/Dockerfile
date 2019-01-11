FROM fronteo/fhcjupytertf:v0.3.5-mecab-neo 
MAINTAINER Wu Tong "tong.wu@fronteo-healthcare.com"
RUN pip install -r ./requirements.txt 
RUN groupadd -r otb && useradd -r -u 1000 -g otb otb
COPY jupyter_notebook_config.py /home/otb/.jupyter/
RUN chmod 777 -R /home/otb/
USER otb
CMD ["/run_jupyter.sh"]
