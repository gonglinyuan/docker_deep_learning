FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu14.04
MAINTAINER gonglinyuan

ENTRYPOINT ["/bin/bash", "-c"]

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:/opt/conda/envs/deep_learning/bin:$PATH

ADD https://mirrors.tuna.tsinghua.edu.cn/anaconda/archive/Anaconda3-5.2.0-Linux-x86_64.sh /tmp/
RUN /bin/bash /tmp/Anaconda3-5.2.0-Linux-x86_64.sh -b -p /opt/conda
RUN rm /tmp/Anaconda3-5.2.0-Linux-x86_64.sh

RUN /opt/conda/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free/
RUN /opt/conda/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main/
RUN /opt/conda/bin/conda config --set show_channel_urls yes
RUN /opt/conda/bin/conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch/

RUN /opt/conda/bin/conda update -y --all
RUN /opt/conda/bin/conda create -y --name deep_learning pillow numpy scipy scikit-learn pandas h5py opencv matplotlib tqdm numba cython mkl
RUN /opt/conda/bin/conda update  -y -n deep_learning --all
RUN /opt/conda/bin/conda install -y -n deep_learning pytorch torchvision -c pytorch
RUN ["/bin/bash", "-c", "source activate deep_learning && python -m pip install --upgrade pip"]
RUN ["/bin/bash", "-c", "source activate deep_learning && pip install pretrainedmodels"]

CMD [ "source activate deep_learning && /bin/bash" ]
