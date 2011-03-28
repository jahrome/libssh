export PATH=$PATH:/home/jer/Projet_android/android-ndk-r5/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/
cd build
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_TOOLCHAIN_FILE=../Android.cmake -DHAVE_POLL=1 -DHAVE_GETADDRINFO=1  ..
make
arm-linux-androideabi-strip src/libssh.so
