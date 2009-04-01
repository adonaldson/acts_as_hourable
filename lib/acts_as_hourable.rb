require 'acts_as_hourable/extensions'

# ActsAsHourable
module ActsAsHourable
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  # Module singleton method -- Dave Thomas at sor09
  class << self
    def round_to_decimal_place(value, decimal_places = nil)
      decimal_places ||= 1
      squared_value = 10**decimal_places
      (value * squared_value).round / squared_value.to_f  
    end
  end
          
  module ClassMethods
    def acts_as_hourable(*columns)
      # Pop the last item off the array if its a Hash, otherwise create a blank one
      options = (columns.last.is_a?(Hash)) ? columns.pop : {}
      
      # Default options      
      options = { :columns => columns, :decimal_places => 2, :suffix => "_hours" }.merge(options)
      
      # Save our options for use later
      write_inheritable_attribute :acts_as_hourable_options, options
      class_inheritable_reader :acts_as_hourable_options
      
      # Create our methods based on the column names passed in
      options[:columns].each { |c| create_in_hours_methods(c) }
      
      extend ClassMethods
    end
    
    # Returns a number to x decimal places -- strangely this is the fastest way to do it
    # http://groups.google.com/group/comp.lang.ruby/browse_thread/thread/243f32c9f36409c2
    # Note: this is a longer (but backward compatible) way -- it's easy now to use
    # FixNum#seconds_in_hours(decimal_places)
    def round_to_decimal_place(value, decimal_places = nil)
      $stderr.puts "WARNING: Class#round_to_decimal_place is being deprecated in favour of ActsAsHourable::round_to_decimal_place"
      ActsAsHourable::round_to_decimal_place(value, decimal_places)
    end
      
    private

    def create_in_hours_methods(column_name)
      new_method = <<EOF
        def #{column_name}#{self.acts_as_hourable_options[:suffix]}(decimal_places = nil)
          return nil if self.#{column_name}.blank?

          in_hours = self.#{column_name} / 1.hour.to_f
          ActsAsHourable::round_to_decimal_place(in_hours, decimal_places)
        end
        
        def #{column_name}#{self.acts_as_hourable_options[:suffix]}=(value)
          write_attribute(:#{column_name}, (value.to_f * 60 * 60).to_i)
        end
EOF
        class_eval(new_method)
    end
    
  end
  
end