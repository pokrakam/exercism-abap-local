class zcl_clock definition
  public
  create public.

  public section.

    methods constructor importing hours   type i
                                  minutes type i default 0.
    methods get returning value(result) type string.
    methods add importing minutes type i.
    methods sub importing minutes type i.

  private section.
    data time type t.

endclass.



class zcl_clock implementation.

  method constructor.
    time = hours * 3600 + minutes * 60.
  endmethod.

  method add.
    time = time + minutes * 60.
  endmethod.

  method get.
    result = |{ time(2) }:{ time+2(2) }|.
  endmethod.

  method sub.
    time = time - minutes * 60.
  endmethod.

endclass.
