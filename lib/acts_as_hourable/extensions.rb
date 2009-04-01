class Module  
  # Stolen from rake -- This seemed like a really nice way to do it
  def acts_as_hourable_loud_extension(method)
    if instance_methods.include?(method.to_s) || instance_methods.include?(method.to_sym)
      $stderr.puts "WARNING: Possible conflict with acts_as_hourable extension: #{self}##{method} already exists"
    else
      yield
    end
  end
  
end

class Fixnum
  acts_as_hourable_loud_extension("seconds_in_hours") do
    # Returns a number to x decimal places -- strangely this is the fastest way to do it
    # http://groups.google.com/group/comp.lang.ruby/browse_thread/thread/243f32c9f36409c2
    def seconds_in_hours(decimal_places = 2)      
      ActsAsHourable::round_to_decimal_place(self / 3600.0, decimal_places)
    end
  end
end