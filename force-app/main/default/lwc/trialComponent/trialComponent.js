import { LightningElement, wire, track  } from 'lwc';
import myMethod from '@salesforce/apex/AApexClass.myMethod';


export default class TrialComponent extends LightningElement {
    @track accountList;
    @track columns = [
        { label: 'Id', fieldName: 'Id'},
        { label: 'Name', fieldName: 'Name' },
        { label: 'Phone', fieldName: 'Phone'}
    ];
    @wire (myMethod) wiredAccounts ({data,error}){
        if(data){
            this.accountList = data;
        } else if(error){
            console.log(error);
        }
    }

}