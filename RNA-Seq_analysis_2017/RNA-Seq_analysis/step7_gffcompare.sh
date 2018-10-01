#!/bin/bash

TOOL_HOME=./tool
GFFCOMARE_HOME=$TOOL_HOME/gffcompare-0.10.1.Linux_x86_64

export PATH=$GFFCOMARE_HOME:$PATH

# ### Step.7 : Examine how the transcripts compare with the reference annotation
gffcompare -r annotation.gtf -o gffcmp stringtie_merged.gtf
