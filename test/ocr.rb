require 'ocr-file'

  config = {
    # Images from PDF
    filetype: 'png',
    quality: 100,
    dpi: 400,
    # Text to PDF
    font: 'Microsoft YaHei',
    font_size: 8, #8 # 12
    text_x: 20,
    text_y: 800,
    minimum_word: 5,
    # Cloud-Vision OCR
    image_annotator: nil, # Needed for Cloud-Vision
    type_of_ocr: OcrFile::OcrEngines::CloudVision::DOCUMENT_TEXT_DETECTION,
    ocr_engine: 'tesseract', # 'cloud-vision'
    # Image Pre-Processing
    image_preprocess: true,
    effects: %w[despeckle deskew enhance sharpen remove_shadow], # Applies effects as listed. 'norm' is also available
    automatic_reprocess: true, # Will possibly do double + the operations but can produce better results automatically
    #dimensions: [width, height], # Can be nil but will lock the images
    # PDF to Image Processing
    optimise_pdf: true,
    extract_pdf_images: false, # if false will screenshot each PDF page
    temp_filename_prefix: 'image',
    spelling_correction: false, # Will attempt to fix text at the end (not used for searchable pdf output)
    keep_files: false,
    # Console Output
    verbose: true,
    timing: true
  }

  doc = OcrFile::Document.new(
    original_file_path: '/home/carp/projects/ocr-file/test/gl.pdf', # supports PDFs and images
    save_file_path: 'gl_v2.pdf',
    config: config # Not needed as defaults are used when not provided
  )

  #doc.to_s # Returns text, removes temp files and wont save
  doc.to_pdf # Saves a PDF (either searchable over the images or dumped text)
  #doc.to_text # Saves a text file with OCR text
