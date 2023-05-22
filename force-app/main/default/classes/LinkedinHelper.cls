public with sharing class LinkedinHelper {
  @AuraEnabled
  public static String getLinkedinDetails() {
    http http = new http();
    httprequest req = new httprequest();
    req.setEndpoint('callout:Linkedin/v2/me');
    req.setMethod('GET');
    HTTPResponse res = http.send(req);
    return res.getBody();
  }

  @AuraEnabled
  public static void postLinkedingDetails(String message, String personId) {
    http http = new http();
    httprequest req = new httprequest();
    req.setEndpoint('callout:Linkedin/v2/ugcPosts');
    req.setMethod('POST');
    req.setHeader('Content-Type', 'application/json');
    req.setHeader('X-Restli-Protocol-Version', '2.0.0');
    String author = 'urn:li:person:' + personId;
    String body =
      '{' +
      '"author": "' +
      author +
      '", ' +
      '"lifecycleState": "PUBLISHED", ' +
      '"specificContent": { ' +
      '"com.linkedin.ugc.ShareContent": { ' +
      '"shareCommentary": { ' +
      '"text": "' +
      message +
      '"}, ' +
      '"shareMediaCategory": "NONE" ' +
      '}' +
      '},' +
      '"visibility": {' +
      '"com.linkedin.ugc.MemberNetworkVisibility": "PUBLIC"' +
      '}' +
      '}';
    System.debug('body ' + body);
    req.setBody(body);
    req.setTimeout(120000);
    HTTPResponse res = http.send(req);

    system.debug('res ' + res.getBody());
  }
}
