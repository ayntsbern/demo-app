/**
 * Created by Yulia Yakushenkova on 17.09.2019.
 */

public with sharing class YandexEdaCreateOfferController {

    @AuraEnabled
    public static List<Contact> getInitData(String ID){
        return [SELECT Id, Name, Account.Name, Email FROM Contact WHERE AccountId =: ID LIMIT 1];
    }
}