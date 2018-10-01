#!/bin/bash

TOOL_HOME=./tool
HISAT2_HOME=$TOOL_HOME/hisat2-2.1.0
SAMTOOLS_HOME=$TOOL_HOME/samtools-1.6

export PATH=$HISAT2_HOME:$SAMTOOLS_HOME:$PATH

### Step.3: Build index of the reference genome sequence by hisat2-build and samtools
# build index for HISAT2
hisat2-build --ss ss.tab --exon exon.tab genome.fa genome

# build index for IGV etc.
samtools faidx genome.fa
