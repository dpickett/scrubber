module Scrubber
  class FieldTransform
    attr_reader :field, :change_to_string
    def initialize(field, options = {})
      @field = field.to_s
      unless options.has_key?(:change_to)
        raise "Please specify what you'd like to change the field #{field} to with a :change_to"
      end
      @change_to_string = options[:change_to]
    end

    def perform_on(record)
      record.send("#{@field}=", @change_to_string)
    end
  end
end
