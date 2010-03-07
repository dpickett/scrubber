module Scrubber
  class Job
    attr_reader :table_name, :conditional_proc, :conditional_proc_type, :field_transforms
    def initialize(table_name, options = {})
      @table_name = table_name.to_s 
      unless options.empty?
        @conditional_proc_type = options.has_key?(:unless) ? :unless : :if
        @conditional_proc      = options[:unless]
        @field_transforms      = []
      end
    end

    def scrub(field, options)
      @field_transforms << Scrubber::FieldTransform.new(field, options) 
    end

    def perform
      #turn off timestamps (we want to preserve original timestamps)
      prior_setting = record_activerecord_timestamps(false)
      table_class.find_in_batches do |batch|
        batch.each do |record|
          if self.conditional_proc_type == :unless
            unless @conditional_proc.call(record)
              perform_scrubs_for(record)
            end
          elsif self.conditional_proc_type == :if
            if @conditional_proc.call(record)
              perform_scrubs_for(record)
            end
          else
            perform_scrubs_for(record)
          end
        end
      end
      #restore timestamping to prior state
      record_activerecord_timestamps(prior_setting)
    end

    private
    def perform_scrubs_for(record)
      @field_transforms.each {|t| t.perform_on(record) }
      record.save!
    end

    def table_class
      @table_class ||= Kernel.const_get(@table_name.classify)
    end

    def record_activerecord_timestamps(shall_record)
      prior_setting = table_class.record_timestamps
      table_class.record_timestamps = shall_record
      prior_setting
    end
  end
end
