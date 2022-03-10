class ltc_test definition final for testing
  duration short
  risk level harmless.

  protected section.

    methods deck importing cards         type string
                 returning value(result) type zcl_elyses_enchantments=>ty_deck.

  private section.
    data cut type ref to zcl_elyses_enchantments.

    methods setup.

    methods pick_card for testing raising cx_static_check.
    methods sleight_of_hand for testing raising cx_static_check.
    methods add_cards_on_top for testing raising cx_static_check.


endclass.


class ltc_test implementation.

  method setup.
    cut = new #( ).
  endmethod.


  method pick_card.

    cl_abap_unit_assert=>assert_equals( act = cut->get_item( deck = deck( `1 2 3` ) position = 1 )
                                        exp = 1
                                        msg = 'get the first card' ).

    cl_abap_unit_assert=>assert_equals( act = cut->get_item( deck = deck( `4 5 6` ) position = 2 )
                                        exp = 5
                                        msg = 'get the middle card' ).

    cl_abap_unit_assert=>assert_equals( act = cut->get_item( deck = deck( `7 8 9` ) position = 3 )
                                        exp = 9
                                        msg = 'get the last card' ).

  endmethod.


  method sleight_of_hand.

    cl_abap_unit_assert=>assert_equals( act = cut->set_item( deck = deck( `1 2 3` )
                                                             position = 1
                                                             replacement = 7 )
                                        exp = deck( `7 2 3` )
                                        msg = 'replace the first card with a 7' ).

    cl_abap_unit_assert=>assert_equals( act = cut->set_item( deck = deck( `2 2 2` )
                                                             position = 2
                                                             replacement = 5 )
                                        exp = deck( `2 5 2` )
                                        msg = 'replace the middle card with a 5' ).

    cl_abap_unit_assert=>assert_equals( act = cut->set_item( deck = deck( `7 7 6` )
                                                             position = 3
                                                             replacement = 7 )
                                        exp = deck( `7 7 7` )
                                        msg = 'replace the last card with a 7' ).

  endmethod.


  method add_cards_on_top.

    cl_abap_unit_assert=>assert_equals( act = cut->insert_item_at_top( deck = deck( `1` ) new_card = 5 )
                                        exp = deck( `1 5` )
                                        msg = 'adding a second card at the top' ).

    cl_abap_unit_assert=>assert_equals( act = cut->insert_item_at_top( deck = deck( `1 5` ) new_card = 9 )
                                        exp = deck( `1 5 9` )
                                        msg = 'adding a third card at the top' ).

    cl_abap_unit_assert=>assert_equals( act = cut->insert_item_at_top( deck = deck( `1 5 9` ) new_card = 2 )
                                        exp = deck( `1 5 9 2` )
                                        msg = 'adding a fourth card at the top' ).

    cl_abap_unit_assert=>assert_equals( act = cut->insert_item_at_top( deck = deck( `1 5 9` ) new_card = 8 )
                                        exp = deck( `1 5 9 8` )
                                        msg = 'adding a different fourth card at the top' ).

  endmethod.


  method deck.
    "We could use value #( ( 1 ) ( 2 ) ( 3 ) ), but this makes the test more readable
    split cards at space into table data(strings).
    result = strings.
  endmethod.

endclass.
