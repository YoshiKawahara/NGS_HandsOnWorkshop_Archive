#!/bin/bash

### Step.1: download and install tools
mkdir tool
cd tool

# install FastQC
wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.5.zip
unzip fastqc_v0.11.5.zip
chmod +x FastQC/fastqc
rm fastqc_v0.11.5.zip

# install Trimmomatic
wget http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/Trimmomatic-0.36.zip
unzip Trimmomatic-0.36.zip
rm Trimmomatic-0.36.zip

# install HISAT2
wget ftp://ftp.ccb.jhu.edu/pub/infphilo/hisat2/downloads/hisat2-2.1.0-Linux_x86_64.zip
unzip hisat2-2.1.0-Linux_x86_64.zip
rm hisat2-2.1.0-Linux_x86_64.zip

# install StringTie
wget http://ccb.jhu.edu/software/stringtie/dl/stringtie-1.3.3b.Linux_x86_64.tar.gz
tar xfz stringtie-1.3.3b.Linux_x86_64.tar.gz
rm stringtie-1.3.3b.Linux_x86_64.tar.gz

# install gffcompare
wget http://ccb.jhu.edu/software/stringtie/dl/gffcompare-0.10.1.Linux_x86_64.tar.gz
tar xfz gffcompare-0.10.1.Linux_x86_64.tar.gz
rm gffcompare-0.10.1.Linux_x86_64.tar.gz

# install Samtools
wget https://github.com/samtools/samtools/releases/download/1.6/samtools-1.6.tar.bz2
tar xfj samtools-1.6.tar.bz2
rm samtools-1.6.tar.bz2
cd samtools-1.6
make
make prefix=`pwd` install

