import { LightningElement } from 'lwc';

export default class SohailChild extends LightningElement {
    handleClose(){
        this.dispatchEvent(new CustomEvent('shahrukh'));

    }
}