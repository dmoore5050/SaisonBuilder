require 'test_helper'
# require_relative '../models/User'

class TestAddingUser < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_takes_arguments_and_saves_them
    assert_equal 0, User.count
    `ruby saisonbuilder add foo`
    assert_equal 1, User.count
  end

  def test_takes_arguments_and_uses_them
    `ruby saisonbuilder add foo`
    assert_equal 'foo', User.last.name
  end

  def test_duplicate_names_are_ignored
    User.create( name: 'foo' )
    original_user_count = User.count
    `ruby saisonbuilder add foo`
    assert_equal original_user_count, User.count
  end

  def test_duplicate_names_outputs_error_message
    User.create( name: 'foo' )
    results = `ruby saisonbuilder add foo`
    assert results.include?('That user name is already assigned'), "Actually was '#{results}'"
  end

end