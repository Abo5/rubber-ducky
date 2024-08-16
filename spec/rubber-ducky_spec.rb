require 'spec_helper'
require 'base64'
require_relative '../lib/rubber-ducky'

RSpec.describe Rubber::Ducky do
  before(:all) do
    File.delete('inject.bin') if File.exist?('inject.bin')
    File.delete('payload-decode.txt') if File.exist?('payload-decode.txt')
  end

  describe '.encode' do
    it 'encodes the script content into binary format' do
      original_content = File.read('spec/payload.txt').strip
      Rubber::Ducky.encode('spec/payload.txt', output: 'inject.bin', language: 'us')
      expect(File).to exist('inject.bin')
    end
  end

  describe '.decode' do
    it 'decodes the binary file back to the expected script text' do
      expect(File).to exist('inject.bin')

      expected_decoded_content = <<~TEXT.strip
        DELAY
        DELAY
        cmdDELAY
        DELAY
        netsh advfirewall set allprofiles state offENTER
      TEXT

      Rubber::Ducky.decode('inject.bin', output: 'payload-decode.txt', language: 'us')
      decoded_content = File.read('payload-decode.txt').strip
      expect(decoded_content).to eq(expected_decoded_content)
    end
  end
end
