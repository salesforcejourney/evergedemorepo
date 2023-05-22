import { LightningElement } from 'lwc';
import USER_ID from '@salesforce/user/Id';
import IS_GUEST from '@salesforce/user/isGuest'
import WELCOME_TO_LEARN_LWC from '@salesforce/label/c.WelcomeLWCLearninng';
import WELCOME_TO_LEARN_JS from '@salesforce/label/c.WelcomeToLearnJavascript';
import WELCOME_TO_LEARN_APEX from '@salesforce/label/c.WelcomeToLearnApex';
import EVERGE_LOGO_IMAGE from '@salesforce/resourceUrl/Everge_Logo'
import MOMENT from '@salesforce/resourceUrl/moment'
import ANIMATE from '@salesforce/resourceUrl/Animate'
import {loadScript,loadStyle} from 'lightning/platformResourceLoader'

export default class StaticResources extends LightningElement {
    userId = USER_ID;
    isGuest = IS_GUEST;
    
    welcomeLabelLwc = WELCOME_TO_LEARN_LWC
    welcomeLabelJs = WELCOME_TO_LEARN_JS
    welcomeLabelApex = WELCOME_TO_LEARN_APEX

    importedLabel = {
        welcomeLabelLwc : WELCOME_TO_LEARN_LWC,
        welcomeLabelJs : WELCOME_TO_LEARN_JS,
        welcomeLabelApex : WELCOME_TO_LEARN_APEX
    }
    evergeLogo = EVERGE_LOGO_IMAGE
    currentDate = ''
    isLibraryLoaded = false;
    
    renderedCallback(){
        if(isLibraryLoaded === false){
            loadScript(this,MOMENT)
            .then(()=>{
                
                console.log('Javascript loaded Successfully')
                
                this.setDatesforScreen();
            })
            .catch((error)=>console.log('error in loading JS',error))
           
            // promise.all([loadScript(this,MOMENT),loadStyle(this,Animate)])
            // .then(()=>{console.log('Extenal files are loaded Successfully')})
            // .catch((error)=>console.log('error in loading JS',error))

            this.isLibraryLoaded = true
        }else{
            return;
        }
    }

    setDatesforScreen(){
        this.currentDate = moment().format("MMM Do YY");    
    }

}