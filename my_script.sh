#!/bin/sh

echo "Hello World!"

tar -zxvf mb2_video.tgz
cd mediabench2_video/

#for cjpeg
cd ./cjpeg
tar -zxvf jpegsrc.v6b.tar.gz
cd ./jpeg-6b/
./configure
make
cd ../oprofile_results/
rm cjpeg
ln -s ../jpeg-6b/cjpeg cjpeg

#for djpeg
cd ../../djpeg/
tar -zxvf jpegsrc.v6b.tar.gz
cd ./jpeg-6b/
./configure
make
cd ../oprofile_results/
rm djpeg
ln -s ../jpeg-6b/djpeg djpeg

#for h263dec
cd ../../h263dec/
tar -zxvf tmndec-1.7.tar.gz
cd ./tmndec-1.7/
make 
cd ../oprofile_results/
rm ./h263dec
ln -s ../tmndec-1.7/tmndec ./h263dec

#for h263dec
cd ../../h263enc/
tar -zxvf tmn-1.7.tar.gz
cd ./tmn-1.7/
make 
cd ../oprofile_results/
rm ./h263dec
ln -s ../tmndec-1.7/tmndec ./h263dec

#for h264dec
cd ../../h264dec/
unzip ./jm10.2.zip
cd ./JM/
sh ./unixprep.sh
cd ./ldecod/
make
cd ../../oprofile_results/
rm ./h264dec
ln -s ../JM/bin/ldecod.exe ./h264dec

#for h264enc
cd ../../h264enc/
unzip ./jm10.2.zip
cd ./JM/
sh ./unixprep.sh
cd ./lencod/
make
cd ../../oprofile_results/
rm ./h264enc
ln -s ../JM/bin/lencod.exe ./h264enc

#for jpg2000dec
cd ../../jpg2000dec/
unzip jasper-1.701.0.zip
cd jasper-1.701.0
./configure
make
cd ../oprofile_results/
rm ./jpg2000dec
ln -s ../jasper-1.701.0/src/appl/jasper ./jpg2000dec

#for jpg2000enc
cd ../../jpg2000enc/
unzip ./jasper-1.701.0.zip
cd ./jasper-1.701.0/
./configure
make
cd ../oprofile_results/
rm ./jpg2000enc
ln -s ../jasper-1.701.0/src/appl/jasper ./jpg2000enc

#for mpeg2dec
cd ../../mpeg2dec
tar -zxvf mpeg2vidcodec_v12.tar.gz
cd ./mpeg2/
make
cd ../oprofile_results/ 
rm mpeg2dec
ln -s ../mpeg2/src/mpeg2dec/mpeg2decode ./mpeg2dec

#for mpeg2dec
cd ../../mpeg2enc
tar -zxvf mpeg2vidcodec_v12.tar.gz
cd ./mpeg2/
make
cd ../oprofile_results/ 
rm mpeg2enc
ln -s ../mpeg2/src/mpeg2enc/mpeg2encode ./mpeg2enc

#for mpeg4dec
cd ../../mpeg4dec/
tar -zxvf ffmpeg.2006_04_24.tgz
cd ./ffmpeg
./configure --disable-strip
make
cd ../oprofile_results/ 
rm mpeg4dec.with_mmx
ln -s ../ffmpeg/ffmpeg ./mpeg4dec.with_mmx

#for mpeg4enc
cd ../../mpeg4enc/
tar -zxvf ffmpeg.2006_04_24.tgz
cd ./ffmpeg
./configure --disable-strip
make
cd ../oprofile_results/ 
rm mpeg4enc.with_mmx
ln -s ../ffmpeg/ffmpeg ./mpeg4enc.with_mmx

















