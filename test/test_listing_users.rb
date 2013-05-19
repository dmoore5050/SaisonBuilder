require 'test_helper'

class TestListingUsers < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_listing_when_there_are_no_users
    assert User.all.empty?
    actual = `ruby saisonbuilder list`
    assert_equal "", actual
  end

  def test_listing_multiple_users
    User.create(name: 'foo')
    User.create(name: 'bar')
    actual = `ruby saisonbuilder list`
    expected = <<EOS
1. foo
2. bar
EOS
    assert_equal expected, actual
  end
end