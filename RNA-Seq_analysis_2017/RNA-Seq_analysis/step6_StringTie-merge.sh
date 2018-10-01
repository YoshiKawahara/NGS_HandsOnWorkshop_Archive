#!/bin/bash

TOOL_HOME=./tool
STRINGTIE_HOME=$TOOL_HOME/stringtie-1.3.3b.Linux_x86_64

export PATH=$STRINGTIE_HOME:$PATH

### Step.6: Merge assembled transcript structures by StringTie
# make the list of assembled transcripts files
ls ./rice_*.gtf > assemblies.txt

# merge assembled transcripts
stringtie --merge -G annotation.gtf -o stringtie_merged.gtf assemblies.txt
