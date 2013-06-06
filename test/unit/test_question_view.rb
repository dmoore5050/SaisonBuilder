require_relative '../test_helper'

class TestQuestionView < MiniTest::Unit::TestCase
  include DatabaseCleaner

  def test_build_remove_list_build_correct_list
    list     = ''
    record   = Recipe.where(name: 'classic').first
    question = QuestionView.new record
    question.build_remove_list list
    pils = 'Pilsner'
    munich = 'Munich'
    space = ' '

    rendered_list = %Q(    #{pils.ljust(22)}
    #{munich.ljust(22)}
    Corn Sugar           peak krausen#{space}
    Styrian Goldings     boil 60 min
    Saaz                 boil 15 min
    Dupont Strain        primary#{space}
)

    expected = list
    actual   = rendered_list

    assert_equal expected, actual
  end

end
