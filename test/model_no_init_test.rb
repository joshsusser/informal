require File.expand_path(File.join(File.dirname(__FILE__), "test_helper"))

class ModelNoInitTest < Test::Unit::TestCase
  class KalEl
    attr_accessor :k
    def initialize(uber)
      @k = uber
    end
  end
  class Poro < KalEl
    include Informal::ModelNoInit
    attr_accessor :x, :y, :z
    validates_presence_of :x, :y, :z
    def initialize(attrs={})
      super(true)
      self.attributes = attrs
    end
  end
  def poro_class; Poro; end

  include ModelTestCases

  def test_super
    assert @model.k
  end
end
