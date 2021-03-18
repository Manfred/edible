# frozen_string_literal: true

require_relative '../test_helper'

module Edible
  class BuilderTest < Minitest::Test
    def test_simple
      out = Edible.build(
        interchange: 'UNOA',
        version: 2
      ) do
        segment('UNH', 1, 'PAORES', [93, 1, 'IA'])
      end
      assert_equal(<<~DOC, out)
        UNB+UNOA:2'
        UNH+1+PAORES+93:1:IA'
      DOC
    end

    def test_override_separators
      out = Edible.build(
        data_element_separator: '^',
        component_data_element_separator: '_',
        segment_terminator: '<'
      ) do
        segment('UNH', 1, 'PAORES', [93, 1, 'IA'])
      end
      assert_equal(<<~DOC, out)
        UNA_^.? <
        UNH^1^PAORES^93_1_IA<
      DOC
    end

    def test_medvry
      out = Edible.build do
        segment('UNH', 1, ['MEDVRY', 3, 911, 'IT', 'VRY31'], nil, [1, 'C'])
      end
      assert_equal(<<~DOC, out)
        UNH+1+MEDVRY:3:911:IT:VRY31++1:C'
      DOC
    end
  end
end
