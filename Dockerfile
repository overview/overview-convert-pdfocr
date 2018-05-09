FROM alpine:3.7 AS os
RUN set -x \
  && apk add --update --no-cache \
    openjdk8-jre-base \
    jq \
    ca-certificates \
    openssl \
    tesseract-ocr \
    ttf-freefont \
    msttcorefonts-installer \
    tini \
  && update-ms-fonts && fc-cache -f \
  && wget -P /usr/share/tessdata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/osd.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ara.cube.bigrams \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ara.cube.fold \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ara.cube.lm \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ara.cube.nn \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ara.cube.params \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ara.cube.size \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ara.cube.word-freq \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ara.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/cat.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/deu.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.cube.bigrams \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.cube.fold \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.cube.lm \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.cube.nn \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.cube.params \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.cube.size \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.cube.word-freq \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.tesseract_cube.nn \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/eng.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/fra.cube.bigrams \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/fra.cube.fold \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/fra.cube.lm \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/fra.cube.nn \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/fra.cube.params \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/fra.cube.size \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/fra.cube.word-freq \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/fra.tesseract_cube.nn \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/fra.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ita.cube.bigrams \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ita.cube.fold \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ita.cube.lm \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ita.cube.nn \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ita.cube.params \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ita.cube.size \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ita.cube.word-freq \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ita.tesseract_cube.nn \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ita.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/nld.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/nor.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/por.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/ron.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/rus.cube.fold \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/rus.cube.lm \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/rus.cube.nn \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/rus.cube.params \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/rus.cube.size \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/rus.cube.word-freq \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/rus.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/spa.cube.bigrams \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/spa.cube.fold \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/spa.cube.lm \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/spa.cube.nn \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/spa.cube.params \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/spa.cube.size \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/spa.cube.word-freq \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/spa.traineddata \
    https://raw.githubusercontent.com/tesseract-ocr/tessdata/3.04.00/swe.traineddata

FROM os AS build
RUN apk add --update --no-cache \
    unzip \
  && wget -P ~ https://github.com/sbt/sbt/releases/download/v1.1.2/sbt-1.1.2.zip \
  && (cd ~ && unzip sbt-1.1.2.zip) \
  && apk del unzip \
  && rm -f ~/sbt-1.1.2.zip
COPY java/ /app/java/
RUN cd /app/java/ && java -jar ~/sbt/bin/sbt-launch.jar assembly


FROM overview/overview-convert-framework:0.0.16 AS framework
# multi-stage build


FROM os AS base
WORKDIR /app
COPY --from=framework /app/run /app/run
COPY --from=framework /app/convert-single-file /app/convert
COPY --from=build /app/java/target/scala-2.12/convert-pdfocr.jar /app/
COPY ./do-convert-single-file /app/do-convert-single-file
CMD [ "/sbin/tini", "/app/run" ]


FROM base AS test
COPY --from=framework /app/test-convert-single-file /app/
COPY test/ /app/test/
RUN [ "/app/test-convert-single-file" ]
CMD [ "true" ]


FROM base AS production
