require 'rtesseract'
require "fileutils"
require "mini_magick"
require "combine_pdf"
require 'pdftohtmlr'
require 'nokogiri'
include PDFToHTMLR
PDF_NAME = 'gl.pdf'
DIR_PATH = "./test/#{PDF_NAME.sub('.', '_')}_output"

def dir_path
  if Dir.exist?(DIR_PATH)
    File.expand_path(DIR_PATH)
  else
    FileUtils.mkdir(DIR_PATH)
    File.expand_path(DIR_PATH)
  end
end

# 把pdf转html,获取png
def to_png
  dir = dir_path
  file = PdfFilePath.new("./test/gl.pdf", dir)
  begin
    file.convert
    file.convert_to_document()
    file.close
    dir.close
  rescue StandardError => e
    puts "Error occurred: #{e.message}"
  end
  system("mv ./test/*.png #{dir}")
end

# 获取指定目录下的所有 PNG 文件
def png_files
  png_files = Dir.glob("#{dir_path}/*.png")
  # 按生成时间对 PNG 文件排序
  png_files.sort_by! { |file| File.birthtime(file) }
  png_files
end

# png转pdf并合并
def combine
  pdf = CombinePDF.new
  png_files.each_with_index do |png_file, index|
    rt_img = RTesseract.new(png_file, lang: 'chi_sim')
    # 设置输出目录
    file = rt_img.to_pdf
    pdf << CombinePDF.load(file.path) # one way to combine, very fast.
  end
  pdf.save "probability.pdf"
end

def main
  to_png
  combine
end

main