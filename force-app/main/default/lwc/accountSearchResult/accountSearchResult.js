import { LightningElement, api, wire, track } from 'lwc';
import getAccount from '@salesforce/apex/LWCAccountsController.getAccount';


const COLUMNS = [
    { label: 'Id', fieldName: 'Id', type: 'text' },
    { label: 'Name', fieldName: 'Name', type: 'text' },
    { label: 'Action', type: 'button', typeAttributes:{
        label:'View Contacts',
        name:'View Contacts', 
        title:'View Contacts', 
        value:'View_Contacts',
    }}
    
];

export default class AccountSearchResult extends LightningElement {
    @track error;
    @track accounts;
    @api searchText;
    columns = COLUMNS;
    @wire(getAccount,{searchText:'$searchText'})
    accountsList;

   

}