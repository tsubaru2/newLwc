import { LightningElement, api, wire } from 'lwc';

import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import JOBLISTING_OBJECT from '@salesforce/schema/JobListing__c';
import SUMMARY_FIELD from '@salesforce/schema/JobListing__c.Summary__c';
import STATUS_FIELD from '@salesforce/schema/JobListing__c.Status__c';
import ACCOUNTNAME_FIELD from '@salesforce/schema/JobListing__c.Account__r.Name';




export default class JobListComponent extends LightningElement {
    
    //Record Id from the page
    @api recordId;

    // Object name from the Object schema
    objectApiName = JOBLISTING_OBJECT;

    /* Load Joblisting.Summary for custom rendering */
    @wire(getRecord, { recordId: '$recordId', fields: [SUMMARY_FIELD, STATUS_FIELD, ACCOUNTNAME_FIELD] })
    record;

    /** Get the Joblisting.Summary value. */
    get textValue() {
        return this.record.data ? getFieldValue(this.record.data, SUMMARY_FIELD) : '';
    }

    /** Get the Joblisting.Status value. */
    get statusValue() {
        return this.record.data ? getFieldValue(this.record.data, STATUS_FIELD) : '';
    }

    /** Get the Joblisting.Account.Name value. */
    get accountNameValue() {
        return this.record.data ? getFieldValue(this.record.data, ACCOUNTNAME_FIELD) : '';
    }

    //fields = ['Name', 'JobSector__c', 'JobType__c', 'SkillType__c','Status__c'];

}