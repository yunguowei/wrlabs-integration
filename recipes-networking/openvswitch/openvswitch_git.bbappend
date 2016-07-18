# disable problematic GCC 5.2 optimizations [YOCTO #8291]
FULL_OPTIMIZATION_append_arm = " -fno-schedule-insns2"
