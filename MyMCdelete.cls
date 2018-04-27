// Not for implementation - not tested, not optimized, not bulkified, etc, etc, etc - this is purely for example sake
public class MyMCdelete {
    
	  @future(Callout=true)
    public static void myDelete(String subscriberID, String firstName, String lastName){
        
        String clientId = 'your_client_id';
        String clientSecret = 'your_client_secret';
        String username = 'your_username';
        String token = 'your_token_if_applicable';
        String password = 'your_password'+token;
        

        String reqBody = 'grant_type=password&client_id='+clientId+'&client_secret='+clientSecret+'&username='+username+'&password='+password;
        
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setBody(reqBody);
        request.setMethod('POST');
        
        //your endpoint to external system to get token
        request.setEndpoint('https://login.salesforce.com/services/oauth2/token'); 
        
        HttpResponse response = http.send(request);        
        
        OAuth2 objAuthenticationInfo = (OAuth2)JSON.deserialize(response.getbody(), OAuth2.class);
        System.debug('resp: ' + response.getBody());
        System.debug('objAuth: ' + objAuthenticationInfo);
        
        if(objAuthenticationInfo.access_token != null){
            Http http1 = new Http();
            HttpRequest request1 = new HttpRequest();
            
            request1.setHeader('Authorization','Bearer '+objAuthenticationInfo.access_token);
            request1.setHeader('Content-Type','application/json');
            request1.setHeader('accept','application/json');
            
            
            request1.setMethod('DELETE');
            //your actual endpoint, whichever one it is
            request1.setEndpoint('https://na59.salesforce.com/services/data/v41.0/sobjects/Contact/' + subscriberID);
            
			/**
			 * MC Endpoint URL
			 * Good chance you may need to do a POST vs a delete WS
			 */ 
            //request1.setMethod('POST');
            //request1.setBody('{"LastName" : "'+ subscriberID +'"}'); --> this hardcodes JSON but one can use serialization/etc            
            //request1.setEndpoint('https://na59.salesforce.com/services/data/v41.0/sobjects/Contact/');

            
		      	HttpResponse responce1 = http1.send(request1);  
            system.debug('Response Body: '+responce1.getbody());
        }

    }
    
    //Wrapper class esp useful for access_token, that you use afterwards
    public class OAuth2{
        public String id{get;set;}
        public String issued_at{get;set;}
        public String instance_url{get;set;}
        public String signature{get;set;}
        public String access_token{get;set;}    
    }

    
}
