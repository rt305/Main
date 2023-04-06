import { LightningElement, api } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import { NavigationMixin } from 'lightning/navigation';
import panAdharDedupeValues from '@salesforce/apex/ConvertToLoanApplication.panAdharDedupeValues';
import createLoanApplication from '@salesforce/apex/ConvertToLoanApplication.createLoanApplication';


export default class ConvertToLoanApplication extends NavigationMixin (LightningElement){
    @api recordId;
    isPanVerified;
    isAdharVerified;
    isDedupeCheck;
    record;
    leadRecordId;

    handleProceed(){
        panAdharDedupeValues({ recordId:this.recordId }) 
        
        .then(result => {
            this.isAdharVerified = result.Is_Adhar_Verified__c;
            this.isPanVerified = result.Is_pan_verified__c;

            if(this.isPanVerified == 'Yes' && this.isAdharVerified == 'Yes'){
                console.log('222222');
                createLoanApplication({ leadRecordId : this.recordId }) 
                //console.log('33333333');
                .then(result => {
                    this.record = result;
                    this[NavigationMixin.Navigate]({
                        type: 'standard__recordPage',
                        attributes: {
                            recordId: this.record ,
                            objectApiName: 'Opportunity' ,
                            actionName: 'view'
                        }
                    });
                    this.dispatchEvent(new CloseActionScreenEvent());

                    //console.log('*&^%'+this.oppo);
                })
                .catch(error => {
                    console.log('error1111111' + error);
                })
            }  
        }) 
        .catch(error => {
            console.log('error22222222' + error);
        })
        
    }
}