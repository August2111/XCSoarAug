# XCSoar Docker Image

This Docker Image when built, will compile XCSoar for several targets in a clean room environment.


## Currently Supported Targets

- UNIX (linux & co)
- ANDROID
- PC
- KOBO
- DOCS

## Instructions

The container itself is readonly. The build results will appear in `./output/`.

To build the container:
```
docker build \
    --file ide/docker/Dockerfile \
    -t xcsoar/xcsoar-build:latest ./ide/
```

To run the container interactivly:
```
docker run \
    --mount type=bind,source="$(pwd)",target=/opt/xcsoar \
    -it xcsoar/xcsoar-build:latest /bin/bash
```

To run the ANDROID build:
```
docker run \
    --mount type=bind,source="$(pwd)",target=/opt/xcsoar \
    -it xcsoar/xcsoar-build:latest xcsoar-compile ANDROID
```


aug:
Git for Linux:
git config --global core.autocrlf input
Git for Windows
git config --global core.autocrlf true

Docker-Build:
docker build --file ide/docker/Dockerfile -t xcsoar/xcsoar-build:latest ./ide/

Docker-Run:
docker run --mount type=bind,source="%CD%",target=/opt/xcsoar -it xcsoar/xcsoar-build:latest xcsoar-compile ANDROID
docker run --mount type=bind,source="%CD%",target=/opt/xcsoar -it xcsoar/xcsoar-build:latest /bin/bash

docker ps --all
docker container purge
docker system purge

LINUX es fehlt:
(sudo apt install libglm-dev)
apt-get install -y libglm-dev
apt-get install -y libglm-dev


Falsch: /opt/xcsoar/output/src/curl-7.64.1/configure CC=i686-w64-mingw32-Falsch: gcc CXX=i686-w64-mingw32-g++ CFLAGS=-Os -g -ffunction-sections -fdata-sections -fvisibility=hidden  -march=i586 -mwin32 -mwindows -mms-bitfields CXXFLAGS=-Os -g -ffunction-sections -fdata-sections -fvisibility=hidden  -march=i586 -mwin32 -mwindows -mms-bitfields CPPFLAGS=-isystem /opt/xcsoar/output/PC/lib/i686-w64-mingw32/root/include -DNDEBUG -I./output/PC/include -DWINVER=0x0600 -D_WIN32_WINDOWS=0x0600 -D_WIN32_WINNT=0x0600 -D_WIN32_IE=0x0600 -DWIN32_LEAN_AND_MEAN -DNOMINMAX -DHAVE_STRUCT_POLLFD -DHAVE_MSVCRT -DUNICODE -D_UNICODE -DSTRICT -isystem ./output/PC/lib/i686-w64-mingw32/root/include -DEYE_CANDY -DTESTING -DUSE_WIN32_RESOURCES   LDFLAGS=-L/opt/xcsoar/output/PC/lib/i686-w64-mingw32/root/lib -Wl,--major-subsystem-version=5 -Wl,--minor-subsystem-version=00 -Wl,-subsystem,console -static-libstdc++ -static-libgcc  LIBS=  AR=i686-w64-mingw32-ar ARFLAGS=rcs RANLIB=i686-w64-mingw32-ranlib STRIP=i686-w64-mingw32-strip --host=i686-w64-mingw32 --prefix=/opt/xcsoar/output/PC/lib/i686-w64-mingw32/root --enable-silent-rules --disable-shared --enable-static --disable-debug --enable-http --enable-ipv6 --enable-ftp --disable-file --disable-ldap --disable-ldaps --disable-rtsp --disable-proxy --disable-dict --disable-telnet --disable-tftp --disable-pop3 --disable-imap --disable-smb --disable-smtp --disable-gopher --disable-manual --disable-threaded-resolver --disable-verbose --disable-sspi --disable-crypto-auth --disable-ntlm-wb --disable-tls-srp --disable-cookies --without-ssl --without-gnutls --without-nss --without-libssh2 --enable-pthreads=no

ANDROID
# ergänze in Zeile xx von android.mk
TARGET_CPPFLAGS += -I/usr/include -I/usr/include/x86_64-linux-gnu
# das erste wegen fwd.hpp, das zweite wegen "bits/libc-header-start.h"

apt-get install -y libc6-dev-i386