import { LightningElement , track} from 'lwc';
import getOpportunityReportDatas from '@salesforce/apex/ApprovalHistory.storeOpportunity';
import getApprovalReportDatas from '@salesforce/apex/ApprovalHistory.storeApprovalHistory';

export default class ReportHistory extends LightningElement {
    @track storeHistoryCollection = []; 
    storeOpportunityCollection = new Map();
    storeHistoryStepCollection = new Map();
    
    @track storeGetReportDatas = [];
    @track storeOpportunityDatas = [];
    connectedCallback() {

        getOpportunityReportDatas()
        .then(result=> {
            let getOpportuniytData = result;
            for (var opportunityKey in getOpportuniytData) {

                let opportunityRecord = getOpportuniytData[opportunityKey];
                this.storeOpportunityCollection.set(opportunityRecord.Id, opportunityRecord);
            }
           
        })


        getApprovalReportDatas()
        .then(result => {
            let getApprovalData = JSON.parse(result);
            for(let key in getApprovalData.historyCollection) {
                    
                this.storeHistoryCollection.push({value:getApprovalData.historyCollection[key], key: this.storeOpportunityCollection.get(key)});
            }
        });
    }
}