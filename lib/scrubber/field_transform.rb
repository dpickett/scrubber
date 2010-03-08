module Scrubber
  class FieldTransform
    attr_reader :field, :set_to
    def initialize(field, options = {})
      @field = field.to_s
      unless options.has_key?(:set_to)
        raise "Please specify what you'd like to change the field #{field} to with a :set_to"
      end
      @set_to = options[:set_to]
    end

    def perform_on(record)
      val = nil
      if @set_to.is_a?(String)
        val = interpolate_string_for(record)
      else
        val = @set_to
      end

      record.send("#{@field}=", val)
    end

    private
    def interpolate_string_for(record)
      @set_to.gsub(/\[\:([^\]]*)\]/){|s| record.send(s.gsub(/\[|\]|\:/, '')) }
    end
  end
end
