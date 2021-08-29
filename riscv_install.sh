sudo yum update
sudo yum install binutils libtool texinfo gzip zip unzip patchutils curl git make cmake automake bison flex gperf grep sed gawk python bc
sudo yum groupinstall "Development Tools" "Development Libraries" #sudo yum install build-essential(?)
sudo yum install http://repo.okay.com.mx/centos/7/x86_64/release/okay-release-1-1.noarch.rpm #sudo yum install ninja-build
sudo yum install ninja-build
sudo yum install zlib-devel #sudo yum install zlib1g-dev
sudo yum install expat-devel #sudo yum install libexpat1-dev
sudo yum install libmpc-devel #sudo yum install libmpc-dev
sudo yum install glib2-devel #sudo yum install libglib2.0-dev
sudo yum install libfdt-devel #sudo yum install libfdt-dev
sudo yum install pixman-devel #sudo yum install libpixman-1-dev
sudo yum python3
mkdir riscv
cd riscv
export PATH=/opt/riscv/bin:$PATH #you can change /opt/riscv to the dir you want to install riscv
hash -r
git clone --recursive https://github.com/riscv/riscv-gnu-toolchain
pushd riscv-gnu-toolchain
./configure --prefix=/opt/riscv --enable-multilib #you can change /opt/riscv to the dir you want to install riscv
make -j`nproc`
popd
git clone https://github.com/llvm/llvm-project.git riscv-llvm
pushd riscv-llvm/
ln -s ../../clang llvm/tools || true
mkdir _build
cd _build
sudo yum install cmake3
sudo yum install centos-release-scl
sudo yum install devtoolset-7-gcc*
scl enable devtoolset-7 bash

export CC="你的 gcc 7 路徑" #which gcc 就可以看到 gcc 7 路徑了
export CXX="你的 g++ 7 路徑" #which g++ 就可以看到 g++ 7 路徑了

#you can change /opt/llvm to the path you want to install llvm
sudo cmake3 -G Ninja -DCMAKE_BUILD_TYPE="Release" \
-DBUILD_SHARED_LIBS=True -DLLVM_USE_SPLIT_DWARF=True \
-DCMAKE_INSTALL_PREFIX="/opt/llvm" \
-DLLVM_OPTIMIZED_TABLEGEN=True -DLLVM_BUILD_TESTS=False \
-DDEFAULT_SYSROOT="/opt/llvm/riscv64-unknown-elf" \
-DLLVM_DEFAULT_TARGET_TRIPLE="riscv64-unknown-elf" \
-DLLVM_TARGETS_TO_BUILD="RISCV" \
../llvm

sudo cmake --build . --target install
popd
