import { LightningElement } from 'lwc';
import getPostalDetails from '@salesforce/apex/PostalCode.getPostalDetails'
import getPostalDetailsByName from '@salesforce/apex/PostalCode.getPostalDetailsByName'
export default class PostalCode extends LightningElement {

    columns=[
        {
            label:'Name',
            fieldName:'Name'
        },
        {
            label:'BranchType',
            fieldName:'BranchType'
        },
        {
            label:'Circle',
            fieldName:'Circle'
        },
        {
            label:'District',
            fieldName:'District'
        },
        {
            label:'State',
            fieldName:'State'
        },
        {
            label:'Division',
            fieldName:'Division'
        },
        {
            label:'Pincode',
            fieldName:'Pincode'
        }

    ]
    pincode='';
    branch='';
    showPostalInfo = false;
    postalInformation={};
    handleChange(event)
    {
        const {name,value} = event.target
        if(name==='pincode')
        {
            this.pincode = value;
        }
        else if(name==='branch')
        {
            this.branch = value;
        }
    }

    
    handleClick()
    {
        if(this.pincode!='')
        {
            getPostalDetails({pincode:this.pincode})
            .then((result)=>
            {
                console.log('result--'+result);
                this.showPostalInfo = true;
                this.postalInformation=result;
            })
            . catch((error)=>
            {
                console.log('error--'+error);
                this.showPostalInfo = false;
            })
        }
        else if(this.pincode==='' && this.branch!='')
        {
            getPostalDetailsByName({name:this.branch})
            .then((result)=>
            {
                console.log('result'+result);
                this.showPostalInfo = true;
                this.postalInformation = result;
            })
            .catch((error)=>
            {
                this.showPostalInfo = false;
                console.log('error--'+error);
            })
        }
    }


    
}