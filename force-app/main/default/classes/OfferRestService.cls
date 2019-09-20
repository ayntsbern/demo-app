/**
 * Created by Yulia Yakushenkova on 20.09.2019.
 */

@RestResource(UrlMapping='/offerstatus')
global with sharing class OfferRestService {

    @HttpGet
    global static List<Offer__c> getRecord() {
        return [SELECT Id, RestName__c, Status__c FROM Offer__c];
    }

    @HttpPost
    global static Offer__c getOfferStatus(String Id) {
        Offer__c offer = [SELECT Id, RestName__c, Status__c FROM Offer__c WHERE Id =: Id];
        //return JSON.serialize(offer);
        return offer;
    }
}