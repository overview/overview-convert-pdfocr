import java.nio.file.{Path,Paths}
import java.util.Locale
import org.overviewproject.pdfocr.PdfOcr
import org.overviewproject.pdfocr.exceptions._
import scala.util.{Failure,Success}

object MakeSearchablePdf extends App {
  /** Converts a PDF into a searchable PDF, using pdfocr.
    *
    * Outputs progress to stdout as UNIX-newline-separated fractions. For example:
    *
    *   c0/10
    *   c1/10
    *   c2/10
    *   ...
    *   c10/10
    *
    * Kill the program to cancel it. `outPath` may or may not be written.
    *
    * If the program fails with OutOfMemoryError, `outPath` may or may not be
    * written.
    *
    * If pdfocr catches an error halfway through, it will be appended to
    * standard output as a String. (Yes, standard *output*: in this context,
    * an invalid PDF isn't an error.) For instance:
    *
    *   c0/10
    *   c1/10
    *   Invalid PDF file
    *
    * @param inPath Where on the filesystem to find the input file.
    * @param outPath Where on the filesystem to place the output file.
    * @param lang Languages to pass to Tesseract.
    */
  def run(inPath: Path, outPath: Path, locales: Seq[Locale]): Unit = {
    def onProgress(curPage: Int, nPages: Int): Boolean = {
      System.out.print(s"c$curPage/$nPages\n")
      true
    }

    implicit val ec = CrashyExecutionContext()

    def success(message: String): Unit = {
      System.out.print(message + "\n")
      ec.shutdown
    }

    def failure(ex: Throwable): Unit = {
      ex.printStackTrace()
      System.out.print(ex.getMessage)
      Runtime.getRuntime.halt(1)
    }

    PdfOcr.makeSearchablePdf(inPath, outPath, locales, onProgress).onComplete {
      case Success(_) => ec.shutdown
      case Failure(_: PdfInvalidException) => success("Error in PDF file")
      case Failure(_: PdfEncryptedException) => success("PDF file is password-protected")
      case Failure(ex) => failure(ex)
    }

    ec.awaitTermination(1, java.util.concurrent.TimeUnit.DAYS)
  }

  val inPath = Paths.get("input.blob")
  val locales = Seq(new Locale(args(0)))

  val outPath = Paths.get("0.blob")
  run(inPath, outPath, locales)
}
