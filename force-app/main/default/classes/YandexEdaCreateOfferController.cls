/**
 * Created by Yulia Yakushenkova on 17.09.2019.
 */

public with sharing class YandexEdaCreateOfferController {

    @AuraEnabled
    public static Boolean hasOffer(String ID) {
        Account acc = [SELECT Id, Offer_Name__c FROM Account WHERE Id = :ID];

        if (acc.Offer_Name__c != null) return true;
            else return false;
    }

    @AuraEnabled
    public static List<Contact> getInitData(String ID) {
        return [SELECT Id, Name, Account.Name, Email FROM Contact WHERE AccountId = :ID];

    }

    @AuraEnabled
    public static Boolean createOffer(String accID) {
        Account account = [SELECT Id, Offer_Name__c FROM Account WHERE Id = :accID];
        if (account.Offer_Name__c != null) return false;
        Offer__c offer = new Offer__c();
        try {
            insert offer;
            account.Offer_Name__c = offer.Id;
            update account;
        } catch (Exception e) {
            return false;
        }
        return true;
    }

    @AuraEnabled
    public static String sendEmail(String contactID, String accID) {
        //Boolean result = false;
        Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
        String[] toAddresses = new String[]{
                contactID
        };
        message.setToAddresses(toAddresses);
        message.subject = 'YandexEdaaaaaaaa';

        message.setHtmlBody('Hello, <br/>');

        String url = 'https://sandbox-ayntsbern-developer-edition.cs83.force.com/newpartner/YandexEdaOffer?ID=' + accID;
        Messaging.SingleEmailMessage[] messages =
                new List<Messaging.SingleEmailMessage>{
                        message
                };
        Messaging.sendEmail(messages);

        return url;
    }
}