import { LightningElement,api, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
 
export default class CreateLead extends NavigationMixin(LightningElement) {
    
    @api getValue;
    @api getValue1;
    @api getValue2;
    recordId;
    
    closePopup(){
        this.dispatchEvent( newCustomEvent('closeevent'));
            }
    subPopup(){
   this.template.querySelector('lightning-record-edit-form').submit();
   
   }
   handleSuccess(event){
    const evt = new ShowToastEvent({
       message: 'New Lead is Created Successfully',
       variant: 'success'
   });
   this.dispatchEvent(evt);  
   
 this.recordId = event.detail.id;
 console.log('$$$$$' + this.recordId);
this[NavigationMixin.Navigate]({
    type: "standard__recordPage",
    attributes:{
        recordId : this.recordId ,
        objectApiName : 'lead',
        actionName : "view"
    }
   });
   eval("$A.get('e.force:refreshView').fire();");

}


}