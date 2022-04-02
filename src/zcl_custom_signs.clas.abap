class zcl_custom_signs definition public final.

  public section.

    "! Build a sign that includes both of the parameters.
    methods build_sign importing occasion      type string
                                 name          type string
                       returning value(result) type string.

    "! Build a birthday sign that conditionally formats the return string.
    methods build_birthday_sign importing age           type i
                                returning value(result) type string.

    "! Build a graduation sign that includes multiple lines
    methods graduation_for importing name          type string
                                     year          type i
                           returning value(result) type string.

    "! Determine cost based on each character of sign parameter that builds
    "! the template string that includes the currency parameter.
    methods cost_of importing sign          type string
                              currency      type string
                    returning value(result) type string.

endclass.


class zcl_custom_signs implementation.

  method build_sign.
    result = |Happy { occasion } { name }!|.
  endmethod.

  method build_birthday_sign.
    result = |Happy Birthday! What a { cond #( when age < 50 then `young` else `mature` ) } fellow you are.|.
  endmethod.

  method graduation_for.
    result = |Congratulations { name }!\nClass of { year }|.
  endmethod.

  method cost_of.
    data cost type p length 5 decimals 2.
    cost = ( 20 + strlen( sign ) * 2 ).
    result = |Your sign costs { 20 + strlen( sign ) * 2 decimals = 2 } { currency }.|.
  endmethod.

endclass.