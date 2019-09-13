/**
 * Created by Yulia Yakushenkova on 12.09.2019.
 */

public with sharing class YandexEdaOfferController {
    public Offer__c offer{get; set;}

    public List<SelectOption> getTypes(){
        Schema.SObjectType sobject_type = Offer__c.getSObjectType();
        Schema.DescribeSObjectResult sobject_describe = sobject_type.getDescribe();
        Map<String, Schema.SObjectField> fieldMap = sobject_describe.fields.getMap();

        List<Schema.PicklistEntry> picklistEntries = fieldMap.get('nds__c').getDescribe().getPicklistValues();

        List<SelectOption> options = new List<SelectOption>();
        for(Schema.PicklistEntry p : picklistEntries)
            options.add(new SelectOption(p.getLabel(), p.getValue()));
        return options;
    }
    public void submit(){

    }
}