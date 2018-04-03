# We need to change the SRC_URI to point to our layer.  Otherwise the system
# may decide to fall back to the yoctoproject URL in some cases.  This would
# end up causing problems either due to incorrect SRCREV entries or by missing
# critical patches.
addhandler linux_yocto_rewrite_uri
linux_yocto_rewrite_uri[eventmask] = "bb.event.RecipePreFinalise"

python linux_yocto_rewrite_uri() {
    d = e.data

    # We only care about the SRC_URI as it is defined right now.  We do NOT
    # want to expand it.
    src_uri=d.getVar("SRC_URI", False)

    # Replace the kernel URI.
    src_uri = src_uri.replace("git://git.yoctoproject.org", "git://github.com/WindRiver-OpenSourceLabs")

    # The kernel-cache branch is hard coded by oe-core.  We need to make this adjutable.
    if d.getVar("KERNEL_CACHE_BRANCH"):
        src_uri = src_uri.replace("branch=yocto-4.12;", "branch=${KERNEL_CACHE_BRANCH};")

    d.setVar("SRC_URI", src_uri)
}

