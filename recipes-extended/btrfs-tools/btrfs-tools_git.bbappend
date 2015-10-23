# docker needs at least version 3.16.1
SRCREV = "5a7157e1a6da26c6058ddb889937fcb4f66edee9"
PV = "3.16.2+git${SRCREV}"

SRC_URI = "git://git.kernel.org/pub/scm/linux/kernel/git/mason/btrfs-progs.git"

# needs asciidoc
DEPENDS += "asciidoc-native"
