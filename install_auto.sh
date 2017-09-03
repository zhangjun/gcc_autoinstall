#!/bin/bash

# by zhangjun9

# http://mirrors.ustc.edu.cn/gnu/gcc/

version=7.2.0
install_dir=/home/zhangjun9/install
source_dir=/home/zhangjun9/software/gcc-$version

# download prerequisites
./contrib/download_prerequisites

# install prerequisites, gmp -> mpfr -> mpc
# *****************gmp*********************
cd ${source_dir}/gmp
./configure --prefix=${install_dir}/gmp
make && make install
# *****************mpfr*********************
cd ${source_dir}/mpfr
./configure --prefix=${install_dir}/mpfr --with-gmp=${install_dir}/gmp
make && make install
# *****************gmp*********************
cd ${source_dir}/mpc
./configure --prefix=${install_dir}/mpc --with-gmp=${install_dir}/gmp --with-mpfr=${install_dir}/mpfr
make && make install


# *****************isl*********************
cd ${source_dir}/isl
./configure --prefix=${install_dir}/isl
make && make install


echo "" >> ~/.bashrc
echo "# gcc prerequisites" >> ~/.bashrc
echo -e "export PATH=${install_dir}/gmp/bin:${install_dir}/mpfr/bin:${install_dir}/mpc/bin:\$PATH" >> ~/.bashrc
echo -e "export LD_LIBRARY_PATH=${install_dir}/gmp/lib:${install_dir}/mpfr/lib:${install_dir}/mpc/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc


# install gcc 
mkdir ${source_dir}/build_tmp
cd ${source_dir}/build_tmp
#cd ${source_dir}
../configure --prefix=${install_dir}/gcc --with-gmp=${install_dir}/gmp/lib --with-mpfr=${install_dir}/mpfr/lib --with-mpc=${install_dir}/mpc/lib --disable-checking --disable-multilib --enable-language=c,c++


make -j4  # shorten make time
make install



echo "" >> ~/.bashrc
echo "# gcc env" >> ~/.bashrc
echo -e "export PATH=${install_dir}/gcc/bin:\$PATH" >> ~/.bashrc
echo -e "export LD_LIBRARY_PATH=${install_dir}/gcc/lib:\$LD_LIBRARY_PATH" >> ~/.bashrc
