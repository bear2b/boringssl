
ANDROID_NDK=~/android-ndk-r16
: ${ANDROID_NDK?"Need to set NDK to android-ndk path"}
mkdir build
cd build
cmake -DANDROID_ABI=armeabi-v7a \
          -DCMAKE_TOOLCHAIN_FILE=${ANDROID_NDK}/build/cmake/android.toolchain.cmake \
          -DANDROID_NATIVE_API_LEVEL=16 \
          -BUILD_SHARED_LIBS \
          -GNinja ..
ninja
mkdir dist
cd dist
mkdir libs
cd ..
cp ./ssl/libssl.a ./dist/libs/libssl.a
cp ./crypto/libcrypto.a ./dist/libs/libcrypto.a
AR_BIN=${ANDROID_NDK}/toolchains/arm-linux-androideabi-4.9/prebuilt/darwin-x86_64/bin/arm-linux-androideabi-ar
cd dist
cd libs
${AR_BIN} -x libssl.a
${AR_BIN} -x libcrypto.a
rm libssl.a
rm libcrypto.a
${AR_BIN} rc libssl.a *.o
rm *.o
