require 'test_helper'

class StationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Station.new.valid?
  end
end
