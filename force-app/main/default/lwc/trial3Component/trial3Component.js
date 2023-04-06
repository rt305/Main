import { LightningElement, api, track } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';

export default class Trial3Component extends LightningElement {
    @track objectApiName = ACCOUNT_OBJECT;
   @track nameField = NAME_FIELD;
   @track phoneField = PHONE_FIELD;
   @track accId;
   handleSuccess(event){
    this.accId = event.detail.Id;
   }
}