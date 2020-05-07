ARCH=61 #Tesla P4
ARCH=37 #Tesla K80

show-nvcc-version:
	nvcc --version

show-gpu-info:
	echo "info might be incorrect after installing a new cuda version"
	nvidia-smi

install-cuda-v9.0:
	echo "might install cuda v9.1, but that version also works"
	curl "http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/cuda-repo-ubuntu1704_9.0.176-1_amd64.deb" -o cuda-repo-ubuntu1704_9.0.176-1_amd64.deb
	sudo dpkg -i cuda-repo-ubuntu1704_9.0.176-1_amd64.deb
	sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1704/x86_64/7fa2af80.pub
	sudo apt-get update
	sudo apt-get install cuda

install-gcc-v6.5:
	sudo apt-get update && \
	sudo apt-get install build-essential software-properties-common -y && \
	sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
	sudo apt-get update && \
	sudo apt-get install gcc-6 g++-6 -y && \
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-6 60 --slave /usr/bin/g++ g++ /usr/bin/g++-6 && \
	gcc -v

compile-flownet:
	bash install_scripts.sh $(ARCH)

install-on-colab-part1:
	pip install -r requirements.txt
	echo "restart your runtime"

install-on-colab-after-restart: show-nvcc-version show-gpu-info install-cuda-v9.0 install-gcc-v6.5 compile-flownet

dir=./demo/masks
convert-jpg-masks-to-3-channel-pngs:
	echo "Requires mogrify. On MacOS, use 'brew install imagemagick' to install it if you don't have it yet." 
	mogrify -define png:format=png24 $(dir)/*.jpgs

run-demo:
	python tools/video_inpaint.py --frame_dir ./demo/frames --MASK_ROOT ./demo/masks --img_size 256 384 --FlowNet2 --DFC --ResNet101 --Propagation 