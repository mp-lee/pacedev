as6809 -l -o -s loderun_6809.asm
REM cartridge image
REM aslink -i loderun_6809.rel
REM hex2bin loderun_6809.ihx
REM disk basic
aslink -t loderun_6809.rel
