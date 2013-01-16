set term png
set output "<+file+>"
set xlabel "<+xlabel+>"
set ylabel "<+ylabel+>"

plot "<+data+>" using 1:2 with lines title "<+title+>"

# vim:ft=gnuplot
