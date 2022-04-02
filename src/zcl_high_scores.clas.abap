class zcl_high_scores definition
  public
  final
  create public .

  public section.

    types integertab type standard table of i with empty key.

    methods constructor
      importing
        scores type integertab.

    methods list_scores
      returning
        value(result) type integertab.

    methods latest
      returning
        value(result) type i.

    methods personalbest
      returning
        value(result) type i.

    methods personaltopthree
      returning
        value(result) type integertab.
  protected section.
  private section.
    data scores_list type integertab.

endclass.


class zcl_high_scores implementation.

  method constructor.
    me->scores_list = scores.
  endmethod.

  method list_scores.
    result = scores_list.
  endmethod.

  method latest.
    result = scores_list[ lines( scores_list ) ].
  endmethod.

  method personalbest.
    result = reduce i(
        init x = 0
        for n in scores_list
        next x = cond #( when n > x then n else x ) ).
  endmethod.

  method personaltopthree.
    result = scores_list.
    sort result by table_line descending.
    delete result from 4.
  endmethod.


endclass.