public with sharing class PostalCode 
{

    // using pincode
    @AuraEnabled(cacheable=true)
    public static List<PostalCodesWrapper> getPostalDetails(string pincode)
    {
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.postalpincode.in/pincode/'+pincode);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        List<PostalCodesWrapper> postalCodesList = new List<PostalCodesWrapper>();     
        if(res.getStatusCode() == 200)
        {
            //system.debug('body--'+res.getBody());
            List<Object> result = (List<Object>)Json.deserializeUntyped(res.getBody());
            //system.debug('result--'+result);
			for(Object detail : result)
            {
                //system.debug('detail--'+detail);
                Map<String, Object> finalresult = (Map<String, Object>)detail;
                //system.debug('finalresult--'+finalresult);
                //system.debug('postoffice--'+finalresult.get('PostOffice'));
                List<Object> finalresult2 = (List<Object>)finalresult.get('PostOffice');
                //system.debug(finalresult2);
                for(Object detail2 : finalresult2)
                {
                    Map<String, Object> finalresult3 = (Map<String, Object>)detail2;
                    //system.debug('finalresult3--'+finalresult3);
                    //system.debug(finalresult3.get('Name'));
                    PostalCodesWrapper info = new PostalCodesWrapper();
                    info.Name = (string)finalresult3.get('Name');
                    info.BranchType = (string)finalresult3.get('BranchType');
                    info.Circle = (string)finalresult3.get('Circle');
                    info.District = (string)finalresult3.get('District');
                    info.State = (string)finalresult3.get('State');
                    postalCodesList.add(info);
                }
            }
        }
        else
        {           
            system.debug('status code'+res.getStatusCode());            
        }
        return postalCodesList;
    }
    // using name
    @AuraEnabled(cacheable=true)
    public static List<PostalCodesWrapperByName> getPostalDetailsByName(string name)
    {
       Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://api.postalpincode.in/postoffice/'+name);
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        List<PostalCodesWrapperByName> postalCodesListByName = new List<PostalCodesWrapperByName>();
        if(res.getStatusCode() == 200)
        {
            List<Object> result = (List<Object>)Json.deserializeuntyped(res.getBody());
            for(Object detail : result)
            {

                Map<String, Object> finalresult = (Map<String, Object>)detail;
                List<object> finalresult2 = (List<object>)finalresult.get('PostOffice');
                for(Object detail2 : finalresult2)
                {
                    Map<String, Object> finalresult3 = (Map<String, Object>)detail2;
                    PostalCodesWrapperByName info = new PostalCodesWrapperByName();
                    info.Name = (string)finalresult3.get('Name');
                    info.BranchType = (string)finalresult3.get('BranchType');
                    info.Circle = (string)finalresult3.get('Circle');
                    info.District = (string)finalresult3.get('District');
                    info.State = (string)finalresult3.get('State');
                    info.Division = (string)finalresult3.get('Division');
                    info.Pincode = (string)finalresult3.get('Pincode');
                    postalCodesListByName.add(info);
                }
            }
        }
        else
        {
            system.debug('status code'+res.getStatusCode()); 
        }
        return postalCodesListByName;
    }
    public class PostalCodesWrapper
    {
        @AuraEnabled public string Name {get;set;}
        @AuraEnabled public string BranchType {get;set;}
        @AuraEnabled public string Circle {get;set;}
        @AuraEnabled public string District {get;set;}
        @AuraEnabled public string State {get;set;}
    }
    public class PostalCodesWrapperByName
    {
        @AuraEnabled public string Name {get;set;}
        @AuraEnabled public string BranchType {get;set;}
        @AuraEnabled public string Circle {get;set;}
        @AuraEnabled public string District {get;set;}
        @AuraEnabled public string Division {get;set;}
        @AuraEnabled public string State {get;set;} 
        @AuraEnabled public string Pincode {get;set;}
    }
}