/**
 * Created by Yulia Yakushenkova on 20.09.2019.
 */

public with sharing class AccountTriggerHandler {
    public static void delAccountRelationship(List<Account> accountsToDelete){
        List<Offer__c> offersToDelete = new List<Offer__c>();
        for(Account delAccount : accountsToDelete){
            Offer__c delOffer = [SELECT Id FROM Offer__c WHERE Id =: delAccount.Offer_Name__c];
            offersToDelete.add(delOffer);
        }
        try{
            delete offersToDelete;
            delete accountsToDelete;
        }catch(Exception e){

        }
    }
}