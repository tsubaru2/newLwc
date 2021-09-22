import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';

export default class Quickdonebutton extends NavigationMixin(LightningElement) {

    handleListViewNavigation() {
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'WorkflowBatch__c',
                actionName: 'list'
            },
            state: {
                // 'filterName' is a property on 'state'
                // and identifies the target list view.
                // It may also be an 18 character list view id.
                // or by 18 char '00BT0000002TONQMA4'
                //filterName: 'AllUploadedAccounts' 
                filterName: '00B5g00000OEY3GEAX'
            }
        });
    }
}