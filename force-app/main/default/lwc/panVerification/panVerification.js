import { api, LightningElement, wire } from 'lwc';
import getPanVerified from '@salesforce/apex/ClassManager.getPanVerified';
import getRefreshValues from '@salesforce/apex/ClassManager.getRefreshValues';
import getAadhaarVerified from '@salesforce/apex/ClassManager.getAadhaarVerified';
import getDedupeCheck from '@salesforce/apex/ClassManager.getDedupeCheck'
import { getRecord, getFieldValue, updateRecord } from 'lightning/uiRecordApi';
import PAN_NUMBER from '@salesforce/schema/Lead.Pan_Number__c';
import IS_PAN_VERIFIED from '@salesforce/schema/Lead.Is_pan_verified__c';
import AADHAAR_NUMBER from '@salesforce/schema/Lead.Adhar_Card_Number__c';
import IS_AADHAAR_VERIFIED from '@salesforce/schema/Lead.Is_Adhar_Verified__c';
import CUSTOMER_ID from '@salesforce/schema/Lead.Custumer__r.Customer_Id__c';
//import IS_DEDUPE_CHECK from '@salesforce/schema/Lead.IsDedupeCheck__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import ID_FIELD from "@salesforce/schema/Lead.Id";
const fields = [PAN_NUMBER,IS_PAN_VERIFIED,AADHAAR_NUMBER,IS_AADHAAR_VERIFIED,CUSTOMER_ID];
 
export default class PanVerification extends LightningElement {
@api recordId;
pickListValue;
isPanVerified;
isAadhaarVerified;
isDedupeCheck;
buttonVariantForPAN='brand';
buttonVariantForAadhhar='brand';
buttonVariantForDedupeCheck='brand';
buttonClassForPAN='';
buttonClassForAadhaar='';
buttonClassForDedupeCheck='';
error1;
isLoading=false;
 
connectedCallback(){
    getRefreshValues({recordId : this.recordId})
    .then(result =>{
        this.isPanVerified=result.Is_pan_verified__c;
        this.isAadhaarVerified=result.Is_Adhar_Verified__c;
        this.isDedupeCheck=result.Dedupe_Check__c;
        //For PAN
        if(this.isPanVerified=='Yes'){
            this.buttonVariantForPAN='success';
            this.isLoading=false;
        }
        else if(this.isPanVerified=='No'){
            this.buttonVariantForPAN='destructive';
            this.isLoading=false;
        }
        else{
            this.buttonVariantForPAN='brand';
            this.isLoading=false;
        }
 
        //For Aadhaar
        if(this.isAadhaarVerified=='Yes'){
            this.buttonVariantForAadhhar='success';
            this.isLoading=false;
        }
        else if(this.isAadhaarVerified=='No'){
            this.buttonVariantForAadhhar='destructive';
            this.isLoading=false;
        }
        else{
            this.buttonVariantForAadhhar='brand';
            this.isLoading=false;
        }
 
        //For Dedupe Check
        if(this.isDedupeCheck=='Yes'){
            this.buttonVariantForDedupeCheck='success';
            this.isLoading=false;
        }
        else if(this.isDedupeCheck=='No'){
            this.buttonVariantForDedupeCheck='destructive';
            this.isLoading=false;
        }
        else{
            this.buttonVariantForDedupeCheck='brand';
            this.isLoading=false;
        }
    })
    .catch(error => {});
}
 
@wire (getRecord, { recordId: '$recordId', fields })
lead;
 
get panNumber() {
    return getFieldValue(this.lead.data, PAN_NUMBER);
}
get aadhaarNumber(){
    return getFieldValue(this.lead.data, AADHAAR_NUMBER);
}
get customerId(){
    return getFieldValue(this.lead.data, CUSTOMER_ID);
}
 
 
 
handlePanValidation(event){      
    this.isLoading=true;
    if(this.panNumber==null){
        const event = new ShowToastEvent({
            title: 'Pan Verification',
            variant: 'warning',
            message: 'Pan number field is blank. Please enter Pan number'
        });
        this.dispatchEvent(event);
        this.isLoading=false;
        this.buttonVariantForPAN='brand';
    }
    else{
            getPanVerified({panNumber : this.panNumber, recordId : this.recordId})
                .then(result => {
                    this.result = result;
                    getRefreshValues({recordId : this.recordId})
                    .then(result => {
                   
                        this.isPanVerified=result.Is_Pan_Verified__c;
                       
                        if(this.isPanVerified=='Yes')
                    {
                        const event2 = new ShowToastEvent({
                            title: 'Pan Verification',
                            variant: 'success',
                            message: 'Pan has been verified.',
                        });
                        this.dispatchEvent(event2);
                        this.buttonVariantForPAN='success';
                    }
                    else if(this.isPanVerified=='No'){
                        const event3 = new ShowToastEvent({
                            title: 'Pan Verification',
                            variant: 'warning',
                            message: 'Pan is invalid. Please enter correct Pan Number',
                        });
                        this.dispatchEvent(event3);
                        this.buttonVariantForPAN='destructive';
                    }
                    })
                    .catch(error => {
                        this.error1=error;
                    });
                    this.isLoading=false;          
                })
                .catch(error => {
                    this.error = error;
                    const event4 = new ShowToastEvent({
                        title: 'Pan Verification',
                        variant: 'error',
                        message: 'API failed. No response from server',
                    });
                    this.dispatchEvent(event4);
                    this.buttonClassForPAN='button';
                    this.isLoading=false;
            });
            //window.location.reload(true);
        }
}

handleAadhaarValidation(event){      
    this.isLoading=true;
    if(this.aadhaarNumber==null){
        const event5 = new ShowToastEvent({
            title: 'Aadhaar Verification',
            variant: 'warning',
            message: 'Aadhaar number field is blank. Please enter Aadhaar number',
        });
        this.dispatchEvent(event5);
        this.isLoading=false;
        this.buttonVariantForAadhhar='brand';
    }
    else{
            getAadhaarVerified({aadhaarNumber : this.aadhaarNumber, recordId : this.recordId})
                .then(result => {
                    this.result = result;
                    console.debug('Hello result');
                    getRefreshValues({recordId : this.recordId})
                    .then(result => {
                        this.isAadhaarVerified=result.Is_Adhar_Verified__c;
                    console.debug(this.isAadhaarVerified);
                        if(this.isAadhaarVerified=='Yes')
                    {
                        const event6 = new ShowToastEvent({
                            title: 'Aadhhar Verification',
                            variant: 'success',
                            message: 'Aadhaar has been verified.',
                        });
                        this.dispatchEvent(event6);
                        this.buttonVariantForAadhhar='success';
                    }
                    else if(this.isAadhaarVerified=='No'){
                        const event7 = new ShowToastEvent({
                            title: 'Aadhhar Verification',
                            variant: 'warning',
                            message: 'Aadhaar is invalid. Please enter correct Aadhaar Number',
                        });
                        this.dispatchEvent(event7);
                        this.buttonVariantForAadhhar='destructive';
                    }
                    })
                    .catch(error => {
                        this.error1=error;
                    });
                    this.isLoading=false;          
                })
                .catch(error => {
                    this.error = error;
                    const event8 = new ShowToastEvent({
                        title: 'Aadhaar Verification',
                        variant: 'error',
                        message: 'API failed. No response from server',
                    });
                    this.dispatchEvent(event8);
                    this.buttonClassForAadhaar='button';
                    this.isLoading=false;
            });
        }
}
 
handleDedupeCheck(event){    
    this.isLoading=true;
    if(this.customerId==null){
        const event9 = new ShowToastEvent({
            title: 'Dedupe Check',
            variant: 'warning',
            message: 'Lead is not associated with a customer. Please assign it',
        });
        this.dispatchEvent(event9);
        this.isLoading=false;
        this.buttonVariantForDedupeCheck='brand';
    }
    else{
            getDedupeCheck({customerId : this.customerId, recordId : this.recordId})
                .then(result => {
                    this.result = result;
                    console.debug('Hello result');
                    getRefreshValues({recordId : this.recordId})
                    .then(result => {
                        this.isDedupeCheck=result.Dedupe_Check__c;
                    console.debug(this.isDedupeCheck);
                        if(this.isDedupeCheck=='Yes')
                    {
                        const event10 = new ShowToastEvent({
                            title: 'Dedupe Check',
                            variant: 'success',
                            message: 'No duplicate customer is found',
                        });
                        this.dispatchEvent(event10);
                        this.buttonVariantForDedupeCheck='success';
                    }
                    else if(this.isDedupeCheck=='No'){
                        const event11 = new ShowToastEvent({
                            title: 'Dedupe Check',
                            variant: 'warning',
                            message: 'Duplicate values occurs. Please enter correct values',
                        });
                        this.dispatchEvent(event11);
                        this.buttonVariantForDedupeCheck='destructive';
                    }
                    })
                    .catch(error => {
                        this.error1=error;
                    });
                    this.isLoading=false;          
                })
                .catch(error => {
                    this.error = error;
                    const event12 = new ShowToastEvent({
                        title: 'Dedupe Check',
                        variant: 'error',
                        message: 'API failed. No response from server',
                    });
                    this.dispatchEvent(event12);
                    this.buttonClassForAadhaar='button';
                    this.isLoading=false;
            });
            //window.location.reload(true);
        }
}
 
}