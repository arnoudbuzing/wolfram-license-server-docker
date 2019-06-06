FROM ubuntu

LABEL "com.wolfram.vendor" = "Wolfram Research"
LABEL version = "1.0"
LABEL maintainer = "arnoudb@wolfram.com"
LABEL description = "Docker image for the Wolfram License Server (requires external license file)"
 
RUN apt-get update && apt-get install -y wget

RUN mkdir /wolfram

RUN wget --quiet --output-document=/wolfram/mathlm https://amoeba.wolfram.com/index.php/s/nsMKKPzHKw434DZ/download
RUN wget --quiet --output-document=/wolfram/monitorlm https://amoeba.wolfram.com/index.php/s/dGPYZMnaDsyJaWr/download

RUN chmod a+x /wolfram/mathlm
RUN chmod a+x /wolfram/monitorlm

EXPOSE 16286 16287

CMD ["/wolfram/mathlm", "-pwfile", "/wolfram/mathpass", "-foreground"]
