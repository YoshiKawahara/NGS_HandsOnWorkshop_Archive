#### ballgownパッケージのインストールと読み込み
# 途中、Update all/some/none? [a/s/n]:などと聞かれたら"a"でupdateしておく
source("https://bioconductor.org/biocLite.R")
biocLite("ballgown")
library(ballgown)

#### genefilterパッケージのインストールと読み込み
biocLite("genefilter")
library(genefilter)

#### dplyrパッケージのインストールと読み込み
install.packages("dplyr")
library(dplyr)

### サンプル情報の読み込み
pheno_data <- read.csv("phenodata.csv")

### ballgownの入力データの読み込み（StringTieの結果ディレクトリを指定）
bg <- ballgown(dataDir="ballgown", samplePattern="rice", pData=pheno_data)

### サンプル間の分散が1以上のものに絞り込む、つまり発現変動が小さい遺伝子を除く
bg_filtered <- subset(bg, "rowVars(texpr(bg))>=1", genomesubset=TRUE)

### 転写産物レベルでサンプル（Day/Night）間での遺伝子発現変動を検定し、p-valueやq-valueを計算する
results_transcripts <- stattest(bg_filtered, feature="transcript", covariate="DN", getFC=TRUE, meas="FPKM")

### 転写産物レベルの結果に遺伝子名、遺伝子ID、転写産物IDの列を追加する。
results_transcripts = data.frame(geneNames=ballgown::geneNames(bg_filtered), geneIDs=ballgown::geneIDs(bg_filtered), transcriptIDs=ballgown::transcriptNames(bg_filtered), results_transcripts)

### 転写産物レベルでの検定結果をp-valueの小さい順にソートする
results_transcripts = arrange(results_transcripts,pval)

### 適当なq-valueの閾値で切った遺伝子を抽出する。
subset(results_transcripts, results_transcripts$qval<0.01)

### DayとNightサンプルをプロットする際に用いる色を指定する。
mycolor=c("orange", "midnightblue")
palette(mycolor)

### 全遺伝子のFPKM値を抽出し、箱ひげ図を描く。
fpkm <- log2(texpr(bg,meas="FPKM") + 1)
par(mar=c(8,4,1,1))
boxplot(fpkm, col=as.numeric(pheno_data$DN), las=2, ylab="log2(FPKM+1)")

### 特定の遺伝子の発現量の分布を箱ひげ図で表し、個々のサンプルの発現量を個別に重ねてプロットする（LHY、DTH2、SIGA）
# LHY
par(mar=c(4,4,2,1))
plot(fpkm[19641,] ~ pheno_data$DN, border=c(1,2), main=paste(ballgown::geneNames(bg)[19641],' : ', ballgown::transcriptNames(bg)[19641]),pch=19, xlab="D/N", ylab='log2(FPKM+1)')
points(fpkm[19641,] ~ jitter(as.numeric(pheno_data$DN)), col=as.numeric(pheno_data$DN))
# DTH2
plot(fpkm[10165,] ~ pheno_data$DN, border=c(1,2), main=paste(ballgown::geneNames(bg)[10165],' : ', ballgown::transcriptNames(bg)[10165]),pch=19, xlab="D/N", ylab='log2(FPKM+1)')
points(fpkm[10165,] ~ jitter(as.numeric(pheno_data$DN)), col=as.numeric(pheno_data$DN))
# SIGA
plot(fpkm[31942,] ~ pheno_data$DN, border=c(1,2), main=paste(ballgown::geneNames(bg)[31942],' : ', ballgown::transcriptNames(bg)[31942]),pch=19, xlab="D/N", ylab='log2(FPKM+1)')
points(fpkm[31942,] ~ jitter(as.numeric(pheno_data$DN)), col=as.numeric(pheno_data$DN))

### 特定の遺伝子の転写産物構造と発現量を合わせて可視化する（LHY、DTH2、SIGA）
# LHY
plotTranscripts(ballgown::geneIDs(bg)[19641], bg, main=c('LHY'), sample=c('rice_D_rep1','rice_D_rep2','rice_D_rep3','rice_D_rep4','rice_N_rep1','rice_N_rep2','rice_N_rep3','rice_N_rep4'))
# DTH2
plotTranscripts(ballgown::geneIDs(bg)[10165], bg, main=c('DTH2'), sample=c('rice_D_rep1','rice_D_rep2','rice_D_rep3','rice_D_rep4','rice_N_rep1','rice_N_rep2','rice_N_rep3','rice_N_rep4'))
# SIGA
plotTranscripts(ballgown::geneIDs(bg)[31942], bg, main=c('SIGA'), sample=c('rice_D_rep1','rice_D_rep2','rice_D_rep3','rice_D_rep4','rice_N_rep1','rice_N_rep2','rice_N_rep3','rice_N_rep4'))
