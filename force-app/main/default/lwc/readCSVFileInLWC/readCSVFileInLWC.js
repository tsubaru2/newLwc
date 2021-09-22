import { LightningElement, track, api } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import csvFileRead from '@salesforce/apex/CSVFileReadLWCCntrl.csvFileRead';


/*const columnsAccount = [
    { label: 'Name', fieldName: 'Name' }, 
    { label: 'Source', fieldName: 'AccountSource' },
    { label: 'Account Site', fieldName: 'Site'}, 
    { label: 'Type', fieldName: 'Type'}, 
    { label: 'Website', fieldName: 'Website', type:'url'},
    { label: 'Message', fieldName: 'Message__c'}
];*/

const columnsAccount = [
    { label: 'Workflow ID', fieldName: 'WorkflowID__c' },
    { label: 'Cert Type', fieldName: 'CertType__c' },
    { label: 'Number of Certs', fieldName: 'Number_Of_Certs__c' },
    { label: 'Vintage', fieldName: 'Vintage__c' }, 
    { label: 'RESA/PRSA Identifier', fieldName: 'RESAPRSAIdentifier__c' },
    { label: 'Message', fieldName: 'Message__c' }
];

export default class ReadCSVFileInLWC extends LightningElement {
    @api recordId;
    @track error;
    @track columnsAccount = columnsAccount;
    @track data;

    @track doneButton = false;
    @track onloadVisibile = false;

    @track customFormModal = false;

    //toggleIconName = 'utility:preview';
    //toggleButtonLabel = 'Hide content';
    customShowModalPopup() {            
        this.customFormModal = true;
    }
 
    customHideModalPopup() {    
        
        this.customFormModal = false;
    }



    // accepted parameters
    get acceptedCSVFormats() {
        return ['.csv'];
    }

    uploadFileHandler(event) {
        // Get the list of records from the uploaded files
        const uploadedFiles = event.detail.files;
        this.onloadVisibile = true;

        // calling apex class csvFileread method
        csvFileRead({contentDocumentId : uploadedFiles[0].documentId})
        .then(result => {
            window.console.log('result ===> '+result);
            window.console.log('result ===> '+ JSON.stringify(result[0]));            

            for(let i = 0; i < result.length; i++){                
                let msg = result[i]["Message__c"];                
                if(result[i]["Message__c"].includes("Error")){                    
                    this.doneButton = true;
                }
            }
            
            this.data = result;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!!',
                    message: 'CSV file has been uploaded!!!',
                    variant: 'Success',
                }),
            );
        })
        .catch(error => {
            this.error = error;
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error!!',
                    message: JSON.stringify(error),
                    variant: 'error',
                }),
            );     
        })

    }
}