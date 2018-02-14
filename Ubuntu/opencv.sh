#!/bin/bash


####################################

#########  install OpenCV  #########

####################################

function opencv_install(){



		#Upgrade any pre-installed packages
		sudo apt-get update

		#Install developer tools used to compile OpenCV 3.0
		sudo apt-get install -y build-essential cmake git pkg-config python3-dev python3-pip

		#Install libraries and packages used to read various image and videos formats from disk
		sudo apt-get install -y libjpeg8-dev libtiff4-dev libjasper-dev libpng12-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev

		#Install GTK so we can use OpenCV’s GUI features
		sudo apt-get install -y libgtk2.0-dev

		#Install packages that are used to optimize various functions inside OpenCV, such as matrix operations
		sudo apt-get install -y libatlas-base-dev gfortran

		#Install numpy
		pip3 install numpy

		#Build and install OpenCV 3.0 with Python 3.4+ bindings
		git clone https://github.com/Itseez/opencv.git
		cd opencv
		git checkout 3.0.0
		cd ..
		git clone https://github.com/Itseez/opencv_contrib.git
		cd opencv_contrib
		git checkout 3.0.0

		#To setup the build
		cd ../opencv
		mkdir build
		cd build
		cmake -D CMAKE_BUILD_TYPE=RELEASE \
		    -D CMAKE_INSTALL_PREFIX=/usr/local \
		    -D INSTALL_C_EXAMPLES=ON \
		    -D INSTALL_PYTHON_EXAMPLES=ON \
		    -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
		    -D BUILD_EXAMPLES=ON ..

		#start OpenCV compile process
		make -j4

		#install compiled OpenCV on the machine
		sudo make install
		sudo ldconfig
}

opencv_install
