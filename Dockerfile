FROM nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04

#images info
LABEL version="1.0"
LABEL  description='base on nvidia/cuda:11.8.0-cudnn8-runtime-ubuntu22.04'



#安装miniconda && ssh
RUN apt-get update && apt-get install openssh-server -y
RUN cd /home  && set -e 
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-py38_4.12.0-Linux-x86_64.sh  -O ~/miniconda.sh
RUN bash ~/miniconda.sh -b -p $HOME/miniconda 
RUN ~/miniconda/bin/conda init $(echo $SHELL | awk -F '/' '{print $NF}') 
RUN echo 'Successfully installed miniconda...' && echo -n 'Conda version: ' 
RUN ~/miniconda/bin/conda --version && echo -e '\n' 
RUN exec bash


#复制本地template下的文件到目标根目录
ADD . /home/uework

#设置工作目录
WORKDIR "/home/uework"

ENV path="/home/miniconda3/bin;/home/miniconda3/condabin"

#创建角色
RUN useradd -d uework -G 0 uework

#登录后默认角色
USER uework
