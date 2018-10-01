#!/bin/bash

TOOL_HOME=./tool
STRINGTIE_HOME=$TOOL_HOME/stringtie-1.3.3b.Linux_x86_64

export PATH=$STRINGTIE_HOME:$PATH

### Step.5: Assemble transcript structures by StringTie
STRINGTIE_COMMON_PARAM=""
for DATASET in rice_D_rep1 rice_D_rep2 rice_D_rep3 rice_D_rep4 rice_N_rep1 rice_N_rep2 rice_N_rep3 rice_N_rep4
do
  stringtie $STRINGTIE_COMMON_PARAM -o ${DATASET}.gtf -l ${DATASET} ${DATASET}.bam
done
