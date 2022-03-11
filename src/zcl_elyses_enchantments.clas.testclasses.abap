class lth_stack_tester definition for testing
  duration short
  risk level harmless.

  protected section.
    data cut type ref to zcl_elyses_enchantments.

    methods stack importing cards         type string
                 returning value(result) type zcl_elyses_enchantments=>ty_stack.

    methods assert_that importing stack          type zcl_elyses_enchantments=>ty_stack
                        returning value(result) type ref to lth_stack_tester.

    methods equals importing expected type zcl_elyses_enchantments=>ty_stack.
    methods equals_stack importing expected type string.
    methods equals_card importing expected type i.

  private section.
    data test_result type zcl_elyses_enchantments=>ty_stack.

endclass.


class lth_stack_tester implementation.

  method equals.
    cl_abap_unit_assert=>assert_equals(
      act = test_result
      exp = expected ).
  endmethod.

  method assert_that.
    test_result = stack.
    result = me.
  endmethod.

  method stack.
    split cards at space into table data(strings).
    result = strings.
  endmethod.

  method equals_card.

  endmethod.

  method equals_stack.
    cl_abap_unit_assert=>assert_equals(
      act = test_result
      exp = stack( expected ) ).
  endmethod.

endclass.


class ltc_test definition final for testing
  duration short
  risk level harmless
  inheriting from lth_stack_tester.

  private section.

    methods setup.

    methods pick_card for testing raising cx_static_check.
    methods sleight_of_hand for testing raising cx_static_check.



endclass.


class ltc_test implementation.

  method setup.
    cut = new #( ).
  endmethod.

  method pick_card.

    cl_abap_unit_assert=>assert_equals( act = cut->get_item( stack = stack( `1 2 3` ) position = 1 )
                                        exp = 1
                                        msg = 'get the first card' ).

    cl_abap_unit_assert=>assert_equals( act = cut->get_item( stack = stack( `4 5 6` ) position = 2 )
                                        exp = 5
                                        msg = 'get the middle card' ).

    cl_abap_unit_assert=>assert_equals( act = cut->get_item( stack = stack( `7 8 9` ) position = 3 )
                                        exp = 9
                                        msg = 'get the last card' ).

  endmethod.


  method sleight_of_hand.

    cl_abap_unit_assert=>assert_equals( act = cut->set_item( stack = stack( `1 2 3` )
                                                             position = 1
                                                             replacement = 7 )
                                        exp = stack( `7 2 3` )
                                        msg = 'replace the first card with a 7' ).

    cl_abap_unit_assert=>assert_equals( act = cut->set_item( stack = stack( `2 2 2` )
                                                             position = 2
                                                             replacement = 5 )
                                        exp = stack( `2 5 2` )
                                        msg = 'replace the middle card with a 5' ).

    cl_abap_unit_assert=>assert_equals( act = cut->set_item( stack = stack( `7 7 6` )
                                                             position = 3
                                                             replacement = 7 )
                                        exp = stack( `7 7 7` )
                                        msg = 'replace the last card with a 7' ).

  endmethod.

endclass.


class ltc_sleight_of_hand definition final for testing
  duration short
  risk level harmless
  inheriting from lth_stack_tester.

  private section.

    methods setup.
    METHODS replace_v1.

    methods replace_first_card for testing raising cx_static_check.
    methods replace_middle_card for testing raising cx_static_check.
    methods replace_last_card for testing raising cx_static_check.

endclass.


class ltc_sleight_of_hand implementation.

  method setup.
    cut = new #( ).
  endmethod.


  method replace_v1.

    "This doesn't work:
    " cl_abap_unit_assert=>assert_equals( act = cut->set_item( stack = stack( `1 2 3` )
    "                                                          position = 1
    "                                                          replacement = 7 )
    "                                     exp = stack( `7 2 3` )
    "                                     msg = 'replace the first card with a 7' ).

    "This also doesn't work:
*    data stack type zcl_elyses_enchantments=>ty_stack.
*    data act type zcl_elyses_enchantments=>ty_stack.
*    stack = stack( `7 2 3` ).
*    act = cut->set_item( stack        = stack( `1 2 3` )
*                         position    = 1
*                         replacement = 7 ).
*    cl_abap_unit_assert=>assert_equals( act = act
*                                        exp = stack ).


  endmethod.

  method replace_first_card.
    assert_that( cut->set_item( stack = stack( `1 2 3` ) position = 1 replacement = 7 ) )->equals_stack( `7 2 3` ).
  endmethod.

  method replace_middle_card.
    assert_that( cut->set_item( stack = stack( `2 2 2` ) position = 2 replacement = 5 ) )->equals_stack( `2 5 2` ).
  endmethod.

  method replace_last_card.
    assert_that( cut->set_item( stack = stack( `7 7 6` ) position = 3 replacement = 7 ) )->equals_stack( `7 7 7` ).
  endmethod.

endclass.

class ltc_add_cards_on_top definition final for testing
  duration short
  risk level harmless
  inheriting from lth_stack_tester.

  private section.

    methods setup.

    methods add_second_card for testing raising cx_static_check.
    methods add_third_card for testing raising cx_static_check.
    methods add_fourth_card for testing raising cx_static_check.
    methods add_different_fourth_card for testing raising cx_static_check.

endclass.


class ltc_add_cards_on_top implementation.

  method setup.
    cut = new #( ).
  endmethod.

  method add_second_card.
    assert_that( cut->insert_item_at_top( stack = stack( `1` ) new_card = 5 ) )->equals_stack( `1 5` ).
  endmethod.

  method add_third_card.
    assert_that( cut->insert_item_at_top( stack = stack( `1 5` ) new_card = 9 ) )->equals_stack( `1 5 9` ).
  endmethod.

  method add_fourth_card.
    assert_that( cut->insert_item_at_top( stack = stack( `1 5 9` ) new_card = 2 ) )->equals_stack( `1 5 9 2` ).
  endmethod.

  method add_different_fourth_card.
    assert_that( cut->insert_item_at_top( stack = stack( `1 5 9` ) new_card = 8 ) )->equals_stack( `1 5 9 8` ).
  endmethod.

endclass.


class ltc_make_cards_disappear definition final for testing
  duration short
  risk level harmless
  inheriting from lth_stack_tester.

  private section.

    methods setup.

    methods remove_bottom_card for testing raising cx_static_check.
    methods remove_top_card for testing raising cx_static_check.
    methods remove_second_card for testing raising cx_static_check.
    methods remove_the_middle_two_cards for testing raising cx_static_check.

endclass.


class ltc_make_cards_disappear implementation.

  method setup.
    cut = new #( ).
  endmethod.

  method remove_bottom_card.
    assert_that( cut->remove_item( stack = stack( `1 2 3 4` ) position = 1 ) )->equals( stack( `2 3 4` ) ).
  endmethod.

  method remove_top_card.
    assert_that( cut->remove_item( stack = stack( `1 2 3 4` ) position = 4 ) )->equals( stack( `1 2 3` ) ).
  endmethod.

  method remove_second_card.
    assert_that( cut->remove_item( stack = stack( `1 2 3 4` ) position = 2 ) )->equals( stack( `1 3 4` ) ).
  endmethod.

  method remove_the_middle_two_cards.
    data(stack) = stack( `1 2 3 4` ).

    stack = cut->remove_item( stack = stack position = 2 ).
    stack = cut->remove_item( stack = stack position = 2 ).

    assert_that( stack )->equals( stack( `1 4` ) ).
  endmethod.

endclass.

class ltc_make_top_card_disappear definition final for testing
  duration short
  risk level harmless
  inheriting from lth_stack_tester.

  private section.

    methods setup.

    methods remove_only_card for testing raising cx_static_check.
    methods remove_a_card for testing raising cx_static_check.
    methods remove_two_cards for testing raising cx_static_check.

endclass.


class ltc_make_top_card_disappear implementation.

  method setup.
    cut = new #( ).
  endmethod.

  method remove_only_card.
    assert_that( cut->remove_item_from_top( stack = stack( `1` ) ) )->equals_stack( `` ).
  endmethod.

  method remove_a_card.
    assert_that( cut->remove_item_from_top( stack = stack( `1 2 3` ) ) )->equals_stack( `1 2` ).
  endmethod.

  method remove_two_cards.

  endmethod.

endclass.
