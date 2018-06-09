FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu14.04
MAINTAINER gonglinyuan

ENTRYPOINT ["/bin/bash", "-c"]

ENV LANG=C.UTF-8 LC_ALL=C.UTF-8
ENV PATH /opt/conda/bin:/opt/conda/envs/deep_learning/bin:$PATH

ADD https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh /tmp/
RUN /bin/bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /opt/conda
RUN rm /tmp/Miniconda3-latest-Linux-x86_64.sh

RUN /opt/conda/bin/conda update -y --all
RUN /opt/conda/bin/conda create -y --name deep_learning python numpy scipy scikit-learn pillow pandas h5py opencv matplotlib tqdm numba cython mkl
RUN /opt/conda/bin/conda update  -y -n deep_learning --all
RUN /opt/conda/bin/conda install -y -n deep_learning pytorch torchvision -c pytorch
RUN ["/bin/bash", "-c", "source activate deep_learning && python -m pip install --upgrade pip"]
RUN ["/bin/bash", "-c", "source activate deep_learning && pip install pretrainedmodels"]

CMD [ "source activate deep_learning && /bin/bash" ]
