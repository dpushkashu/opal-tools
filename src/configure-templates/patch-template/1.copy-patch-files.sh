 #!/bin/bash
source #OPAL_TOOLS_USER_ENV_SCRIPT#

SCRIPT_DIR=`dirname $0`
#@REM Yellow forground color for Integration / T&A
#color 0E
opal-installer.sh copyPatchFiles ${SCRIPT_DIR}/sql $OPAL_TOOLS_SRC_SQL_DIR ${SCRIPT_DIR}/PatchFiles.txt

