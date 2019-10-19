FROM nvcr.io/nvidia/pytorch:19.09-py3

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y libmecab-dev && \
    pip install virtualenv gensim numpy scipy matplotlib seaborn sklearn zenhan Pillow ipython[all] jupyter pandas tqdm jupyterlab optuna && \
    jupyter serverextension enable --py jupyterlab --sys-prefix && \
    pip install -U torch && \ 
    pip install -U spacy spacy-lookups-data && \
    python -m spacy download en_core_web_sm && \
    rm -rf /var/lib/apt/lists/
RUN git clone https://github.com/taku910/mecab.git && \
    cd mecab/mecab && \
    ./configure --with-charset=utf8 && \
    make && \
    make check && \
    make install && \
    ldconfig && \
    cd ../mecab-ipadic && \
    ./configure --with-charset=utf8 && \
    make && \
    make install && \
    cd ../../ && \
    git clone --depth 1 https://github.com/neologd/mecab-ipadic-neologd.git && \
    cd mecab-ipadic-neologd && \
    echo "yes" | ./bin/install-mecab-ipadic-neologd -n -a && \
    cd ../ && \
    pip install mecab-python3 && \
    rm -rf mecab && \
    rm -rf mecab-ipadic-neologd
