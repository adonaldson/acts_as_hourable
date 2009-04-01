require File.dirname(__FILE__) + '/test_helper'
require 'acts_as_hourable'

class TestExtensions < Test::Unit::TestCase
  
  context "ActsAsHourable" do
    
    should "add a method 'seconds_in_hours' to Fixnum instances" do
      assert 1.methods.include?('seconds_in_hours')
    end

    should "correctly convert seconds to hours" do
      assert_equal 3600.seconds_in_hours, 1
      assert_equal 9000.seconds_in_hours, 2.5
    end
    
    should "correctly convert seconds to hours with decimal places" do
      assert_equal 9000.seconds_in_hours(0), 3
      assert_equal 8100.seconds_in_hours(1), 2.3
      assert_equal 8100.seconds_in_hours(2), 2.25
    end
    
  end
  
end


