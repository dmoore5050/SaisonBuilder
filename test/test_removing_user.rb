require 'test_helper'

class TestRemovingUser < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_remove_only_user
    User.create( name: 'only child')
    `ruby saisonbuilder remove "only child"`
    assert User.all.empty?
  end

  def test_remove_particular_user
    User.create( name: 'a')
    User.create( name: 'b')
    User.create( name: 'c')
    assert !User.where( name: 'b').all.empty?
    `ruby saisonbuilder remove b`
    assert User.where( name: 'b').all.empty?
    assert_equal 2, User.count
  end

  def test_remove_particular_User_doesnt_remove_all
    assert User.all.empty?
    User.create( name: 'a')
    User.create( name: 'b')
    User.create( name: 'c')
    assert !User.where( name: 'b').all.empty?
    `ruby saisonbuilder remove b`
    assert_equal 2, User.count
  end
end