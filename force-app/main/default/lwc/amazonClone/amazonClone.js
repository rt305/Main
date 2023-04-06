import { LightningElement } from 'lwc';
import login from '@salesforce/apex/LoginUser.login';

export default class AmazonClone extends LightningElement {

email;
password;
isError = false;
errorMessage = '';

handleUserName(event){
this.email = event.target.value;
}
handlePasswordChange(event){
    this.password = event.target.value;
}
handleLogin(){
    console.log('Inside Login');
    console.log('Email value', this.email);
    console.log('Password value', this.password);

    //if(this.email != Null && this.password != Null){
        this.isError = false;
        login({userName : this.email, password : this.password})
        .then((result) => {
            console.log('Result is: '+ result);
        })
        .catch((error) => {
            console.log('Error is: '+ error);
            this.isError = true;
            this.errorMessage = error.body.message;
        })
   // }

}
}