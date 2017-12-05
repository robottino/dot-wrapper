#!/bin/bash

COMMAND="/c/Program Files (x86)/Graphviz2.38/bin/dot.exe"

INPUT_FILE="$1"

DIRNAME=$(dirname "$INPUT_FILE")
FILENAME=$(basename "$INPUT_FILE")
EXTENSION="${FILENAME##*.}"
FILENAME="${FILENAME%.*}"

#echo "${DIRNAME}/${FILENAME}.${EXTENSION}"
OUTPUT_FILE="${DIRNAME}/${FILENAME}.png"

echo ${INPUT_FILE} ${OUTPUT_FILE}
#exit 1


LAST_MODIFIED=$(stat -c %Y "${INPUT_FILE}")

while true; do
  MODIFIED=$(stat -c %Y "${INPUT_FILE}")
  if [ ${MODIFIED} == ${LAST_MODIFIED} ]; then
    sleep 0.1
  else
    "${COMMAND}" -Tpng "${INPUT_FILE}" -Gdpi=300 > "${OUTPUT_FILE}"
    LAST_MODIFIED=$(stat -c %Y "${INPUT_FILE}")
  fi
done


