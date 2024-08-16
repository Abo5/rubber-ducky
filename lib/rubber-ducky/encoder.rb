# lib/rubber-ducky/encoder.rb

require 'json'
require_relative 'common'

module Rubber
  module Ducky
    module Encoder
      def self.encode(duck_text, language)
        lang_file = Common.load_language(language)
        encoded = parse_text(duck_text, lang_file)
        [encoded].pack('H*')
      end

      def self.parse_text(duck_text, lang_file)
        encoded_file = []
        default_delay = 0

        duck_text.gsub!("\r", '')
        duck_text.split("\n").each do |line|
          line.strip!
          next if line.empty? || line.start_with?('REM', 'rem')

          cmd, instruction = line.split(' ', 2)
          cmd.strip!
          instruction&.strip!

          case cmd.upcase
          when 'DEFAULT_DELAY', 'DEFAULTDELAY'
            default_delay = instruction.to_i
          when 'DELAY'
            encoded_file.push(add_delay(instruction.to_i))
          when 'STRING'
            encode_string(instruction, lang_file, encoded_file)
          else
            encode_command(cmd, instruction, lang_file, encoded_file)
          end

          encoded_file.push(add_delay(default_delay)) if default_delay > 0
        end

        encoded_file.join
      end

      def self.encode_string(text, lang_file, encoded_file)
        text.each_char do |char|
          if lang_file[char]
            elements = lang_file[char].split(',')
            encoded_file.push(Common.convert_hex(elements[2].to_i(16)), Common.convert_hex(elements[0].to_i(16)))
          else
            puts "Warning: Character '#{char}' not found in language file"
          end
        end
      end

      def self.encode_command(cmd, instruction, lang_file, encoded_file)
        if lang_file[cmd]
          elements = lang_file[cmd].split(',')
          elements.map! { |i| i.to_i(16) }

          if instruction && lang_file[instruction]
            param = lang_file[instruction].split(',')
            param.map! { |i| i.to_i(16) }
            elements[0] |= param[0]
            elements[2] |= param[2]
          end

          encoded_file.push(Common.convert_hex(elements[2]), Common.convert_hex(elements[0]))
        else
          puts "Warning: Command '#{cmd}' not found in language file"
        end
      end

      def self.add_delay(delay_value)
        delay_return = ''

        while delay_value > 0
          if delay_value > 255
            delay_return += '00FF'
            delay_value -= 255
          else
            _delay = delay_value.to_s(16).rjust(2, '0')
            delay_return += "00#{_delay}"
            delay_value = 0
          end
        end

        delay_return
      end
    end
  end
end