#!/bin/bash
export GIT_WORKBENCH_STDOUT_LOG=$(tty)
if [ "$PYTHONPATH" = "" ]
then
	export PYTHONPATH=${BUILDER_TOP_DIR}/Source
else
	export PYTHONPATH=${BUILDER_TOP_DIR}/Source:$PYTHONPATH
fi

PYTHON=${PYTHON:-python}
BASENAME=$( basename ${PYTHON} )
SUFFIX=${BASENAME#python*}
DIRNAME=$( dirname ${PYTHON} )

if [ "${DIRNAME}" != "" ]
then
    DIRNAME=${DIRNAME}/
fi
PYTHONW=${DIRNAME}pythonw${SUFFIX}

if [ -e ${PYTHONW} ]
then
    ${PYTHONW} wb_git_main.py $*
else
    ${PYTHON} wb_git_main.py $*
fi