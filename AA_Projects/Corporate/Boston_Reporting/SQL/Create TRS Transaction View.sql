USE [SupportOpenHealth]
GO

/****** Object:  View [dbo].[VTRSTRANSACTIONSMEMBER_TEST]    Script Date: 10/04/2019 17:03:06 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE   VIEW [dbo].[VTRSTRANSACTIONSMEMBER_TEST] ("LKEY", "LTRANSACTIONKEY", "LPOLICYACTIVITYKEY", "LPOLICYKEY", "LPOLICYFOLDERKEY", "LSCHEMEKEY", "LCONTACTKEY", "SSTATUS", "SSCHEMECODE", "SSCHEMENAME", "SPOLICYREFERENCE", "DTACTIVITY", "STRANSACTIONREFERENCE", "STRANSACTIONTYPE", "DTTRANSACTIONDUE", "SCONTACTREFERENCE", "SRELATIONSHIP", "SMEMBERNUMBER", "SMEMBERNAME", "DAMOUNT", "DAMOUNTPAID", "DAMOUNTSTILLTOPAY", "DNETOFGD", "DTRS", "BMEMBERPAYROLLDEDUCTION", "DTPROCESSED", "BSALESREQUESTED", "DTWODUE") AS 
  select t.lTransactionKey lKey
         , t.lTransactionKey
         , pa.lPolicyActivityKey
         , pa.lPolicyKey
         , pa.lPolicyFolderKey
         , pa.lSchemeKey
         , c.lContactKey
         , esm.sEntityStateMember sStatus
         , s.sSchemeCode
         , s.sSchemeName
         , pa.sReference sPolicyReference
         , pa.dtActivityVersionFrom
         , t.sReference sTransactionReference
         , tt.sTransactionCode sTransactionType
         , t.dtTransactionDue
         , c.sContactReference sPayer
         , tfm.sFamilyMember sRelationship
         , c2.sMemberNumber
         , c2.sContactReference sMemberName
--         , round(ts.dAmountSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 then  'M' else 'G' end),2) dAmount
--         , round(ts.dAmountPaidSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 then  'M' else 'G' end),2) dAmountPaid
--         , round(ts.dAmountStillToPaySigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 then  'M' else 'G' end),2) dAmountStillToPay
--         , round(ts.dNetOfGd*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 then  'M' else 'G' end),2) dNetOfGd
--         , round(ts.dNetOfGd*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 then  'M' else 'G' end),2)
--           -round(ts.dAmountSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 then  'M' else 'G' end),2) dTRS

--       , round(ts.dAmountSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) dAmount
--       , round(ts.dAmountPaidSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) dAmountPaid
--       , round(ts.dAmountStillToPaySigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) dAmountStillToPay
--       , round(ts.dNetOfGd*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) dNetOfGd
--       , round(ts.dNetOfGd*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2)
--           -round(ts.dAmountSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) dTRS

         , round(ts.dAmountSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) dAmount
         , round(ts.dAmountPaidSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) dAmountPaid
         , round(ts.dAmountStillToPaySigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) dAmountStillToPay
		 ,round(ts.dAmountSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2)
		  +(round(ts.dNetOfGd*dbo.FN_MemberTRSRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2)
           -round(ts.dAmountSigned*dbo.FN_MemberTRSRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2)) dNetOfGd
         , round(ts.dNetOfGd*dbo.FN_MemberTRSRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2)
           -round(ts.dAmountSigned*dbo.FN_MemberTRSRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) dTRS



         , t.bMemberPayrollDeduction
--         , CONVERT(DATETIME,CONVERT(DATE,ast.dtTransition)) dtProcessed
         , convert(datetime, convert(date,case when t.lTransactionTypeKey = 11 then dbo.FN_ProcessingDate(t.lTransactionKey, -1) else pa.dtWentLive end)) dtProcessed
         , cast (case when t.lTransactionTypeKey = 11 then dbo.FN_SchemeInvoiceWriteOffs(t.lTransactionKey, -1,null) else 0 end as SMALLINT) bSalesRequested
         , dbo.FN_SChemeInvoiceWODueDate(t.lTransactionKey) dtWODue
from Transactions t
inner join TransactionType tt
on tt.lTransactionTypeKey = t.lTransactionTypeKey
inner join PolicyActivity pa
on pa.lPolicyActivityKey = t.lPolicyActivityKey
inner join PolicyMember pm
on pm.lPolicyActivityKey = t.lPolicyActivityKey
inner join EntityStateMembers esm
on esm.lEntityStateMemberKey = t.lEntityStateMemberKey
--inner join AuditStateTransitions ast
--on ast.lEntityKey = 611
--and ast.lInstanceKey = pa.lPolicyActivityKey 
--and ast.lEntityStateMemberKey = 2153
inner join vSITransactionsSigned ts
on ts.lTransactionKey = t.lTransactionKey
inner join TypeOfFamilyMember tfm
on pm.lTypeOfFamilyMemberKey = tfm.lTypeOfFamilyMemberKey
inner join Scheme s
on s.lSchemeKey = pa.lSchemeKey
inner join Contact c
on t.lContactPayerKey = c.lContactKey
inner join Contact c2
on pm.lMemberContactKey = c2.lContactKey

--where pa.sReference = 'VIVG361268'
--where lSchemeKey = 5521
--group by
--t.lTransactionKey 
--         , t.lTransactionKey
--         , pa.lPolicyActivityKey
--         , pa.lPolicyKey
--         , pa.lPolicyFolderKey
--         , pa.lSchemeKey
--         , c.lContactKey
--         , esm.sEntityStateMember 
--         , s.sSchemeCode
--         , s.sSchemeName
--         , pa.sReference 
--         , pa.dtActivityVersionFrom
--         , t.sReference 
--         , tt.sTransactionCode 
--         , t.dtTransactionDue
--         , c.sContactReference 
--         , tfm.sFamilyMember 
--         , c2.sMemberNumber
--         , c2.sContactReference 
--         , round(ts.dAmountSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) 
--         , round(ts.dAmountPaidSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) 
--         , round(ts.dAmountStillToPaySigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) 
--         , round(ts.dNetOfGd*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) 
--         , round(ts.dNetOfGd*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2)
--           -round(ts.dAmountSigned*dbo.FN_MemberRatio(pm.lPolicyMemberKey, case when (ISNULL(pa.lTypeOfPaymethodKey, -1) = 4 and dTotalNetNetPremiumMbr <> 0) then  'M' else 'G' end),2) 
--
--
--         , t.bMemberPayrollDeduction
--
--         , cast (case when t.lTransactionTypeKey = 11 then dbo.FN_SchemeInvoiceWriteOffs(t.lTransactionKey, -1) else 0 end as SMALLINT) 
--         , dbo.FN_SChemeInvoiceWODueDate(t.lTransactionKey)
GO


