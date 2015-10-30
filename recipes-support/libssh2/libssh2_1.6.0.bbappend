# This is also sent to upstream meta-oe, should be removed
# after upstream have it merged.
EXTRA_OECONF += "--with-libssl-prefix=${STAGING_LIBDIR} \
                 --with-libz-prefix=${STAGING_LIBDIR} \
                "
