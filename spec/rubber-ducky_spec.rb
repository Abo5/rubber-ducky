require 'spec_helper'
require 'base64'
require_relative '../lib/rubber-ducky'

RSpec.describe Rubber::Ducky do
  before(:each) do
    # إنشاء الملفات الافتراضية قبل كل اختبار
    File.write('payload.txt', 'DELAY 500\nGUI SPACE\nDELAY 500\nSTRING terminal\nDELAY 500\nENTER\nDELAY 1000\nSTRING echo "hello from Rubber Ducky library"\nENTER')
  end

  after(:each) do
    # حذف الملفات بعد كل اختبار
    File.delete('inject.bin') if File.exist?('inject.bin')
    File.delete('payload-decode.txt') if File.exist?('payload-decode.txt')
    File.delete('payload.txt') if File.exist?('payload.txt')
  end

  describe '.encode' do
    it 'encodes the script content into binary format' do
      Rubber::Ducky.encode('payload.txt', output: 'inject.bin', language: 'us')
      puts "Encoded inject.bin content:\n#{File.read('inject.bin')}" # طباعة محتوى inject.bin بعد التشفير
      expect(File).to exist('inject.bin')
    end    
  end

  describe '.decode' do
    it 'decodes the binary file back to the expected script text' do
      # التأكد من وجود الملف inject.bin
      Rubber::Ducky.encode('payload.txt', output: 'inject.bin', language: 'us')
      expect(File).to exist('inject.bin')

      expected_decoded_content = <<~TEXT.strip
        DELAY 500
        GUI SPACE
        DELAY 500
        STRING terminal
        DELAY 500
        ENTER
        DELAY 1000
        STRING echo "hello from Rubber Ducky library"
        ENTER
      TEXT

      Rubber::Ducky.decode('inject.bin', output: 'payload-decode.txt', language: 'us')
      decoded_content = File.read('payload-decode.txt').strip
      puts "Decoded content:\n#{decoded_content}"  # طباعة المحتوى الناتج للتحقق

      expect(decoded_content).to eq(expected_decoded_content)
    end
  end
end
