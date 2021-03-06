module ModelTestCases
  include ActiveModel::Lint::Tests

  def setup
    @model = self.poro_class.new(:x => 1, :y => 2)
  end

  def teardown
    self.poro_class.instance_variable_set(:@_model_name, nil)
  end

  def test_new
    assert_equal 1, @model.x
    assert_equal 2, @model.y
    assert_nil @model.z
  end

  def test_new_with_nil
    assert_nothing_raised { self.poro_class.new(nil) }
  end

  def test_persisted
    assert !@model.persisted?
  end

  def test_new_record
    assert @model.new_record?
  end

  def test_to_key
    assert_equal [@model.object_id], @model.to_key
  end

  def test_naming
    assert_equal "Poro", @model.class.model_name.human
  end

  if ActiveModel::VERSION::MINOR > 0
    def test_model_name_override
      self.poro_class.informal_model_name("Alias")
      assert_equal "Alias", @model.class.model_name.human
    end
  end

  def test_validations
    assert @model.invalid?
    assert_equal [], @model.errors[:x]
    assert @model.errors[:z].any? {|err| err =~ /blank/}
  end
end
