module Mail
  module Encodings
    module UnixToUnix
      def self.decode(str)
        # support multi-line encoded filename
        if match = str.gsub("\r\n", "\n").match(/^begin.*?\n([ \t].*?\n)*(.*)\n[ `]+\nend/m) 
          match[2].unpack('u').first
        end   
      end

      # support 'Content-Transfer-Encoding: uuencode'
      Encodings.register('uuencode', self)
    end
  end
end
