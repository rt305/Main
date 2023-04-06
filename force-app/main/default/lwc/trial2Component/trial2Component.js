import { LightningElement,track } from 'lwc';
import myMethod from '@salesforce/apex/AApexClass.myMethod';

export default class Trial2Component extends LightningElement {
    @track accountsData = [];
    @track columns = [{ label: 'Id', fieldName: 'Id' },
                      { label: 'Name', fieldName: 'Name' },
                      { label: 'Phone', fieldName: 'Phone' }  
                    ];
    connectedCallback(){
        myMethod()
            .then(result => {
                this.accountsData = result;
            })
            .catch(error =>{
              console.log('error');  
            })
        }

    }