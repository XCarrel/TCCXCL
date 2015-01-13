USE TCCXCL
GO

Create Table MonTest
(
	unentier int,
	unfloat float,
	unmot varchar(45),
	unedate datetime
)

INSERT Into MonTest (unentier, unfloat, unmot, unedate) VALUES (10, 3.14, 'toto', '2015-01-01')
SELECT * FROM MonTest