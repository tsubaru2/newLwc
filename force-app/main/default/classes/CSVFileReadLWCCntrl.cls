public with sharing class CSVFileReadLWCCntrl {
    /*public CSVFileReadLWCCntrl() {

    }*/

    @AuraEnabled
    //public static list<Account> csvFileRead(Id contentDocumentId){
        public static list<WorkflowTask__c> csvFileRead(Id contentDocumentId){

        Boolean isFileNotCorrect = false;
        String taskMessage;
        //list<Account> accountInsertList = new list<Account>();
        //List<WorkflowTask__c> wtasksList = new List<WorkflowTask__c>();
        List<ImplementationData__c> impDataList = new List<ImplementationData__c>();    
        WorkflowTask__c wtaskObj = new WorkflowTask__c();

        if(contentDocumentId != null) {
            
            // Fetch File Data based on the basic of document id 
            ContentVersion contentVersionObj = [SELECT Id, VersionData FROM ContentVersion WHERE ContentDocumentId =:contentDocumentId];
            // split the file data
            list<String> csvRecordsList = contentVersionObj.VersionData.toString().split('\n');

            
            wtaskObj.Status__c = 'Initial Upload Complete';
            wtaskObj.RESAPRSAIdentifier__c = 'GHGR00011A/1';
            wtaskObj.CertType__c = 'ESC';
            wtaskObj.WorkflowID__c = '878111';                        

            WorkflowBatch__c wbFlowBatch = new WorkflowBatch__c();
            wbFlowBatch.Accreditation__c = 'RESA AQ2128';
            wbFlowBatch.CertificateType__c = 'ESC';
            wbFlowBatch.Ownership__c = 'EnergySafe Pty Ltd';
            wbFlowBatch.Range__c = '5500-5550';
            wbFlowBatch.Reference__c = 'Imp8188';
            wbFlowBatch.Status__c = 'Active';
            wbFlowBatch.Vintage__c = '2021';
            insert wbFlowBatch;


            wtaskObj.WorkflowBatch__c = wbFlowBatch.id;

            for(Integer i = 1; i < csvRecordsList.size(); i++){
                //Account accountObj = new Account();
                
                ImplementationData__c impData = new ImplementationData__c();
                list<String> csvRowData = csvRecordsList[i].split(',');
                System.debug('csvRowData====> '+csvRowData);

                impData.Implementation_Date__c = System.Date.today();
                //impData.Implementation_Date__c = Date.valueOf(csvRowData[0]);
                impData.Address_Line_1__c = csvRowData[1];
                impData.Address_Line_2__c = csvRowData[2];
                impData.Suburb__c = csvRowData[3];
                impData.State__c = csvRowData[4];
                impData.Postcode__c = csvRowData[5];
                impData.ABN__c = csvRowData[6];
                impData.ElectricitySavingsMWh__c = Integer.valueOf(csvRowData[7]);
                impData.GasSavingsMWh__c = 10;
                //impData.GasSavingsMWh__c = Integer.valueOf(csvRowData[8]);
                impData.WorkflowBatch__c = wbFlowBatch.Id;

                impDataList.add(impData);

                //wtaskObj.WorkflowID__c = csvRowData[0];
                //wtaskObj.Registrant__c = csvRowData[1];
                //wtaskObj.NumberOfCerts__c = Integer.valueOf(csvRowData[4]);
                //wtaskObj.Vintage__c = Integer.valueOf(csvRowData[5]);
                


                //accountObj.Name = csvRowData[0]; // accName
                //accountObj.AccountSource = csvRowData[1];
                //accountObj.Site = csvRowData[2];
                //accountObj.Type = csvRowData[3];
                //accountObj.Website = csvRowData[4];
                System.debug('isFineNotCorrect:::::' + isFileNotCorrect);
                System.debug('csvRowData[1]:::::' + csvRowData[1]);
                System.debug('csvRowData[1] ==null:::::' + csvRowData[1] ==null);    
                System.debug('csvRowData[1].length()==0:::::' + csvRowData[1].length()); 

                
                if(!isFileNotCorrect && (csvRowData[1] ==null  ||  csvRowData[1].length()==0)){                    
                    //taskMessage='Success';
                //}else{
                    //taskMessage='Error: No RESA PRSA Identifier Not Available';
                    isFileNotCorrect = true;
                }                
            
                //accountInsertList.add(accountObj);
            }

            System.debug('isFineNotCorrect:::::' + isFileNotCorrect);


            if(isFileNotCorrect){
                wtaskObj.Message__c = 'Error: Validation Failed';
            }else{
                wtaskObj.Message__c = 'Success';
            }
            insert wtaskObj;
            
            //wtasksList.add(wtaskObj);

            try{                
                if(!impDataList.isEmpty()) {
                    insert impDataList;
                }
                

                //if(!accountInsertList.isEmpty()) {
                    //insert accountInsertList;
                //if(!wtasksList.isEmpty()){
                //    insert wtasksList;

                    /*if(!isFileNotCorrect){
                        //Create a Workflow batch
                        WorkflowBatch__c wbc = new WorkflowBatch__c();
                        insert wbc;

                        //Create Certificate records
                        List<WorkflowCertificate__c> certList = new List<WorkflowCertificate__c>();
                        for(WorkflowTask__c wtc: wtasksList){

                            for(Integer i=0 ;  i < wtc.NumberOfCerts__c ; i++){
                            WorkflowCertificate__c cert = new WorkflowCertificate__c();
                            //cert.Account__c = acc.Id;
                            cert.Batch__c = wbc.Id;
                            cert.WorkflowTask__c = wtc.Id;

                            certList.add(cert);
                            }
                        }

                        if(!certList.isEmpty()){
                            insert certList;
                        }
                    }*/
                //}
            }
            catch (Exception ex) {
                throw new AuraHandledException(ex.getMessage());
            }
        }

        List<WorkflowTask__c> wtasksList = [select id,CertType__c,WorkflowID__c,Number_Of_Certs__c,Message__c,Vintage__c,RESAPRSAIdentifier__c from WorkflowTask__c where id = :wtaskObj.id];

        System.debug(wtasksList);
        //return accountInsertList;
        return  wtasksList;   
        //return null;
    }
}