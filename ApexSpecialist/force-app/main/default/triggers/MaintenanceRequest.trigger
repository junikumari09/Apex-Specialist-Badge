trigger MaintenanceRequest on Case (before update, after update,before insert) {
    if(Trigger.isBefore && Trigger.isInsert){
        WarehouseCalloutService.runWarehouseEquipmentSync();
    }
    // ToDo: Call MaintenanceRequestHelper.updateWorkOrders
   				if(Trigger.isAfter)
                	MaintenanceRequestHelper.updateWorkOrders(Trigger.New);
                
            
    }