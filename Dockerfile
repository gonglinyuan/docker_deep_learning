FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu14.04
MAINTAINER gonglinyuan

ENTRYPOINT ["/bin/bash", "-c"]

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/envs/deep_learning/bin:/opt/conda/bin:$PATH

ADD https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh /tmp/
RUN /bin/bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
RUN rm /tmp/Miniconda3-latest-Linux-x86_64.sh

RUN /opt/conda/bin/conda create -y --name deep_learning python numpy pillow pandas mkl pyyaml \
    /opt/conda/bin/conda update  -y -n deep_learning --all \
    /opt/conda/bin/conda install -y -n deep_learning pytorch torchvision cuda80 -c pytorch
RUN python -m pip install --upgrade pip \
    python -m pip install pretrainedmodels

CMD [ "source activate deep_learning && /bin/bash" ]
