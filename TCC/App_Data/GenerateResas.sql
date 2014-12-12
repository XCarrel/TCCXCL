Use TCCXCL
GO

Declare @zeday datetime = GETDATE(),
		@nbdays integer,
		@nres integer,
		@court integer,
		@hour integer,
		@moment datetime,
		@nbres integer,
		@madeBy uniqueidentifier,
		@partner uniqueidentifier;

Set @zeday = DATEADD(DAY,1,@zeday);
Set @zeday = CAST(CAST(DATEPART(YEAR,@zeday) AS varchar) + '-' + CAST(DATEPART(MONTH,@zeday) AS varchar) + '-' + CAST(DATEPART(DAY,@zeday) AS varchar) AS DATETIME);

Set @nbdays = 0;
While @nbdays < 20
Begin
	Set @nbres = 8 + Round(Rand()*10,0);
	Set @nres = 0;
	while @nres < @nbres
	Begin
		Set @court = Round(Rand()*2,0) + 1;
		Set @hour = Round(Rand()*13,0) + 8;
		Set @moment = DATEADD(HOUR,@hour,@zeday);
		Begin Try
			if (Rand() < 0.1) -- Guest only
				Insert Into booking (moment,guest,fkCourt) Values (@moment,'Invité',@court);
			else
			Begin
				Set @madeBy = (Select Top 1 UserId From Users Order By NEWID());
				if (Rand() < 0.2) -- Member + Guest
					Insert Into booking (moment,fkMadeBy,guest,fkCourt) Values (@moment,@madeBy,'Invité',@court);
				else -- Member + Member
				Begin
					Set @partner = (Select Top 1 UserId From Users Order By NEWID());
					Insert Into booking (moment,fkMadeBy,fkPartner,fkCourt) Values (@moment,@madeBy,@partner,@court);
				End
			End
		End Try
		Begin catch
			Print ('Pas de bol');
		End Catch

		Set @nres=@nres+1;
	End

	Set @zeday = DATEADD(DAY,1,@zeday);
	Set @nbdays = @nbdays + 1;
End

print (CAST (@zeday as varchar));