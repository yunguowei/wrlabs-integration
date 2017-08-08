#
# Copyright (C) 2016-2017 Wind River Systems, Inc.
#
# The right to copy, distribute or otherwise make use of this software may
# be licensed only pursuant to the terms of an applicable Wind River license
# agreement.  No license to Wind River intellectual property rights is granted
# herein.  All rights not licensed by Wind River are reserved by Wind River.
#

PACKAGES =+ "${PN}-libs ${PN}-libs-dev ${PN}-app-examples"
DEBIAN_NOAUTONAME_${PN}-libs = "1"
DEBIAN_NOAUTONAME_${PN}-libs-dev = "1"

RDEPENDS_${PN}-app-examples += "bash"

# iot api package
FILES_${PN}-libs = "\
	${LIB_INSTALL_DIR}/*${SOLIBS} \
	${PYTHON_SITEPACKAGES_DIR}/*iot_python* \
	${LIB_INSTALL_DIR}/python3.5/site-packages/*iot_python* \
	${HEADER_INSTALL_DIR} \
"

# development package (symbolic links are for linking)
FILES_${PN}-libs-dev += "\
	${LIB_INSTALL_DIR}/*${SOLIBSDEV} \
"

# iot app examples package
FILES_${PN}-app-examples = "\
	${datadir}/* \
	${BIN_INSTALL_DIR}/actions_script.sh \
	${BIN_INSTALL_DIR}/iot-app-complete \
	${BIN_INSTALL_DIR}/iot-app-old-api \
	${BIN_INSTALL_DIR}/iot-app-simple-actions \
	${BIN_INSTALL_DIR}/iot-app-simple-location \
	${BIN_INSTALL_DIR}/iot-app-simple-telemetry \
	${BIN_INSTALL_DIR}/iot-py-complete.py \
	${BIN_INSTALL_DIR}/old_api_script.sh \
	${BIN_INSTALL_DIR}/test_script.sh \
"
