public with sharing class WarehouseCalloutService {

    private static final String WAREHOUSE_URL = 'https://th-superbadge-apex.herokuapp.com/equipment';
    
@future
    public static void runWarehouseEquipmentSync() {
        //ToDo: complete this method to make the callout (using @future) to the
        //      REST endpoint and update equipment on hand.
       Database.DMLOptions dml = new Database.DMLOptions();
		dml.DuplicateRuleHeader.allowSave = true;

        Http http = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint(WAREHOUSE_URL);
        req.setMethod('GET');
        HttpResponse res = http.send(req);
        List<Product2> equipList = new List<Product2>();
        if(res.getStatusCode()==200){
           List< Object> result =(List<Object>)JSON.deserializeUntyped(res.getBody());       
         //  System.debug(result);
           for(Object prodMap: result){
               Map<String,Object> prod = (Map<String,Object>)prodMap;
                Product2 newprod = new Product2();
              //  newprod.ExternalId=(String)prod.get('_id');
                 newprod.Replacement_Part__c=true;
                newprod.Cost__c=(Decimal)prod.get('cost');
                 newprod.Current_Inventory__c=(Decimal)prod.get('quantity');
                newprod.Lifespan_Months__c=(Double)prod.get('lifespan');
                 newprod.Name=(String)prod.get('name');
                 newprod.Maintenance_Cycle__c=(Integer)prod.get('maintenanceperiod');
                 newprod.ExternalId=(String)prod.get('sku');
                equipList.add(newprod);
            }
        List< Database.SaveResult> sr = Database.update(equipList, dml);
        }
                
    }
}