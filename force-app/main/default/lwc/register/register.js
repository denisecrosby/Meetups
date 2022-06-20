//import { LightningElement, api } from 'lwc';
import {
    LightningElement,
    wire
} from 'lwc';
import {
    CurrentPageReference
} from 'lightning/navigation';
import {
    ShowToastEvent
} from 'lightning/platformShowToastEvent';
import getMeetup from '@salesforce/apex/RegistrationController.getMeetup';

import FIRSTNAME_FIELD from '@salesforce/schema/MeetupRegistration__c.FirstName__c';
import LASTNAME_FIELD from '@salesforce/schema/MeetupRegistration__c.LastName__c';
import EMAIL_FIELD from '@salesforce/schema/MeetupRegistration__c.Email__c';

export default class Register extends LightningElement {

    error;

    currentPageReference = null;
    urlStateParameters = null;

    /* Params from Url */
    urlMeetupCode = null;

    objectApiName = 'MeetupRegistration__c';

    fields = [FIRSTNAME_FIELD, LASTNAME_FIELD, EMAIL_FIELD];

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (!this.urlMeetupCode && currentPageReference) {
            this.urlStateParameters = currentPageReference.state;
            this.setParametersBasedOnUrl();
        }
    }

    setParametersBasedOnUrl() {
        this.urlMeetupCode = this.urlStateParameters.c__code || null;
    }

    handleSubmit(event) {
        event.preventDefault();
        // Get data from submitted form
        const fields = event.detail.fields;
        // Execute logic to get meetup ID before submit
        getMeetup({
            code: this.urlMeetupCode,
            email: fields.Email__c
        })
        .then((result) => {
            this.error = undefined;
            fields.Meetup__c = result;
            this.template.querySelector('lightning-record-form').submit(fields);
        })
        .catch((error) => {
            this.error = error;
            this.showToast('Something went wrong', error.body.message);
            this.meetupID = undefined;
        });
    }

    showToast(title, message) {
        const event = new ShowToastEvent({
            title: title,
            message: message,
            variant: 'error'
        });
        this.dispatchEvent(event);
    }

    handleSuccess(event) {
        const evt = new ShowToastEvent({
            title: 'Registration created',
            message: 'Record ID: ' + event.detail.id,
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}