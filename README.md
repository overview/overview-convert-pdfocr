Adds invisible text layers to PDFs for [Overview](https://github.com/overview/overview-server)

# Methodology

This program always outputs `0.json` and `0.blob`.

The output `0.json` has `wantOcr:false`.

We custom-built PdfOcr and we'll fix it if it has errors. The one error we
can't handle is OutOfMemory. That will make us exit with a non-zero exit
code, and we'll count on the framework to bail us out.

# Testing

Write to `test/test-*`. `docker build .` will run the tests.

Each test has `input.blob` (which means the same as in production) and
`input.json` (whose contents are `$1` in `do-convert-single-file`). The files
`stdout`, `0.json` and `0.blob` in the test directory are expected values. If
actual values differ from expected values, the test fails.

PDF is a tricky format to get exactly right. You may need to use the Docker
image itself to generate expected output files. For instance, here is how we
build `test-embedded-png/0.blob`:

1. Wrote `test/test-embedded-png/{input.json,input.blob,0.json,stdout}`
1. Ran `docker build .`. The end of the output looked like this:
    Step 12/13 : RUN [ "/app/test-convert-single-file" ]
     ---> Running in 202f38be95c9
    1..1
    not ok 1 - test-embedded-png
        do-convert-single-file wrote /tmp/test-do-convert-single-file887786150/0.blob, but we expected it not to exist
    ...
1. `docker cp 202f38be95c9:/tmp/test-do-convert-single-file887786150/0.blob test/test-embedded-png/`
1. `docker rm -f 202f38be95c9`
1. Inspect the file to make sure it behaves as expected
1. `docker build .` again -- success!
