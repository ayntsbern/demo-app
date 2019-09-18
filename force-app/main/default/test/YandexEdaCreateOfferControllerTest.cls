/**
 * Created by Yulia Yakushenkova on 18.09.2019.
 */

@IsTest
private class YandexEdaCreateOfferControllerTest {
    @IsTest
    static void testBehavior() {
        Account acc = new Account(Name = 'IMTEST');
        insert acc;
        System.debug(YandexEdaCreateOfferController.createOffer(acc.Id));
        System.debug([SELECT Offer_Name__c FROM Account WHERE Id = : acc.Id]);
    }
}