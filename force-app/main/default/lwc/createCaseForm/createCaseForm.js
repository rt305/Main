import { LightningElement } from 'lwc';

export default class CreateCaseForm extends LightningElement {
openIt = false;
    handleClick(){
        this.openIt = true;
    }
    hadleClose(){
        this.openIt = false;
    }
}