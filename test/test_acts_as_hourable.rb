require File.dirname(__FILE__) + '/test_helper'
require 'acts_as_hourable'

class TestActsAsHourable < Test::Unit::TestCase
  
  context "ActsAsHourable" do
    
    should "return a correct value when rounding numbers" do
      assert_equal ActsAsHourable::round_to_decimal_place(5, 1), 5
      assert_equal ActsAsHourable::round_to_decimal_place(5.25, 1), 5.3
      assert_equal ActsAsHourable::round_to_decimal_place(5.253, 2), 5.25
      assert_equal ActsAsHourable::round_to_decimal_place(5.253, 0), 5
    end
    
    should "strip extra trailing zeros off a value when rounding numbers" do
      assert_equal ActsAsHourable::round_to_decimal_place(5.00000, 3).to_s, "5.0"
    end  
    
    
  end
  
end
