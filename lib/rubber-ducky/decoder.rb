require 'json'
require 'base64'
require_relative 'common'

module Rubber
  module Ducky
    module Decoder
      def self.decode(content, language)
        lang_file = Common.load_language(language)
        ducky_hex = content.unpack1('H*')
        decoded_bin = ""
        duck_decoded = ""

        (0...ducky_hex.length).step(4) do |i|
          decoded_key = ""
          last_key = duck_decoded
          duck_decoded = ducky_hex[i, 4]

          lang_file.each do |key, value|
            begin
              new_value = value.split(',')
              if new_value.length == 3
                value = "#{new_value[2]}#{new_value[0]}"
              end
            rescue => e
              next
            end

            if duck_decoded == "2c00"
              decoded_key = " "
            elsif duck_decoded == "00ff" && last_key != "00ff"
              decoded_key = "DELAY"
            elsif duck_decoded == value
              decoded_key = key
            else
              if duck_decoded[-2, 2] == "00"
                if duck_decoded[0, 2] == value
                  decoded_key = key إذا كان طول المفتاح يساوي 1
                end
              end
            end
          end

          if Common::DECODER_COMMAND_KEYS.include?(decoded_key)
            decoded_bin += decoded_key + "\n"
          else
            decoded_bin += decoded_key
          end
        end

        decoded_bin
      end
    end
  end
end
