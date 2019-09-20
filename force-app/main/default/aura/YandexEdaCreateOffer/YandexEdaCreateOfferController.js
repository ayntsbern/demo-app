/**
 * Created by user on 17.09.2019.
 */

({
  // init: function(component, event, helper) {
  //   let action = component.get("c.hasOffer");
  //   action.setParams({
  //     "ID": component.get("v.recordId")
  //   });
  //
  //   action.setCallback(this, function(response) {
  //     if (response.getState() === "SUCCESS")
  //       if (response.getState().getReturnValue() === true) {
  //       component.set("v.hasErrors", true);
  //     // } else {
  //     //   var a = component.get('c.loadData');
  //       }
  //   });
  //   $A.enqueueAction(action);
  // },

  init: function(component, event, helper) {
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
        component.set("v.data", rows);
      }
    });
    component.set("v.columns", [
      { label: "Контакт", fieldName: "Name", type: "text" },
      { label: "Ресторан", fieldName: "AccountName", type: "text" },
      { label: "Email", fieldName: "Email", type: "email" }
    ]);
    $A.enqueueAction(action);
  },

  updateSelectedText: function(component, event) {
    var selectedRow = event.getParam("selectedRows");
    component.set("v.currIDContact", selectedRow[0].Email);
  },

  createNewOffer: function(component, event, helper) {
    let action = component.get("c.createOffer");
    action.setParams({
      "accID": component.get("v.recordId")
    });
    action.setCallback(this, function(response) {
      if (response.getReturnValue()) {
        component.set("v.hasConfirm", true);
        component.set("v.hasErrors", false);

        // let email = component.get("v.sendEmail");
        // email.setParams({
        //   "contactId": component.get("v.currIDContact"),
        //   "accID" : component.get("v.recordId")
        // });
        // email.setCallback(this, function(emailResponse) {
        //   component.set("v.offerLink", emailResponse.getReturnValue());
        // });
        event.getSource().set("v.disabled", true);
      } else {
        component.set("v.hasErrors", true);
        component.set("v.hasConfirm", false);
      }
    });

    $A.enqueueAction(action);
  },

  cancel: function(component, event, helper) {
    $A.get("e.force:closeQuickAction").fire();
  }
});