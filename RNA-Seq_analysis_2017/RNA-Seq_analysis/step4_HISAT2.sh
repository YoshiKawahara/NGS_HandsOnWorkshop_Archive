#!/bin/bash

TOOL_HOME=./tool
HISAT2_HOME=$TOOL_HOME/hisat2-2.1.0
SAMTOOLS_HOME=$TOOL_HOME/samtools-1.6

export PATH=$HISAT2_HOME:$SAMTOOLS_HOME:$PATH

### Step.4: Align reads to the reference genome by HISAT2
HISAT2_COMMON_PARAM="--min-intronlen 20 --max-intronlen 10000 --downstream-transcriptome-assembly --rna-strandness RF -x genome"

for DATASET in rice_D_rep1 rice_D_rep2 rice_D_rep3 rice_D_rep4 rice_N_rep1 rice_N_rep2 rice_N_rep3 rice_N_rep4
do
  hisat2 $HISAT2_COMMON_PARAM -1 ${DATASET}_r1.pe.fastq.gz -2 ${DATASET}_r2.pe.fastq.gz -S ${DATASET}.sam
  samtools sort -o ${DATASET}.bam ${DATASET}.sam
  samtools index ${DATASET}.bam
  rm ${DATASET}.sam
done
