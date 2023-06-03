*&---------------------------------------------------------------------*
*& Report ZISS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT ZISS.


DATA: http_client TYPE REF TO if_http_client,
      response    TYPE string.

TRY.
    " Create HTTP client with the Open Notify API endpoint
    cl_http_client=>create_by_url(
        EXPORTING
            url    = 'http://api.open-notify.org/iss-now.json'
        IMPORTING
            client = http_client
    ).

    " Set request method to GET
    http_client->request->set_method( 'GET' ).

    " Send the request
    http_client->send( ).

    " Receive the response
    http_client->receive( ).

    " Get response body
    response = http_client->response->get_cdata( ).

    " Print the raw response
    WRITE: / 'Response:', response.

CATCH cx_root INTO DATA(exception).
    " Error handling
    WRITE: / 'Exception occurred:', exception->get_text( ).
    IF http_client->response IS BOUND.
      response = http_client->response->get_cdata( ).
      WRITE: / 'Response:', response.
    ENDIF.
ENDTRY.
