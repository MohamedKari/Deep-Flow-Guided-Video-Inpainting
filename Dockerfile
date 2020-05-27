FROM pytorch/pytorch:0.4-cuda9-cudnn7-devel

WORKDIR /app

RUN apt-get -y update && apt-get -y install \
        libglib2.0-0 \
        libsm6 \
        libxrender-dev \
        libxext6

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY . .

COPY install.sh install.sh
RUN bash install.sh

ENTRYPOINT [ "python", "demo_vi.py" ]
