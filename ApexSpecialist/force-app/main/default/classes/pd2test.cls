public class pd2test {
    public void testSP(Account acc){
       // SavePoint sp = Database.setSavepoint();
        try{
            insert acc;
          
       }catch(Exception e){
           // Database.rollback(sp);
        }
		  WarehouseCalloutService.runWarehouseEquipmentSync();
    }
}