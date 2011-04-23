require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class ModelTest < Test::Unit::TestCase
  class Poro
    include Informal::Model
    attr_accessor :x, :y, :z
    validates_presence_of :x, :y, :z
  end
  def poro_class; Poro; end

  include ModelTestCases
end
