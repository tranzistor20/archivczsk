#!/bin/sh

get_platform ()
{
local platform=$(uname -m)

if [ "$platform" == "sh4" ]
then
	platform="sh4"
else
	platform="mipsel"
fi
echo $platform
}

get_oe ()
{
if [ -f /lib/libcrypto.so.1.0.0 ]
then
	oe="OE40"
else
	oe="OE16-30"
fi
echo  $oe
}

SH4_V="0.1"
MIPS_V="0.1"
SH4="http://dl.bintray.com/mx3l/generic/sh4_$SH4_V.tar.gz"
MIPS="http://dl.bintray.com/mx3l/generic/mipsel_$MIPS_V.tar.gz"

PLATFORM=$(get_platform)
OE=$(get_oe)

LIBDIR="/usr/lib"
BINDIR="/usr/bin"
GSTDIR="$LIBDIR/gstreamer-0.10/"

mkdir -p /tmp/
wget -O /tmp/$MIPS
tar -xzf /tmp/mipsel_$MIPS_V.tar.gz

if [ "$OE" == "OE40" ]; then
	cp /tmp/mipsel/gst_rtmp_plugin/OE40/libgstrtmp.so $GSTDIR
	cp /tmp/mipsel/rtmpdump/OE40_KSV/librtmp.so.1 $LIBDIR	
	cp /tmp/mipsel/rtmpdump/OE40_KSV/rtmpdump $BINDIR
	cp /tmp/mipsel/rtmpdump/OE40_KSV/rtmpgw $BINDIR

else
	cp /tmp/mipsel/gst_rtmp_plugin/OE16-3/libgstrtmp.so $GSTDIR
	cp /tmp/mipsel/rtmpdump/OE16-3/librtmp.so.1 $LIBDIR	
	cp /tmp/mipsel/rtmpdump/OE16-3/rtmpdump $BINDIR
	cp /tmp/mipsel/rtmpdump/OE16-3/rtmpgw $BINDIR
	
echo "RTMP plugin pre archivCZSK"

chmod 755 $LIBDIR/librtmp*
chmod 755 $GSTDIR/libgstrtmp.so
chmod 755 $BINDIR/rtmp*

rm -rf /tmp/mipsel
rm /tmp/mipsel_$MIPS_V.tar.gz

echo "RTMP plugin bol uspesne nainstalovany"
exit 0
