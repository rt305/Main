import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 
 
export default class ChildDataTable extends LightningElement {
     recordId;
 
    closeModal() {
        this.dispatchEvent(new CustomEvent('closeevent'));
        this.dispatchEvent(new CustomEvent('refreshevent'));
 
    }
 
    submitDetails() {
        this.isModalOpen = false;
    }
    handleSuccess(){
        const event = new ShowToastEvent({
           message: 'New Lead is Created Successfully',
           variant: 'success',
           mode: 'dismissable'
       });
       this.dispatchEvent(event);
       eval("$A.get('e.force:refreshView').fire();");
   }
handleSave(){
   this.template.querySelector('lightning-record-edit-form').submit(this.fields);
   //return refreshApex(this.mainResult);
   
}
}