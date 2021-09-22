import { LightningElement, api, wire } from 'lwc';

import NAME_FIELD from '@salesforce/schema/JobListing__c.Name';
import STATUS_FIELD from '@salesforce/schema/JobListing__c.Status__c';
import SKILL_FIELD from '@salesforce/schema/JobListing__c.SkillType__c';
import TYPE_FIELD from '@salesforce/schema/JobListing__c.JobType__c';


export default class EditJobListing extends LightningElement {

    @api recordId;
    @api objectApiName;

    fields = [NAME_FIELD,STATUS_FIELD, SKILL_FIELD, TYPE_FIELD];

    handleReset(event){
        console.log(event.detail);
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
                field.reset();
            });
        }
    }
}