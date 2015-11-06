# The dependency to libgcc is because the go-cross
# actually does a compile with the cross compiler
# for some additional objects for the go-cross kit
DEPENDS += "libgcc"

