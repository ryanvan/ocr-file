module OcrFile
  module OcrEngines
    module Tesseract
      extend self

      def id
        'tesseract'
      end

      def ocr_to_text(file_path, options: {})
        options = { lang: options[:lang] } unless options[:lang].empty?
        image = ::RTesseract.new(file_path, options)
        image.to_s # Getting the value
      end

      def ocr_to_pdf(file_path, options: {})
        options = { lang: options[:lang] } unless options[:lang].empty?
        image = ::RTesseract.new(file_path, options)
        raw_output = image.to_pdf  # Getting open file of pdf
        OcrFile::ImageEngines::PdfEngine.open_pdf(raw_output, password: '')
      end
    end
  end
end
