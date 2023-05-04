@isTest
global with sharing class phoneValidatorMockResponse implements HttpCalloutMock {
  global Httpresponse respond(HttpRequest req) {
    Httpresponse response = new HttpResponse();
    response.setStatusCode(200);
    String responseBody =
      '{' +
      ' "valid": true, ' +
      '  "number": "14158586273", ' +
      ' "local_format": "4158586273", ' +
      ' "international_format": "+14158586273", ' +
      ' "country_prefix": "+1", ' +
      ' "country_code": "US", ' +
      ' "country_name": "United States of America", ' +
      ' "location": "Novato", ' +
      ' "carrier": "AT&T Mobility LLC", ' +
      ' "line_type": "mobile" ' +
      '}';
    response.setBody(responseBody);
    response.setStatus('OK');
    return response;
  }
}
