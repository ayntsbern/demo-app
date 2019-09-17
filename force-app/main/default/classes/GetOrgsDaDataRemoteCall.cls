/**
 * Created by Yulia Yakushenkova on 14.09.2019.
 */

public with sharing class GetOrgsDaDataRemoteCall {

    public static String getResponse(String query){
        HttpRequest req = new HttpRequest();

        req.setEndpoint('https://suggestions.dadata.ru/suggestions/api/4_1/rs/suggest/party');
        req.setMethod('POST');

        Map<String, String> headersMap = new Map<String, String>();
        headersMap.putAll(new Map<String, String>{
                'Content-Type' => 'application/json; charset=utf-8',
                'Accept' => 'application/json',
                'Authorization' => 'Token 5906a8f9e54166b25e4538bfc6b9b61371c1c167'
        });

        for(String headerName: headersMap.keySet()){
            req.setHeader(headerName, headersMap.get(headerName));
        }

        String requestBodySource = query;
        System.debug('>>> Request Body: ' + requestBodySource);
        if(requestBodySource != null) req.setBody(requestBodySource);

        Integer timeout = 120000;
        req.setTimeout(timeout);

        HttpResponse res;
        Http http = new Http();
        try{
            res = http.send(req);
            System.debug('RESPONSE STATUS: ' + res.getStatusCode() + ' ' + res.getStatus());
        } catch(Exception e){
            String errorMessage = e.getMessage() + ' ' + e.getStackTraceString();
            System.debug('ERROR: ' + errorMessage);
        } finally {
            System.debug(res.getStatus());
        }


    return res.getBody();
    }

    public static Map<String, Object> getInfoOrg(String nameOrINN){
        String jsonResponse = getResponse('{ "query" : "' + nameOrINN + '" }');
        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(jsonResponse);
        List<Object> lstOrg = (List<Object>) results.get('suggestions');
        Object[] aryOrg = (Object[]) results.get('suggestions');

        String name;
        Map<String, Object> orgValues = new Map<String, Object>();
        List<Object> orgInfo = new List<Object>();


        for (Object org : lstOrg) {
            // now get attributes for this customer.
            Map<String, Object> orgAttributes = (Map<String, Object>)org;
            // now loop through our customer attributes.
            for (String attributeName : orgAttributes.keySet())
                if(attributeName == 'unrestricted_value') orgValues.put('name',
                        orgAttributes.get(attributeName));
                else if(attributeName == 'data'){
                    orgInfo.add(orgAttributes.get(attributeName));
                    break;
                }
        }
        List<Object> orgAddress = new List<Object>();
        for(Object o : orgInfo){
            Map<String, Object> orgAttributes = (Map<String, Object>)o;
            for (String attributeName : orgAttributes.keySet())
                if(attributeName == 'kpp' || attributeName == 'inn' || attributeName == 'ogrn')
                    orgValues.put(attributeName, orgAttributes.get(attributeName));
                else if(attributeName == 'address'){
                    orgAddress.add(orgAttributes.get(attributeName));
                    break;
                }
        }
        List<Object> fullorgAddress = new List<Object>();
        for(Object address : orgAddress){
            Map<String, Object> orgAttributes = (Map<String, Object>)address;
            for (String attributeName : orgAttributes.keySet())
                if(attributeName == 'data'){
                    fullorgAddress.add(orgAttributes.get(attributeName));
                    break;
                }
        }

        for(Object address : fullorgAddress){
            Map<String, Object> orgAttributes = (Map<String, Object>)address;
            for (String attributeName : orgAttributes.keySet())
                if(attributeName == 'postal_code' || attributeName == 'city_with_type' || attributeName == 'street_with_type')
                    orgValues.put(attributeName, orgAttributes.get(attributeName));
                else if(attributeName == 'house'){
                    orgValues.put(attributeName, orgAttributes.get(attributeName));
                    break;
                }
        }
        for(String key : orgValues.keySet()) System.debug(key + ' ' + orgValues.get(key));
        return orgValues;
    }

}