module Enumerable # Remove this as soon as it is integrated into ActiveSupport.
  # Associates keys with values and returns a Hash.
  #
  # If you have an enumerable of keys and want to associate them with values,
  # pass a block that returns a value for the key:
  #
  #   [1, 2, 3].associate { |i| i ** 2 }
  #   # => { 1 => 1, 2 => 4, 3 => 9 }
  #
  #   %w( tender love ).associate &:capitalize
  #   # => {"tender"=>"Tender", "love"=>"Love"}
  #
  # If you have an enumerable key/value pairs and want to associate them,
  # omit the block and you'll get a hash in return:
  #
  #   [[1, 2], [3, 4]].associate
  #   # => { 1 => 2, 3 => 4 }
  def associate(mapping = {})
    if block_given?
      each_with_object(mapping) do |key, object|
        object[key] = yield(key)
      end
    else
      each_with_object(mapping) do |(key, value), object|
        object[key] = value
      end
    end
  end
end
