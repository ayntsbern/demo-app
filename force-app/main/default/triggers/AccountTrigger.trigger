/**
 * Created by Yulia Yakushenkova on 20.09.2019.
 */

trigger AccountTrigger on Account (before delete) {
    if(Trigger.isDelete & Trigger.isBefore) AccountTriggerHandler.delAccountRelationship(Trigger.old);
}