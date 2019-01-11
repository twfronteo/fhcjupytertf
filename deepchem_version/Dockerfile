FROM fronteo/fhcjupytertf:v0.5.5.1-1.7.1

WORKDIR "/notebooks"

ADD requirements.txt /notebooks
RUN python3 -m pip install --upgrade setuptools pip
RUN python3 -m pip install -r requirements.txt
