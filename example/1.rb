$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
require "brine"

Brine.presentation("1.pdf") do
  slides << "Prawn" << "PDF Generation for Ruby" << 
            "Fast" << "Tiny" << "Nimble" <<
            "Like The Magestic Sea Creature"
end
