/**
 * Created by user on 17.09.2019.
 */

({
  // doInit: function(component, event, helper) {
  //   let action = component.get("c.getInitData");
  //   action.setParams({
  //     "ID": component.get("v.recordId")
  //   });
  //   //console.log(component.get("v.recordId"));
  //
  //   action.setCallback(this, function(response) {
  //     //console.log(response.getReturnValue);
  //     if (response.getState() === "SUCCESS") {
  //       let initData = response.getReturnValue();
  //       //console.log(initData.)
  //       component.set("v.tableRows", initData);
  //     }
  //   });
  //   // Queue this action to send to the server
  //   $A.enqueueAction(action);
  // },
  init: function (component, event, helper) {
    let action = component.get("c.getInitData");
    action.setParams({
      "ID": component.get("v.recordId")
    });



    action.setCallback(this, function(response) {
      if (response.getState() === "SUCCESS") {
        let initData = response.getReturnValue();
        component.set("v.data", initData);
        var rows = response.getReturnValue();
        for (var i = 0; i < rows.length; i++) {
          var row = rows[i];
          if (row.Account) row.AccountName = row.Account.Name;
        }
        component.set('v.data', rows);
      }
    });
    component.set('v.columns', [
      {label: 'Контакт',  fieldName: 'Name',  type: 'text'},
      {label: 'Ресторан', fieldName: 'AccountName',  type: 'text'},
      {label: 'Email',    fieldName: 'Email', type: 'email'},
    ]);
    $A.enqueueAction(action);
  },

  updateSelectedText: function (component, event) {
    var selectedRow = event.getParam('selectedRows');
    component.set("v.currIdContact", selectedRow[0].Id);
  },

  createNewOffer: function(component, event, helper) {
    let action = component.get("c.createOffer");
    action.setParams({
      "accID": component.get("v.recordId")
    });
    action.setCallback(this, function(response) {
      if (response.getReturnValue()){
        component.set("v.hasConfirm", true);
        component.set("v.hasErrors", false);
      } else {
        component.set("v.hasErrors", true);
        component.set("v.hasConfirm", false);
      }
    });

    let email = component.get("v.sendEmail");
    email.setParams({
      "contactId": 'MLLLLLya'
    });
    $A.enqueueAction(action);
  },

  cancel : function(component, event, helper) {
    $A.get("e.force:closeQuickAction").fire();
  }
});