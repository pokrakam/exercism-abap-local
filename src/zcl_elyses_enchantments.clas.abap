class zcl_elyses_enchantments definition
  public
  final
  create public .

  public section.

    types ty_stack type standard table of i with empty key.

    "! Get card at position
    methods get_item
      importing stack         type ty_stack
                position      type i
      returning value(result) type i.

    "! Replace card at position
    methods set_item
      importing stack         type ty_stack
                position      type i
                replacement   type i
      returning value(result) type ty_stack.

    "Add card to stack
    methods insert_item_at_top
      importing stack         type ty_stack
                new_card      type i
      returning value(result) type ty_stack.

    "! Remove card at position
    methods remove_item
      importing stack         type ty_stack
                position      type i
      returning value(result) type ty_stack.

    "! Remove top card (last row)
    methods remove_item_from_top
      importing stack         type ty_stack
      returning value(result) type ty_stack.

    "! Add card to bottom of stack (first row)
    methods insert_item_at_bottom
      importing stack         type ty_stack
                new_card      type i
      returning value(result) type ty_stack.

    "! Remove bottom card (delete first row)
    methods remove_item_from_bottom
      importing stack         type ty_stack
      returning value(result) type ty_stack.

    "! Count cards
    methods get_size_of_stack
      importing stack         type ty_stack
      returning value(result) type i.

  protected section.
  private section.
endclass.


class zcl_elyses_enchantments implementation.

  method get_item.
    result = stack[ position ].
  endmethod.


  method set_item.

    result = stack.

    " abaplint issue #2452, can't do: result[ position ] = replacement.

    read table result index position assigning field-symbol(<card>).
    if <card> is assigned.
      <card> = replacement.
    endif.

  endmethod.


  method insert_item_at_top.
    result = stack.
    append new_card to result.
  endmethod.


  method get_size_of_stack.
    result = lines( stack ).
  endmethod.


  method insert_item_at_bottom.
    result = stack.
    insert new_card into result index 1.
  endmethod.


  method remove_item.
    result = stack.
    delete result index position.
  endmethod.


  method remove_item_from_bottom.
    result = stack.
    delete result index 1.
  endmethod.


  method remove_item_from_top.
    result = stack.
    delete result index lines( stack ).
  endmethod.


endclass.