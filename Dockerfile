FROM ubuntu:22.04

# Python3.10
ENV DEBIAN_FRONTEND=noninteractive 
RUN apt-get update
RUN apt-get install -y software-properties-common && \  
    add-apt-repository ppa:deadsnakes/ppa && \  
    apt-get update && \  
    apt-get install -y python3.10
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# pip3
RUN apt-get install -y python3-pip 

WORKDIR /home/ubuntu

VOLUME ["/FILES"]

COPY ./exe/ /home/ubuntu/exchange/
COPY ./pystrategy-1.0.1-py3-none-any.whl /home/ubuntu/pystrategy-1.0.1-py3-none-any.whl

RUN pip3 install /home/ubuntu/pystrategy-1.0.1-py3-none-any.whl

CMD [ "bash", "-c", "\
    nohup ./exchange/bybit -r /FILES/Bybit & \
    wait \
" ]