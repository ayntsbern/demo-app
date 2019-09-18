/**
 * Created by user on 17.09.2019.
 */

({
  doInit: function(component, event, helper) {
    let action = component.get("c.getInitData");
    action.setParams({
        "ID": component.get("v.recordId")
    });
    //console.log(component.get("v.recordId"));

    action.setCallback(this, function(response) {
      //console.log(response.getReturnValue);
      if (response.getState() === "SUCCESS") {
        let initData = response.getReturnValue();
        //console.log(initData.)
        component.set("v.tableRows", initData);
      }
    });
    // Queue this action to send to the server
    $A.enqueueAction(action);
  }
});