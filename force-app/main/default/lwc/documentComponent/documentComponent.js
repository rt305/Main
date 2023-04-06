import { api, track, LightningElement } from 'lwc';
import DOCUMENT_DETAILS from '@salesforce/schema/Document_Detail__c';
import savedd from '@salesforce/apex/DocumentAttachment.savedd';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import getExistingRecords from '@salesforce/apex/DocumentAttachment.getExistingRecords';
import deletedd from '@salesforce/apex/DocumentAttachment.deletedd';
 
export default class DocumentComponent extends NavigationMixin(LightningElement) {
 
    @track ddList = [];
    @track index = 0;
    @api recordId;
    @api objectName=DOCUMENT_DETAILS;
    documentRecordId="";
    countForDocUpload=0;
    fileData;
    isLoaded;
    ddid = null;
    cdi;
    dd = {
        key : '',
        Party__c: null,
        Id: null,
        Document_Master__c: null,
        filename__c: null,
        cdid__c: null
    };
 
    filePreview(event) {
        // Naviagation Service to the show preview
        this[NavigationMixin.Navigate]({
            type: 'standard__namedPage',
            attributes: {
                pageName: 'filePreview'
            },
            state: {
                // assigning ContentDocumentId to show the preview of file
                selectedRecordId: event.currentTarget.dataset.id
            }
        })
    }
 
    connectedCallback(){
        this.getExistingRecords();
    }
 
    getExistingRecords(){
        console.log('hello4');
        this.isLoaded = true;
        getExistingRecords({recordId:this.recordId})
            .then((result) => {
                this.ddList = result;
                console.log('hello5'+result);
                for(var i; i < this.ddList.length; i++){
                    console.log('hello6');
                    this.addRow();
                }
            })
            .catch(() => {  
                this.addRow();
            });
        setTimeout(() => {
            this.isLoaded = false;
        }, 1000);
    }
 
    addRow() {
        this.index++;
        var i = this.index;
        this.dd.key = i;
        this.ddList.push(JSON.parse(JSON.stringify(this.dd)));
        console.log("Enter ", this.dd);
    }
 
    removeRow(event) {
        this.isLoaded = true;
        var i = event.currentTarget.dataset.value;
        this.ddid = i;
        var cdid = event.currentTarget.dataset.cdid;
        this.cdi = cdid;
        console.log("Enter ", this.ddid);
        deletedd({ddid:this.ddid, cdid:this.cdi});
        if(this.ddid != null){
            this.dispatchEvent(
                    new ShowToastEvent({
                    title: "Success",
                    message: "Documents deleted successfully",
                    variant: "success",
                    })
                );
            eval("$A.get('e.force:refreshView').fire();");
        }
        var selectedRow = event.currentTarget;
        var key = selectedRow.dataset.id;
        if (this.ddList.length > 1) {
            this.ddList.splice(key, 1);
            this.index--;
            this.isLoaded = false;
        } else if (this.ddList.length == 1) {
            this.ddList = [];
            this.index = 0;
            this.isLoaded = false;
        }
        this.ddid = null;
    }
 
    handlePartyChange(event) {
        var selectedRow = event.currentTarget;
        var key = selectedRow.dataset.id;
        this.ddList[key].Party__c = event.target.value;
    }
   
    handleMasterChange(event) {
        var selectedRow = event.currentTarget;
        var key = selectedRow.dataset.id;
        this.ddList[key].Document_Master__c = event.target.value;
    }
 
    openfileUpload(event) {
        const file = event.target.files[0]
        var reader = new FileReader()
        reader.onload = () => {
            var base64 = reader.result.split(',')[1]
            this.fileData = {
                'filename': file.name,
                'base64': base64,
            }
            console.log(this.fileData)
        }
        reader.readAsDataURL(file);
        var selectedRow = event.currentTarget;
        var key = selectedRow.dataset.id;
        setTimeout(() => {
            this.ddList[key].filename__c = this.fileData.filename;
            this.ddList[key].file__c = this.fileData.base64;
        }, 1000);
    }
    saveRecord() {
        for(var i=0;i<this.ddList.length;i++){
            console.log('Hi');
        if(this.ddList[i].filename__c==null){
            console.log('Hi 1');
            this.countForDocUpload=this.countForDocUpload+1;
        }
        else{
            this.countForDocUpload=0;
        }
    }
    if(this.countForDocUpload==0){
        console.log('Hi 2');
        savedd({ ddlst: this.ddList, lid: this.recordId })
            .then(() => {
                console.log('Hi 3');
                this.dispatchEvent(
                    new ShowToastEvent({
                    title: "Success",
                    message: "Documents created successfully",
                    variant: "success",
                    })
                );
                this.getExistingRecords();
            })
            .catch((error) => {  
                this.error = 'Unknown error';
                if (Array.isArray(error.body)) {
                    this.err = error.body.map(e => e.message).join(', ');
                }
                else if (typeof error.body.message === 'string') {
                    this.err = error.body.message;
                }
                const event = new ShowToastEvent({
                    title: this.err,
                    variant: 'error',
                    mode: 'pester',
                });
                error = this.dispatchEvent(event);
            });
        } else{
            const event = new ShowToastEvent({
                title: "Upload Document",
                message: "Please upload the Documents",
                variant: 'error',
            });
            error = this.dispatchEvent(event);
        }
    }
}