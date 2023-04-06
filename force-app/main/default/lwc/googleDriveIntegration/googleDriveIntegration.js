import { LightningElement, api } from 'lwc';
import uploadFile from '@salesforce/apex/GoogleDriveIntegrationFileUploaderClass.uploadFile';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class googleDriveIntegration extends LightningElement {
    @api recordId;
    fileData;

    openfileUpload(event){
        const file = event.target.files[0];
        var reader = new FileReader()
        reader.onload = () => {
            var base64 = reader.result.split(',')[1];
            this.fileData = {
                'filename' : file.name,
                'base64' : base64,
                'recordId' : this.recordId
            }
            console.log(this.fileData);
        }
        reader.readAsDataURL(file);
    }

    handleClick(){
        const {base64, filename, recordId} = this.fileData;
        uploadFile({ base64, recordId, filename }).then(result=>{
            this.fileData = null;
            let title = `${filename} uploaded successfully!!!`
            this.toast(title);
        })
    }
   
    toast(title){
        const toastEvent = new ShowToastEvent({
            title,
            variant: "success"
        })
        this.dispatchEvent(toastEvent)
    }
}