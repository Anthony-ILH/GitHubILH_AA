


SELECT
A.SSTATUS AS "Status",
A.SSCHEMECODE AS "Scheme Code",
A.SSCHEMENAME AS "Scheme Name",
A.SPOLICYREFERENCE AS "Policy No",
A.STRANSACTIONREFERENCE AS "Transn Reference",
A.STRANSACTIONTYPE AS "Type",
A.DTTRANSACTIONDUE AS "Due Date",
A.SCONTACTREFERENCE AS "Payer",
A.SRELATIONSHIP AS "Relationship",
A.SMEMBERNUMBER AS "Member No",
INSCONTACT.SSTAFFNUMBER AS "Staff No",
A.DAMOUNT AS "Amount",
A.DAMOUNTPAID AS "Amount Paid",
A.DAMOUNTSTILLTOPAY AS "Amount Still to Pay",
A.DNETOFGD AS "Net of GD",
A.DTRS AS "TRS",
CASE A.BMEMBERPAYROLLDEDUCTION WHEN -1 THEN 'True' ELSE 'False' END AS "Payroll Deduction",
A.DTPROCESSED AS "Processing Date",
A.DTACTIVITY AS "Activity Date",
CASE A.BSALESREQUESTED WHEN -1 THEN 'True' ELSE 'False' END  AS "Sales Requested",
A.DTWODUE AS "Write Off Due Date", 
TOPFSS.SSTATUS
FROM VPREMIUMTRANSACTIONSPOLICY A
INNER JOIN CONTACT B ON A.LCONTACTKEY = B.LCONTACTKEY
INNER JOIN POLICY C ON A.LPOLICYKEY = C.LPOLICYKEY
INNER JOIN POLICYACTIVITY D ON A.LPOLICYACTIVITYKEY = D.LPOLICYACTIVITYKEY
--INNER JOIN ENTITYINSTANCESTATES EIS ON EIS.lInstanceKey = D.LPOLICYACTIVITYKEY AND EIS.LENTITYKEY = 611 --AND EIS.LENTITYSTATEMEMBERKEY = 2153
INNER JOIN ENTITYSTATEMEMBERS ESM on ESM.LENTITYSTATEMEMBERKEY = D.LENTITYSTATEMEMBERKEY
INNER JOIN POLICYFOLDER E ON A.LPOLICYFOLDERKEY = E.LPOLICYFOLDERKEY
INNER JOIN TYPEOFPOLICYFOLDERSUBSTATUS TOPFSS on TOPFSS.LPOLICYFOLDERSUBSTATUSKEY = E.LSUBSTATUSKEY
INNER JOIN CONTACT INSCONTACT on INSCONTACT.lCONTACTKEY = E.LINSUREDCONTACTKEY
INNER JOIN TYPEOFPOLICYFOLDERSUBSTATUS PFSS on PFSS.LPOLICYFOLDERSUBSTATUSKEY = E.LSUBSTATUSKEY
INNER JOIN SCHEME F ON A.LSCHEMEKEY = F.LSCHEMEKEY
INNER JOIN TRANSACTIONS G ON A.LTRANSACTIONKEY = G.LTRANSACTIONKEY
WHERE B.SMEMBERNUMBER in ('2904180','2904217','2904299','2904348')
--AND A.SSTATUS  = 'Due' 
--AND E.LSUBSTATUSKEY = 3 -- Live
AND E.LSUBSTATUSKEY <> 3 -- Not Live
and A.DTTRANSACTIONDUE >= '01-JUN-2021'
and A.DTTRANSACTIONDUE <= '30-JUN-2021'
ORDER BY
A.LKEY;