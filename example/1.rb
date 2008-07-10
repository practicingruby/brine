$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require "brine"

file = File.read(__FILE__)

EX_SOURCE  = file.lines[29..-1]
LIB_SOURCE = File.read(File.join(File.dirname(__FILE__),'..', 'lib','brine.rb'))

ALIGNMENT = <<-EOS
def centered_text(s)
  bounds = @pdf.bounds
  top_edge =  (bounds.absolute_top + text_height(s)) / 2.0

  @pdf.y = top_edge
  @pdf.text(s, :alignment => :center) 
end
EOS

ALIGNMENT2 = <<-EOS
def centered_text(s)
  bounds = @pdf.bounds
  top_edge =  bounds.center[1] + text_height(s) / 2.0

  @pdf.y = top_edge
  @pdf.text(s, :alignment => :center) 
end
EOS


Brine.presentation("1.pdf") do
  slide "Prawn is cool"
  code_slide EX_SOURCE, :font_size  => 16
  code_slide LIB_SOURCE.lines[3..50],  :font_size => 10
  code_slide LIB_SOURCE.lines[52..-1], :font_size => 12
  slide "Prawn is ugly"
  code_slide LIB_SOURCE.lines[65,12]
  slide "Could Become", :font => "Times-Italic"
  code_slide ALIGNMENT
  slide "Can we do better?"
  code_slide ALIGNMENT2
  slide "Other Problems"
  code_slide LIB_SOURCE.lines[29,13]
end
