public class TestUncommittedError {
    
public void updateAndMakeCallout(Account reqLines){
            Savepoint sp = Database.setSavepoint();            try {

                       

                        insert reqLines;

                        WarehouseCalloutService.runWarehouseEquipmentSync();

            } catch (Exception e){

                        Database.rollback(sp);

                        System.debug(e);

            }

}
}