# lib/rubber-ducky.rb
# ملف الرئيسي
require_relative 'rubber-ducky/common'
require_relative 'rubber-ducky/encoder'
require_relative 'rubber-ducky/decoder'

module Rubber
  module Ducky
    def self.encode(input_file, output: nil, language: 'us')
      content = File.read(input_file)
      encoded = Encoder.encode(content, language)
      if output
        File.open(output, 'wb') do |file|
          file.write(encoded)
        end
      end
      encoded
    end

    def self.decode(input_file, output: nil, language: 'us')
      content = File.binread(input_file)
      decoded = Decoder.decode(content, language)
      if output
        File.open(output, 'w') { |file| file.write(decoded) }
      end
      decoded
    end
  end
end
