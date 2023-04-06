import { LightningElement, track } from 'lwc';

export default class ChildCustomerSearchDataTable extends LightningElement {

    @track LeadColoumn = [
        {
            label: 'Name',
            fieldName: 'Title',
            type: 'url',
            typeAttributes: {
                label: {fieldName: 'Name'}},
                hideDefaultActions: true
            },
    { label: 'Company', fieldName: 'Company', type: 'text' },
    { label: 'Phone', fieldName: 'Phone', type: 'phone' },
    { label: 'Status', fieldName: 'Status', type: 'text' }
];

}