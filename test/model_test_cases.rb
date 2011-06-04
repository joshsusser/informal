module ModelTestCases
  include ActiveModel::Lint::Tests

  def setup
    @model = self.poro_class.new(:x => 1, :y => 2)
  end

  def test_new
    assert_equal 1, @model.x
    assert_equal 2, @model.y
    assert_nil @model.z
  end

  def test_new_with_nil
    @model = self.poro_class.new(nil)
    assert_not_nil @model
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

  def test_validations
    assert @model.invalid?
    assert_equal [], @model.errors[:x]
    assert @model.errors[:z].any? {|err| err =~ /blank/}
  end
end
