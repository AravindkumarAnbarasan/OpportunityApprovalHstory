# OpportunityApprovalHstory
Report for Opportunity Approval history  using APEX,LWC,HTML,,CSS

OpportunityApprovalHstory is used to create Report using LWC 

# objects Used

ProcessInstance
ProcessInstanceSteps
Opportunity

# In Apex

## storeApprovalHistory method

Queried All the ProcessInsatnce and ProcessInstanceSteps related to the ProcessInsatnce
Sroring it in map called jsonMap
PAssing to LWC

## storeOpportunity method

Queried All the Opportunity 
storing it in List
Passing to LWC

# In Js

Line number 9 , 21-24 , 27 Not needed

## getOpportunityReportDatas method

storeOpportunityCollection is a map used to store opportunityId is the key and opportunity as the value

## getApprovalReportDatas method

storeHistoryCollection is a array of objects to store  key is the opportunity record which we added to map in getOpportunityReportDatas method 
                                                       value is the  result of the return storeApprovalHistory 
                                                       SToring in  a varaible called getApprovalData and getting particular value called getApprovalData.historyCollection
                                            iterating this getApprovalData.historyCollection and getting the key to fetch the record
# In html

Iterating in html to seperate the values

# In css

Styling the table 

# In Xml 

Setting target to where to view the component



