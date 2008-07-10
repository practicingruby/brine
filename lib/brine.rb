$LOAD_PATH.unshift(File.dirname(__FILE__) + "/../vendor/prawn/lib")
require 'prawn'

class Brine
  def self.presentation(file,&block)
    @pres = Brine.new
    @pres.instance_eval(&block)
    @pres.render_pdf(file)
  end

  def initialize
    @slides = []
  end

  attr_reader :slides

  def render_pdf(file)
    @pdf = Prawn::Document.new(:page_layout => :landscape)
    @pdf.font_size!(48)
    @slides.each_with_index do |s,i| 
      @pdf.text(s) 
      @pdf.start_new_page unless @slides.length - 1 == i  
    end
    @pdf.render_file(file)
  end

end
