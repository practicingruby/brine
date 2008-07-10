$LOAD_PATH.unshift(File.dirname(__FILE__) + "/../vendor/prawn/lib")
require 'prawn'

class Brine

  FONT_SIZE      = 48
  CORE_FONT      = "Times-Roman"
  CODE_FONT_SIZE = 16

  def self.presentation(file,&block)
    @pres = Brine.new
    @pres.instance_eval(&block)
    @pres.render_pdf(file)
  end

  def initialize
    @pdf = Prawn::Document.new(:page_layout   => :landscape,
                               :left_margin   => 0,
                               :right_margin  => 0,
                               :top_margin    => 0,
                               :bottom_margin => 0 )
    @pdf.font CORE_FONT
    @pdf.font_size!(FONT_SIZE)
 
    @slides = []
  end

  attr_reader :slides, :pdf

  def slide(string, options={})
    string = Array(string).join
    @pdf.start_new_page unless @slides.empty?
    @pdf.font options[:font] || CORE_FONT

    @pdf.font_size(options[:font_size] || FONT_SIZE) do
      centered_text(string)
    end

    @pdf.font CORE_FONT
    @slides << string
  end

  def code_slide(string, options={})
    options[:font] ||= "Courier" 
    options[:font_size] ||= CODE_FONT_SIZE 
    slide(string,options) 
  end

  def render_pdf(file)
    @pdf.render_file(file)
  end

  private 

  def text_height(slide)
    metrics = @pdf.font_metrics
    metrics.string_height(slide, :line_width => @pdf.bounds.width,
                                 :font_size  => @pdf.current_font_size)
  end

  def text_width(slide)
    metrics = @pdf.font_metrics
    slide.lines.map { |e| metrics.string_width(e, @pdf.current_font_size) }.max
  end

  def centered_text(s)
    bounds = @pdf.bounds

    left_edge = (bounds.width - text_width(s)) / 2.0
    top_edge =  (bounds.absolute_top + text_height(s)) / 2.0

    anchor = [left_edge, top_edge]

    @pdf.bounding_box(anchor, :width => text_width(s) ) do 
      @pdf.text(s) 
    end
  end
end
