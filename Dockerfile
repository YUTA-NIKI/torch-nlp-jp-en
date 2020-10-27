FROM nvcr.io/nvidia/pytorch:20.10-py3

RUN apt update -y && \
    apt upgrade -y && \
    apt install -y libmecab-dev && \
    apt install -y cmake build-essential pkg-config libgoogle-perftools-dev && \
    pip install virtualenv numpy scipy matplotlib seaborn sklearn zenhan Pillow ipython[all] jupyter pandas tqdm jupyterlab gensim optuna && \
    jupyter serverextension enable --py jupyterlab --sys-prefix && \
    pip install -U torch && \ 
    pip install -U spacy spacy-lookups-data && \
    python -m spacy download en_core_web_sm && \
    pip install transformers && \
    rm -rf /var/lib/apt/lists/
RUN pip install sentencepiece && \
    git clone https://github.com/google/sentencepiece.git && \
    cd sentencepiece && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j $(nproc) && \
    make install && \
    ldconfig -v && \
    cd ../.. && \
    rm -rf sentencepiece
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
