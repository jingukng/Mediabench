#!/bin/sh

echo "Hello World! round robin"

cd ./mediabench2_video/

for RUN in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
do

  for BENCHMARK in cjpeg djpeg h263dec h263enc mpeg4dec.with_mmx mpeg4enc.with_mmx h264dec h264enc jpg2000dec jpg2000enc mpeg2dec mpeg2enc mpeg4dec.without_mmx mpeg4enc.without_mmx
  do

    if [ "$BENCHMARK" = "mpeg4dec.with_mmx" -o "$BENCHMARK" = "mpeg4enc.with_mmx" ]; then
      MPEG4VER=".with_mmx"
    elif [ "$BENCHMARK" = "mpeg4dec.without_mmx" -o "$BENCHMARK" = "mpeg4enc.without_mmx" ]; then
      MPEG4VER=".without_mmx"
    else
      MPEG4VER=""
    fi

    if [ "$BENCHMARK" = "cjpeg" ]; then
          ARGS="-dct int -quality 13 -outfile output_base_4CIF_96bps.jpg input_base_4CIF.ppm"
    elif [ "$BENCHMARK" = "djpeg" ]; then
          ARGS="-dct int -ppm -outfile output_base_4CIF_96bps_dec.ppm input_base_4CIF_96bps.jpg"
    elif [ "$BENCHMARK" = "h263dec" ]; then
          ARGS="-o3 input_base_4CIF_96bps.263 output_base_4CIF_96bps_dec_%03d"
    elif [ "$BENCHMARK" = "h263enc" ]; then
          ARGS="-x 4 -a 0 -b 8 -s 15 -G -R 30.00 -r 3508000 -S 3 -Z 30.0 -O 0 -i input_base_4CIF_0to8.yuv -o output_base_4CIF_96bps_15.raw -B output_base_4CIF_96bps_15.263"
    elif [ "$BENCHMARK" = "h264dec" ]; then
          ARGS="input_base_4CIF_96bps_decoder.cfg"
    elif [ "$BENCHMARK" = "h264enc" ]; then
          ARGS="-d input_base_4CIF_96bps_encoder.cfg"
    elif [ "$BENCHMARK" = "jpg2000dec" ]; then
          ARGS="-f input_base_4CIF_96bps.jp2 -F output_base_4CIF_96bps_dec.ppm -T pnm"
    elif [ "$BENCHMARK" = "jpg2000enc" ]; then
          ARGS="-f input_base_4CIF.ppm -F output_base_4CIF_96bps.jp2 -T jp2 -O rate=0.010416667"
    elif [ "$BENCHMARK" = "mpeg2dec" ]; then
          ARGS="-b input_base_4CIF_96bps.mpg -o3 output_base_4CIF_96bps_%03d"
    elif [ "$BENCHMARK" = "mpeg2enc" ]; then
          ARGS="input_base_4CIF_96bps_15.par output_base_4CIF_96bps_15.mpg"
    elif [ "$BENCHMARK" = "mpeg4dec.with_mmx" -o "$BENCHMARK" = "mpeg4dec.without_mmx" ]; then
      ARGS="-y -s 4cif -r 30 -an -g 9 -bf 3 -i input_base_4CIF_96bps.avi -s 4cif -an -y output_base_4CIF_96bps_dec_%03d${MPEG4VER}.ppm"
    elif [ "$BENCHMARK" = "mpeg4enc.with_mmx" -o "$BENCHMARK" = "mpeg4enc.without_mmx" ]; then
      ARGS="-s 4cif -r 30 -i input_base_4CIF_%03d.ppm -r 30 -s 4cif -b 39 -bf 3 -vcodec mpeg4 -an -vstats -y output_base_4CIF_96bps_15${MPEG4VER}.avi"
    fi


    if [ "$BENCHMARK" = "mpeg4dec.with_mmx" -o "$BENCHMARK" = "mpeg4dec.without_mmx" ]; then
      cd mpeg4dec/oprofile_results/
    elif [ "$BENCHMARK" = "mpeg4enc.with_mmx" -o "$BENCHMARK" = "mpeg4enc.without_mmx" ]; then
      cd mpeg4enc/oprofile_results/
    else
      cd ${BENCHMARK}/oprofile_results/
    fi

    operf time ./${BENCHMARK} ${ARGS}
    echo
    opreport -l ./${BENCHMARK} > oprofile_run${RUN}${MPEG4VER}.rr.results

    cd ../..

  done
done

for BENCHMARK in cjpeg djpeg h263dec h263enc h264dec h264enc jpg2000dec jpg2000enc mpeg2dec mpeg2enc mpeg4dec mpeg4enc
do

  if [ "$BENCHMARK" = "mpeg4dec" -o "$BENCHMARK" = "mpeg4enc" ]; then
    cd ${BENCHMARK}/oprofile_results/

    for MPEG4VER in with_mmx without_mmx
    do
      echo  "Computing statistics for OProfile results of ${BENCHMARK}.${MPEG4VER}"

      for RUN in 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30
      do
        cp oprofile_run${RUN}.${MPEG4VER}.rr.results oprofile_run${RUN}.rr.results
      done

      ../../get_report.rr > ${BENCHMARK}.${MPEG4VER}.combined_results.rr.oprofile

      rm -rf oprofile_run[0-9].rr.results
      rm -rf oprofile_run[0-9][0-9].rr.results

    done

    cd ../..
  else
    echo  "Computing statistics for OProfile results of ${BENCHMARK}"

    cd ${BENCHMARK}/oprofile_results/
    ../../get_report.rr > ${BENCHMARK}.combined_results.rr.oprofile
    cd ../..
  fi

done


