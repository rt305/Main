import { LightningElement, api, wire, track } from 'lwc';
import { CloseActionScreenEvent } from 'lightning/actions';
import getPartyRecords from '@salesforce/apex/CloneFunction.getPartyRecords';
import getDocumentRecords from '@salesforce/apex/CloneFunction.getDocumentRecords';
import cloneMethod from '@salesforce/apex/CloneFunction.cloneMethod';
import myMethod from '@salesforce/apex/CloneFunction.myMethod';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

//import { refreshApex } from '@salesforce/apex';

const PartiesColumns = [{ label : 'FirstName' , fieldName : 'Name' ,  type: 'text'},
                        { label : 'PAN ID' , fieldName : 'PAN_ID__c',  type: 'text' }];
const DocumentsColumns = [{ label : 'Name' , fieldName : 'Name' , type: 'text'},
                        { label : 'FileName' , fieldName : 'filename__c',  type: 'text' }
                    ];

export default class CloneFunction extends LightningElement {
    OpenPopup = false;
    TempPopup = true;
    PartiesColumns = PartiesColumns;
    DocumentsColumns = DocumentsColumns;
    tempData = true;
    @api recordId;
    partyData = [];
    dataData = [];
    iid;
    did;
    iDi;

    handleYesClick(){
        this.OpenPopup = true;
        this.TempPopup = false;
        myMethod({recId: this.recordId})
        .then(result =>{
          this.iid = result;
          eval("$A.get('e.force:refreshView').fire();");
        })
        .catch(error=>{
          console.log(error);
    })

  }
    handleNoClick(){
        this.dispatchEvent(new CloseActionScreenEvent());
    }
    handleCloseClick(){
        this.dispatchEvent(new CloseActionScreenEvent());   
    }
  
    @wire(getPartyRecords, {iDi: '$recordId'}) partyData;
    @wire(getDocumentRecords, {iDi: '$recordId'}) dataData;

    handleAddClick(){
      
        var Records1 = this.template.querySelector(".first").getSelectedRows();
        var Records2 = this.template.querySelector(".second").getSelectedRows();  
        
      cloneMethod( {PartyList: Records1, DocumentList: Records2, iDi: this.iid} )
      .then(result => {
        const event = new ShowToastEvent({
          title: 'Related Records are added',
          variant: 'success',
        });
        result = this.dispatchEvent(event);        
      })  
      .catch(error=>{  
        console.log('$$$$$$$$'+error);
      });
      this.dispatchEvent(new CloseActionScreenEvent()); 
    }

}