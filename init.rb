require 'acts_as_hourable'

ActiveRecord::Base.class_eval do
    include ActsAsHourable
end