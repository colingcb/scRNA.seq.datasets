FROM rocker/r-base

RUN apt-get clean
RUN apt-get update -y --no-install-recommends
RUN apt-get -f install
RUN dpkg --configure -a
RUN apt-get -f install

RUN apt-get -y -f install \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    pandoc \
    gawk \
    tar \
    sed \
    unzip

# install scater: http://bioconductor.org/packages/scater/
# RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('BiocInstaller')"
# RUN Rscript -e "source('https://bioconductor.org/biocLite.R'); biocLite('scater')"
RUN Rscript -e "install.packages('devtools')"
RUN Rscript -e "devtools::install_github("davismcc/scater", build_vignettes = TRUE)"

# install packages to generate Rmd reports
RUN Rscript -e "install.packages('rmarkdown')"
RUN Rscript -e "install.packages('knitr')"

# add our scripts
ADD . /

# run scripts
CMD bash build.sh
