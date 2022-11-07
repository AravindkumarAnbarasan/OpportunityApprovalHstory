/*
Class to store map data
*/
public with sharing class ApprovalHistory {
    
    @AuraEnabled
    public static string storeApprovalHistory() {
        Map<Id,List<ProcessInstance>> historyCollection = new Map<Id,List<ProcessInstance>>();
        Map<Id,List<sObject>> historyStepCollection = new Map<Id,List<sObject>>();
        Map<String,Object> storeEntireMap = new Map<String,Object>();
        String jsonMap;
        try {

            for(ProcessInstance iteratingProcessInstance :[SELECT Id,Status,ElapsedTimeInHours,TargetObject.Type,TargetObjectId,TargetObject.Name , (SELECT Id, StepStatus, Comments,ProcessInstanceId FROM Steps )
                                                           FROM ProcessInstance
                                                           WHERE TargetObject.Type = 'Opportunity']) {
                if(!historyCollection.containsKey(iteratingProcessInstance.Id)) {
                    historyCollection.put(iteratingProcessInstance.TargetObjectId,new List<ProcessInstance>());
                }
                historyCollection.get(iteratingProcessInstance.TargetObjectId).add(iteratingProcessInstance);
                for(ProcessInstanceStep iterateSteps :iteratingProcessInstance.Steps ) {
                    historyStepCollection.put(iteratingProcessInstance.TargetObjectId,new List<sObject>());
                    historyStepCollection.get(iteratingProcessInstance.TargetObjectId).add(iterateSteps);
                }
            }
            storeEntireMap.put('historyCollection', historyCollection);
            storeEntireMap.put('historyStepCollection', historyStepCollection);
            jsonMap = JSON.serialize(storeEntireMap);
   
        } catch (Exception error) {
            throw new AuraHandledException(error.getMessage());
        }
        return jsonMap;
    }

    @AuraEnabled
    public static List<Opportunity> storeOpportunity () {
        List<Opportunity> OpportunitySOS = new List<Opportunity>();
        for(Opportunity iteratingOpportunitySO : [SELECT Id,Name,StageName,Amount FROM Opportunity WHERE Approval_Status__c != null]) {
                OpportunitySOS.add(iteratingOpportunitySO);
        }
        return OpportunitySOS;
    }
}
/*    
ApprovalHistory.storeApprovalHistory();
ApprovalHistory.storeOpportunity();
*/