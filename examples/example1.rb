require 'rubber-ducky'

# لتشفير المحتوى من ملف وكتابته إلى ملف
encode = Rubber::Ducky.encode('payload.txt', output: 'inject.bin', language: 'us') # or without language to set by default

# لفك تشفير الملف وكتابة المحتوى المفكك إلى ملف
decode = Rubber::Ducky.decode('inject.bin', output: 'payload-decode.txt', language: 'us')

puts "Decoded content:"
puts decode