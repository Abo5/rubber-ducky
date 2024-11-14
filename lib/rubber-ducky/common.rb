module Rubber
  module Ducky
    module Common
      DECODER_COMMAND_KEYS = [
        'DELAY', 'SPACE', 'CTRL', 'ALT', 'GUI', 'WINDOWS', 'ESC', 'ESCAPE',
        'PRINTSCREEN', 'INSERT', 'HOME', 'DELETE', 'END', 'ENTER', 'PAGEUP',
        'PAGEDOWN', 'LEFTARROW', 'LEFT', 'DOWNARROW', 'DOWN', 'RIGHTARROW',
        'RIGHT', 'UPARROW', 'UP', 'SCROLLLOCK', 'WINDOWS', 'MENU', 'TAB',
        'CAPSLOCK', 'F1', 'F2', 'F3', 'F4', 'F5', 'F6', 'F7', 'F8', 'F9',
        'F10', 'F11', 'F12', 'GUI R', 'GUI D', 'CTRL-ALT', 'CTRL-SHIFT',
        'ALT-SHIFT', 'CONTROL', 'ESCAPE', 'DELAY', 'DEFAULTDELAY',
        'DEFAULT_DELAY', 'CTRL S', 'CTRL V', 'CTRL X', 'CTRL Z', 'CTRL C',
        'ALT F4', 'WAKE', 'SLEEP', 'APP', 'STOP', 'POWER'
      ].freeze

      def self.convert_hex(int_value)
        format('%02X', int_value)
      end

      def self.list_languages
        languages = []
        lang_dir = File.join(File.dirname(__FILE__), '..', 'languages')
        Dir.glob("#{lang_dir}/*.json").each do |filename|
          languages << File.basename(filename, '.json')
        end
        languages
      end

      def self.load_language(language)
        lang_dir = File.join(File.dirname(__FILE__), '..', 'languages')
        language_file = File.join(lang_dir, "#{language}.json")
        JSON.parse(File.read(language_file))
      end
    end
  end
end
