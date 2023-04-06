import { LightningElement } from 'lwc';

export default class SohailParent extends LightningElement {
    childSohail = false;
    handleOpen(){
        this.childSohail = true;
    }
    closeShahrukh(){
        this.childSohail = false;
    }
}