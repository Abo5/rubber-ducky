# lib/rubber-ducky/decoder.rb

require 'json'
require_relative 'common'

module Rubber
  module Ducky
    module Decoder
      def self.decode(content, language)
        lang_file = Common.load_language(language)
        ducky_hex = content.unpack1('H*').upcase
        decoded_bin = ""
        current_string = ""
        i = 0

        while i < ducky_hex.length
          decoded_key = nil
          duck_decoded = ducky_hex[i, 4]

          # التحقق من DELAY
          if duck_decoded == "00FF"
            # التعامل مع التأخير
            delay_value = 0
            while duck_decoded == "00FF"
              delay_value += 255
              i += 4
              duck_decoded = ducky_hex[i, 4] || "0000"
            end
            if duck_decoded[0, 2] == "00"
              delay_byte = duck_decoded[2, 2]
              delay_value += delay_byte.to_i(16)
              i += 4
            end
            if current_string != ""
              decoded_bin += "STRING #{current_string}\n"
              current_string = ""
            end
            decoded_bin += "DELAY #{delay_value}\n"
            next
          end

          # البحث عن المفتاح في ملف اللغة
          lang_file.each do |key, value|
            begin
              new_value = value.split(',')
              if new_value.length == 3
                value = "#{new_value[2]}#{new_value[0]}"
              end
            rescue
              next
            end

            value = value.upcase

            if duck_decoded == "2C00"
              decoded_key = " "
              break
            elsif duck_decoded == value
              decoded_key = key
              break
            elsif duck_decoded[-2, 2] == "00" && value[-2,2] == "00" && duck_decoded[0,2] == value[0,2]
              decoded_key = key if key.length == 1
              break
            end
          end

          if decoded_key
            if Common::DECODER_COMMAND_KEYS.include?(decoded_key.upcase)
              if current_string != ""
                decoded_bin += "STRING #{current_string}\n"
                current_string = ""
              end
              decoded_bin += "#{decoded_key.upcase}\n"
            elsif decoded_key.length == 1 || decoded_key == " "
              current_string += decoded_key
            else
              if current_string != ""
                decoded_bin += "STRING #{current_string}\n"
                current_string = ""
              end
              decoded_bin += "#{decoded_key}\n"
            end
          else
            # رمز غير معروف
            if current_string != ""
              decoded_bin += "STRING #{current_string}\n"
              current_string = ""
            end
            decoded_bin += "UNKNOWN\n"
          end

          i += 4
        end

        # إضافة السلسلة النصية المتبقية إن وجدت
        if current_string != ""
          decoded_bin += "STRING #{current_string}\n"
        end

        decoded_bin
      end
    end
  end
end
