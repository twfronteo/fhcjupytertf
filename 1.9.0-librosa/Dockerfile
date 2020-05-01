FROM fronteo/fhcjupytertf:v0.5.5-1.9.0

WORKDIR "/notebooks"

RUN python3 -m pip install librosa praat-parselmouth hmmlearn simplejson eyed3 pydub 
RUN mkdir /tmp/pyAudioAnalysis && \
    cd /tmp/pyAudioAnalysis && \
    git clone https://github.com/tyiannak/pyAudioAnalysis.git && \
    cd pyAudioAnalysis && \
    python3 -m pip install -e .
