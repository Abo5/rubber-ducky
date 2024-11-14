
[![Gem Version](https://badge.fury.io/rb/rubber-ducky.svg)](https://badge.fury.io/rb/rubber-ducky)
[![License: MIT](https://cdn.prod.website-files.com/5e0f1144930a8bc8aace526c/65dd9eb5aaca434fac4f1c34_License-MIT-blue.svg)](/LICENSE)


# [join to our telegram for more Rubber Ducky scripts]('https://t.me/@DuckyScript1') <a href="https://t.me/@DuckyScript1" target="blank"><img align="center" src="https://raw.githubusercontent.com/AliSawari/github-profile-readme-generator/master/src/images/icons/Social/telegram.svg" alt="Telegram: maxbarsukov" height="25" width="30" /></a>
# Rubber Ducky Ruby Library

Welcome to the `rubber-ducky` Ruby library! This library provides an easy-to-use interface for encoding and decoding Rubber Ducky scripts into binary files and vice versa. Whether you're a beginner or a seasoned developer, this README will guide you through everything you need to know to get started and make the most of this library.

## Table of Contents

- [Installation](#installation)
- [Basic Usage](#basic-usage)
  - [Encoding a Script](#encoding-a-script)
  - [Decoding a Binary File](#decoding-a-binary-file)
- [Advanced Usage](#advanced-usage)
  - [Customizing Encoding and Decoding](#customizing-encoding-and-decoding)
  - [Working with Different Languages](#working-with-different-languages)
- [Professional Tips and Tricks](#professional-tips-and-tricks)
  - [Integrating with Other Tools](#integrating-with-other-tools)
  - [Error Handling](#error-handling)
  - [Best Practices](#best-practices)
- [Contributing](#contributing)
- [License](#license)

## Installation

To install the `rubber-ducky` gem, simply add it to your Gemfile or install it directly using `gem`:

```bash
gem install rubber-ducky
```

Alternatively, you can include it in your `Gemfile`:

```ruby
gem 'rubber-ducky'
```

Then, run `bundle install` to install the gem.

## Basic Usage

Let's start with the basics. The `rubber-ducky` library allows you to encode and decode Rubber Ducky scripts. Here’s how to use it:

### Encoding a Script

To encode a Rubber Ducky script, you'll first need a script written in a plain text file. Let's assume you have a file named `payload.txt` with the following content:

```text
DELAY 500
GUI r
DELAY 500
STRING cmd
CTRL-SHIFT ENTER
DELAY 1000
ALT y
DELAY 500
STRING netsh advfirewall set allprofiles state off
ENTER
```

To encode this script into a binary file, use the following code:

```ruby
require 'rubber-ducky'

Rubber::Ducky.encode('payload.txt', output: 'inject.bin', language: 'us')
```

This will generate a binary file named `inject.bin` that can be used with a Rubber Ducky USB device.

### Decoding a Binary File

Decoding a binary file back to its script form is just as easy. Assuming you have a binary file named `inject.bin`, you can decode it like this:

```ruby
require 'rubber-ducky'

decoded_script = Rubber::Ducky.decode('inject.bin', output: 'payload-decode.txt', language: 'us')
puts "Decoded content:"
puts decoded_script
```

This will output the decoded script to the console and save it to `payload-decode.txt`.

## Advanced Usage

Now that you're familiar with the basics, let's dive into some advanced features.

### Customizing Encoding and Decoding

You can customize the encoding and decoding processes by directly manipulating the content before encoding or after decoding. For example:

```ruby
require 'rubber-ducky'

# Read the script from a file
script = File.read('payload.txt')

# Modify the script if needed
script.gsub!('500', '1000') # Change all delays from 500ms to 1000ms

# Encode the modified script
Rubber::Ducky.encode(script, output: 'inject.bin', language: 'us')

# Decode it back to verify the changes
decoded_script = Rubber::Ducky.decode('inject.bin')
puts decoded_script
```

### Working with Different Languages

The library supports multiple keyboard layouts. You can specify the language using the `language` option. For example, to encode a script using the German keyboard layout:

```ruby
Rubber::Ducky.encode('payload.txt', output: 'inject.bin', language: 'de')
```

Similarly, to decode a file encoded with the German layout:

```ruby
decoded_script = Rubber::Ducky.decode('inject.bin', language: 'de')
```

## Professional Tips and Tricks

For advanced users, here are some tips to make the most of the `rubber-ducky` library.

### Integrating with Other Tools

You can easily integrate this library with other Ruby tools and frameworks. For example, you can use it in a Rails application to generate payloads on the fly:

```ruby
class PayloadsController < ApplicationController
  def create
    script = params[:script]
    file_path = Rails.root.join('tmp', 'inject.bin')

    Rubber::Ducky.encode(script, output: file_path, language: 'us')

    send_file file_path, type: 'application/octet-stream', filename: 'inject.bin'
  end
end
```

### Error Handling

The library is designed to be robust, but you should still handle potential errors gracefully:

```ruby
begin
  Rubber::Ducky.encode('payload.txt', output: 'inject.bin', language: 'us')
rescue StandardError => e
  puts "An error occurred during encoding: #{e.message}"
end
```

### Best Practices

- **Test your payloads**: Always test your payloads in a safe environment before deploying them.
- **Use version control**: Keep your scripts under version control to track changes and collaborate with others.
- **Stay updated**: Keep the library and your Ruby version up to date to avoid compatibility issues.

## Contributing

We welcome contributions! If you'd like to contribute to this project, please fork the repository and submit a pull request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Whether you're automating tasks with a Rubber Ducky or exploring new ways to interact with devices, the `rubber-ducky` Ruby library offers a powerful and flexible toolset to get the job done. Happy coding!
# rubber-ducky
