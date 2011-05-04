export NDK=/home/jer/Projet_android/android-ndk-r5
export TOOLCHAIN=/home/jer/standalone-toolchain
export AOSP=/home/jer/cm7
export PRODUCT=vision
export PATH=$TOOLCHAIN/bin/:$PATH

export CC=arm-linux-androideabi-gcc
export CXX=arm-linux-androideabi-g++
export CFLAGS="-march=armv7-a -mfloat-abi=softfp -I$AOSP/external/openssl/include"
export CPPFLAGS=$CFLAGS
export LDFLAGS="-Wl,--fix-cortex-a8 -lsupc++ -L$AOSP/out/target/product/$PRODUCT/system/lib"
export LIBS="$TOOLCHAIN/arm-linux-androideabi/lib/libstdc++.a"

#rm -rf $TOOLCHAIN
#$NDK/build/tools/make-standalone-toolchain.sh --platform=android-9 --install-dir=$TOOLCHAIN

cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DHAVE_POLL=1 -DHAVE_GETADDRINFO=1 -DCMAKE_LINK_LIBRARY_FILE_FLAG=$TOOLCHAIN/arm-linux-androideabi/lib/libstdc++.a -DCMAKE_INSTALL_PREFIX=$AOSP/out/target/product/$PRODUCT/obj ..
sed -i 's/-Wl,-soname,libssh.so.4/-Wl,-soname,libssh.so/' src/CMakeFiles/ssh_shared.dir/link.txt
make -j2 # VERBOSE=1
arm-linux-androideabi-strip src/libssh.so
make -j2 install # VERBOSE=1
