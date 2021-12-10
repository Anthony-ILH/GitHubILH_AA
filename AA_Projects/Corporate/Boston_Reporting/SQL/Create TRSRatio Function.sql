USE [SupportOpenHealth]
GO

/****** Object:  UserDefinedFunction [dbo].[fn_MemberTRSRatio]    Script Date: 10/04/2019 17:04:48 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE   FUNCTION [dbo].[fn_MemberTRSRatio] 
(
  @lPolicyMemberKey INT, 
  @InsPayer VARCHAR(1) --= 'M'
) 
RETURNS DECIMAL(38,36)
AS

BEGIN

	DECLARE
		@dReturn DECIMAL(38,36),
		@nZeroCheck decimal(18,5);
  
	If @InsPayer = 'M'
    
		select @nZeroCheck = pmtrs.TRSMember  --pa.DTOTALNETOFGDMBR - pa.DTOTALNETNETPREMIUMMBR
		from PolicyMember pm
		inner join PolicyActivity pa
		inner join (select lpolicyactivitykey, sum(dtrsgrp) as TRSGroup, sum(dtrsmbr) as TRSMember from policymember group by lPolicyActivityKey) pmtrs on pmtrs.lPolicyActivityKey = pa.LPOLICYACTIVITYKEY
		on pa.lPolicyActivityKey = pm.lPolicyActivityKey
		where pm.lPolicyMemberKey = @lPolicyMemberKey;
        
	Else if @InsPayer = 'G'
     
		select @nZeroCheck = pmtrs.TRSGroup -- pa.dtotaltrs --  pa.DTOTALNETOFGDGRP - pa.DTOTALNETNETPREMIUMGRP
		from PolicyMember pm
		inner join PolicyActivity pa
		inner join (select lpolicyactivitykey, sum(dtrsgrp) as TRSGroup, sum(dtrsmbr) as TRSMember from policymember group by lPolicyActivityKey) pmtrs on pmtrs.lPolicyActivityKey = pa.LPOLICYACTIVITYKEY
		on pa.lPolicyActivityKey = pm.lPolicyActivityKey
		where pm.lPolicyMemberKey = @lPolicyMemberKey;
        
	Else set @nZeroCheck = 0;

	IF isnull(@nZeroCheck,0) = 0

		set @dReturn =  0;

	ELSE If @InsPayer = 'M'
            
		select @dReturn = round(pm.dTRSMbr/TRSMember, 36,0)
		from PolicyMember pm
		inner join PolicyActivity pa 
		inner join (select lpolicyactivitykey, sum(dtrsgrp) as TRSGroup, sum(dtrsmbr) as TRSMember from policymember group by lPolicyActivityKey) pmtrs on pmtrs.lPolicyActivityKey = pa.LPOLICYACTIVITYKEY
		on pm.lPolicyActivityKey = pa.lPolicyActivityKey
		where pm.lPolicyMemberKey = @lPolicyMemberKey;
            
	Else if @InsPayer = 'G'
            
		select @dReturn = round(pm.dTRSGrp/TRSGroup, 36, 0)
		from PolicyMember pm
		inner join PolicyActivity pa 
		inner join (select lpolicyactivitykey, sum(dtrsgrp) as TRSGroup, sum(dtrsmbr) as TRSMember from policymember group by lPolicyActivityKey) pmtrs on pmtrs.lPolicyActivityKey = pa.LPOLICYACTIVITYKEY
		on pm.lPolicyActivityKey = pa.lPolicyActivityKey
		where pm.lPolicyMemberKey = @lPolicyMemberKey;
            
	Else set @dReturn =  0;
                
	RETURN isnull(@dReturn,0);
   
END;
GO


