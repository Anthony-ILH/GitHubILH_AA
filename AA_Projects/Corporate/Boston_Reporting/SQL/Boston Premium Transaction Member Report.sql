

SELECT
PTM.SSTATUS AS "Status",
PTM.SSCHEMECODE AS "Scheme Code",
PTM.SSCHEMENAME AS "Scheme Name",
PTM.SPOLICYREFERENCE AS "Policy No",
PFSS.SSTATUS as "Policy Status",
PTM.STRANSACTIONREFERENCE AS "Transn Reference",
PTM.STRANSACTIONTYPE AS "Type",
PTM.DTTRANSACTIONDUE AS "Due Date",
PTM.SCONTACTREFERENCE AS "Payer",
PTM.SRELATIONSHIP AS "Relationship",
PTM.SMEMBERNUMBER AS "Member No",
INSCONTACT.SSTAFFNUMBER AS "Staff No",
cast(PTM.DAMOUNT as money) AS "Amount",
cast(PTM.DAMOUNTPAID as money) AS "Amount Paid",
cast(PTM.DAMOUNTSTILLTOPAY as money) AS "Amount Still to Pay",
cast(PTM.DNETOFGD as money) AS "Net of GD",
cast(PTM.DTRS as money) AS "TRS",
CASE PTM.BMEMBERPAYROLLDEDUCTION WHEN -1 THEN 'True' ELSE 'False' END AS "Payroll Deduction",
PTM.DTPROCESSED AS "Processing Date",
PTM.DTACTIVITY AS "Activity Date",
CASE PTM.BSALESREQUESTED WHEN -1 THEN 'True' ELSE 'False' END  AS "Sales Requested",
PTM.DTWODUE AS "Write Off Due Date" 

--select * 
from (select * from VPREMIUMTRANSACTIONSMEMBER --where SPOLICYREFERENCE  = 'VIVG505991' and stransactionreference = 'T22982068'
      ) ptm
INNER JOIN CONTACT C ON PTM.LCONTACTKEY = C.LCONTACTKEY
INNER JOIN POLICY P ON PTM.LPOLICYKEY = P.LPOLICYKEY
INNER JOIN POLICYACTIVITY PA ON PTM.LPOLICYACTIVITYKEY = PA.LPOLICYACTIVITYKEY
--INNER JOIN ENTITYINSTANCESTATES EIS ON EIS.lInstanceKey = PTM.LPOLICYACTIVITYKEY AND EIS.LENTITYKEY = 611 --AND EIS.LENTITYSTATEMEMBERKEY = 2153
INNER JOIN ENTITYSTATEMEMBERS ESM on ESM.LENTITYSTATEMEMBERKEY = PA.LENTITYSTATEMEMBERKEY
INNER JOIN POLICYFOLDER PF ON PTM.LPOLICYFOLDERKEY = PF.LPOLICYFOLDERKEY
INNER JOIN CONTACT INSCONTACT on INSCONTACT.lCONTACTKEY = PF.LINSUREDCONTACTKEY
INNER JOIN TYPEOFPOLICYFOLDERSUBSTATUS PFSS on PFSS.LPOLICYFOLDERSUBSTATUSKEY = PF.LSUBSTATUSKEY
INNER JOIN SCHEME S ON PTM.LSCHEMEKEY = S.LSCHEMEKEY
INNER JOIN TRANSACTIONS T ON PTM.LTRANSACTIONKEY = T.LTRANSACTIONKEY
WHERE 
--C.SMEMBERNUMBER='2867438'  -- Boston Scientific Galway
C.SMEMBERNUMBER in ('2867367','2867438','2867385')
--AND PTM.SSTATUS  = 'Due' 
--AND PF.LSUBSTATUSKEY = 3 -- Live
and PTM.DTTRANSACTIONDUE >= '01-JUN-2021'
and PTM.DTTRANSACTIONDUE <= '30-JUN-2021'
ORDER BY
PTM.DTTRANSACTIONDUE,
S.SSCHEMECODE,
PTM.SPOLICYREFERENCE, 
PTM.SMEMBERNUMBER 
;


