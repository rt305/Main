import { LightningElement, track } from 'lwc';
import myMethod from '@salesforce/apex/ContactRecords.myMethod';

export default class createLeads extends LightningElement {
@track name;
@track company;
@track status;

handlechange(event){
    this.name=event.target.value;
    this.company=event.target.value;
    this.status=event.target.value;
}
handlesuccess(){
    myMethod({m:this.name, n:this.company, o:this.status})
    .then(response => {
        if (response == 'success'){
            this.dispatchEvent(new ShowToastEvent({
                title: "success",
                message: "lead created successfully",
                variant: "success"
            }));
        } else{
            this.dispatchEvent(new ShowToastEvent({
                title: "Error",
                message: "lead is not created",
                variant: "error"  
        
    }));
}})
.catch(error => {
    console.log(error+'abcd');
})
    
}
}