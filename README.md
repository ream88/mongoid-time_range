# mongoid-time_range

Mongoid::TimeRange defines a TimeRange type for your Mongoid apps, which is an object with `from` and `to` keys.

## Installation

In your Gemfile:

```ruby
gem 'mongoid-time_range'
```

## Usage

```ruby
class Document
  include Mongoid::Document

  field :range, type: Mongoid::TimeRange, default: ->{ TimeRange.new }
end
```

```ruby
document = Document.create
document.range # => { from: 2013-01-01 00:00:00 +0100, to: nil }

year2013 = Document.create(range: { from: Time.now.at_beginning_of_year, to: Time.now.end_of_year })
year2013.range # => { from: 2013-01-01 00:00:00 +0100, to: 2013-12-31 23:59:59 +0100 }
```

If you want to use `TimeRange` directly instead of `Mongoid::TimeRange`:

```ruby
class Document
  include Mongoid::Document

  field :range, type: TimeRange
end
```

… your Gemfile must include a additional require statement:

```ruby
gem 'mongoid-time_range', require: 'mongoid/time_range/global'
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Copyright

(The MIT license)

Copyright (c) 2013 Mario Uher

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
