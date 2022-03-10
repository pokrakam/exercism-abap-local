class zcl_elyses_enchantments definition
  public
  final
  create public .

  public section.

    types ty_deck type standard table of i with empty key.

    methods:

      get_item
        importing deck          type ty_deck
                  position      type i
        returning value(result) type i,

      set_item
        importing deck          type ty_deck
                  position      type i
                  replacement   type i
        returning value(result) type ty_deck,

      insert_item_at_top
        importing deck          type ty_deck
                  new_card      type i
        returning value(result) type ty_deck,

      remove_item
        importing deck          type ty_deck
                  position      type i
        returning value(result) type ty_deck,

      remove_item_from_top
        importing deck          type ty_deck
        returning value(result) type ty_deck,

      insert_item_at_bottom
        importing deck          type ty_deck
                  new_card      type i
        returning value(result) type ty_deck,

      remove_item_at_bottom
        importing deck          type ty_deck
        returning value(result) type ty_deck,

      get_size_of_stack
        importing deck          type ty_deck
        returning value(result) type i.

  protected section.
  private section.
endclass.



class zcl_elyses_enchantments implementation.

  method get_item.
    result = deck[ position ].
  endmethod.

  method set_item.
    result = deck.
    result[ position ] = replacement.
  endmethod.

  method insert_item_at_top.
    result = deck.
    append new_card to result.
  endmethod.

  method get_size_of_stack.
    "Implement solution here
  endmethod.

  method insert_item_at_bottom.
    "Implement solution here
  endmethod.

  method remove_item.
    "Implement solution here
  endmethod.

  method remove_item_at_bottom.
    "Implement solution here
  endmethod.

  method remove_item_from_top.
    "Implement solution here
  endmethod.

endclass.
