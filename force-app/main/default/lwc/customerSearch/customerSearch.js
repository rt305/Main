import { LightningElement} from 'lwc';
import getAccountLst from '@salesforce/apex/searcButton.getAccountLst';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import LeadList from '@salesforce/apex/LeadandLoanDatatable.LeadList';
import getLeadDetails1 from '@salesforce/apex/LeadandLoanDatatable.getLeadDetails1';
import getLeadDetails from '@salesforce/apex/LeadandLoanDatatable.getLeadDetails';
import leadDetails from '@salesforce/apex/LeadandLoanDatatable.leadDetails';
import getLeadList from '@salesforce/apex/searcButton.getLeadList';
 
 
export default class LoanLoginPage extends LightningElement {
custid='';
showtableloan=false;
pan='';
customerVal=true;
otherOpt=true;
enableCreatebutton= false;
leaddata;
loandata;
lName1='';
fName1='';
birthDate1='';
showtable=false;
callleadcreation=false;
falseshowtable=false;
falseshowtableloan=false;
 
leadColumns= [
{ label: 'Name', fieldName: "Title", type: 'url',
typeAttributes: {
    label: {fieldName: 'Name'}, target: '_blank'},
},
{ label: 'Company', fieldName: 'Company' },
{ label: 'Phone', fieldName: 'Phone', type: 'phone' },
{ label: 'Status', fieldName: 'Status' }
];
loanColumns= [
    { label: 'Name', fieldName: 'Name', type: 'text',
    typeAttributes: {
        label: {fieldName: 'Name'}, target: '_blank'},
    },
    { label: 'Amount', fieldName: 'Amount', type: 'currency'},
{ label: 'Stage', fieldName: 'StageName', type: 'picklist' },
{ label: 'Date closed', fieldName: 'CloseDate'}
];

searchKeyword(event){
this.custid = event.target.value;
this.otherOpt=false;
this.showtableloan=false;
this.showtable=false;
if(event.target.value == ''){
this.otherOpt=true;
this.customerVal=true;
this.enableCreatebutton=false;
this.falseshowtable = false;
this.falseshowtableloan= false;
}
}
searchfirstn(event){
this.fName = event.target.value;
this.fName1=this.fName;
this.showtableloan=false;
this.showtable=false;
this.falseshowtable = false;
this.falseshowtableloan= false;
 
}
searchLastn(event){
this.lName = event.target.value;
this.lName1=this.lName;
this.showtableloan=false;
this.showtable=false;
this.falseshowtable = false;
this.falseshowtableloan= false;
}
searchPan(event){    
this.pan1 = event.target.value;
this.pan=this.pan1;
this.customerVal=false;
this.showtableloan=false;
this.falseshowtable = false;
this.falseshowtableloan= false;
this.showtable=false;
if(event.target.value == ''){
this.customerVal=true;
this.otherOpt=true;
this.enableCreatebutton= false;
}
}
searchBD(event){
this.birthDate = event.target.value;
this.birthDate1=this.birthDate;
}
 
checkLead(){
    if(this.custid != ''){
        getAccountLst({customer:this.custid})
        .then(result => {
            this.acc=result;
            if(this.acc.length > 0){
                const event = new ShowToastEvent({
                    title: 'Toast Message',
                    message: 'Data Found',
                    variant: 'success',
                });
                this.dispatchEvent(event);
            }                    
                }).catch(error => {const event = new ShowToastEvent({
                    title: 'Toast Message',
                    message: 'Data not Found',
                    variant: 'warning' });
                this.dispatchEvent(event);
                this.showtable = false;
                this.showtableloan=false;
                this.falseshowtable = false;
                this.falseshowtableloan= false;
                this.enableCreatebutton = true;
                
            });
        
            LeadList({customer:this.custid})
            .then(result => {
                this.leaddata=result;
               
                }).catch(error => {
                this.showtable = false;
                this.showtableloan=false;
                this.falseshowtable = false;
                this.falseshowtableloan= false;
                })
                getLeadDetails1({customer:this.custid})
                .then(result => {
                this.loandata=result;
                this.showtable = true;
                this.falseshowtableloan= true;
            }).catch(error => {
                this.showtable = false;
            })
            if(this.custid != '' && this.pan =='' ){
                this.showtable = false;
                this.showtableloan= false;
                this.falseshowtable = false;
                this.falseshowtableloan= false;
            }
        }
        else if(this.pan !='')
        {
            getLeadList({pan:this.pan})
            .then(result => {
                this.lds=result;
                if(this.lds.length > 0){
            const event1 = new ShowToastEvent({
                title: 'Toast Message',
                message: 'Data Found..!!!',
                variant: 'success',
            });
            this.dispatchEvent(event1);
            this.showtable = true;
            this.showtableloan=true;}
        }).catch(error => {const event = new ShowToastEvent({
            title: 'Toast Message',
            message: 'Data Not Found',
            variant: 'warning' });
        this.dispatchEvent(event);
        this.showtable = false;
        this.showtableloan=false;
        this.falseshowtable = false;
                this.falseshowtableloan= false;
        this.enableCreatebutton=true;
        });    
        getLeadDetails({pan:this.pan}).then(result => {
            this.loandata = result;
            this.showtable = false;
            this.showtableloan=true;
            this.falseshowtable = false;
                this.falseshowtableloan= false;
        }).catch(error => {
            this.showtable = false;
            this.showtableloan=false;
        })
        leadDetails({pan:this.pan})
        .then(result => {
            this.leaddata=result;
            this.falseshowtable = true;
            this.showtableloan=true;
        }).catch(error => {
            this.showtable = false;
            this.showtableloan=false;
            this.falseshowtable = false;
                this.falseshowtableloan= false;
        })
        if(this.pan !='' && this.custid == ''){
            this.showtable = false;
            this.showtableloan= false;
            this.falseshowtable = false;
                this.falseshowtableloan= false;
        }
}}
 
createLeadbt(){
this.callleadcreation=true;
}
closeEvent(){
this.callleadcreation = false;
}
}