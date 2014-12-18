USE master
GO

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Données
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

IF (EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = 'TCCXCL'))
BEGIN
	/**Deconnexion de tous les utilsateurs sauf l'administrateur**/
	/**Annulation immediate de toutes les transactions**/
	ALTER DATABASE TCCXCL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

	/**Suppression de la base de données**/
	DROP DATABASE TCCXCL;
END
GO

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Tables
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE DATABASE TCCXCL
 ON  PRIMARY 
( NAME = N'TCC', FILENAME = N'C:\Data\MSSQL\TCC.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TCC_log', FILENAME = N'C:\Data\MSSQL\TCC_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO

USE TCCXCL
GO

CREATE TABLE belongs(
	idbelongs int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	fkMember uniqueidentifier NOT NULL,
	fkGroup int NOT NULL,
	fkRole int NULL,
	since datetime NOT NULL);
	
CREATE TABLE booking(
	idbooking int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	moment datetime NOT NULL,
	fkMadeBy uniqueidentifier NULL,
	fkPartner uniqueidentifier NULL,
	guest varchar(45) NULL,
	fkCourt int NOT NULL);
	
CREATE TABLE bookingErrors(
	idbooking int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	moment datetime NULL,
	fkMadeBy uniqueidentifier NULL,
	fkPartner uniqueidentifier NULL,
	guest varchar(45) NULL,
	fkCourt int NULL,
	reason varchar(200));
	
CREATE TABLE config(
	idconfig int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	keyname varchar(45) NOT NULL,
	numval float NULL,
	charval varchar(1000) NULL,
	dateval datetime NULL);

CREATE TABLE court(
	idcourt int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	courtName varchar(45) NOT NULL);

CREATE TABLE clubGroup(
	idclubGroup int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	groupName varchar(45) NOT NULL);

CREATE TABLE role(
	idrole int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	isLeading bit NOT NULL DEFAULT 0,
	roleDescription varchar(45) NOT NULL);

CREATE TABLE tccmembership(
	idtccmembership int IDENTITY(1,1) NOT NULL PRIMARY KEY,
	fkuser uniqueidentifier,
	address1 varchar(50),
	address2 varchar(50),
	NPA int,
	phonenumber varchar(30),
	email varchar(50),
	isSiteAdmin bit NOT NULL DEFAULT 0,
	approved bit NOT NULL DEFAULT 0);

CREATE TABLE NPA(
	NPAVal int NOT NULL PRIMARY KEY,
	city varchar(50));
GO


/****** ASP.NET Membership sub-schema ******/

CREATE TABLE __MigrationHistory(
	MigrationId nvarchar(150) NOT NULL,
	ContextKey nvarchar(300) NOT NULL,
	Model varbinary(max) NOT NULL,
	ProductVersion nvarchar(32) NOT NULL,
 CONSTRAINT PK_dbo__MigrationHistory PRIMARY KEY CLUSTERED 
(
	MigrationId ASC,
	ContextKey ASC
))

GO

CREATE TABLE Applications(
	ApplicationId uniqueidentifier NOT NULL,
	ApplicationName nvarchar(235) NOT NULL,
	Description nvarchar(256) NULL,
 CONSTRAINT PK_dboApplications PRIMARY KEY CLUSTERED 
(
	ApplicationId ASC
))

GO

CREATE TABLE Memberships(
	UserId uniqueidentifier NOT NULL,
	ApplicationId uniqueidentifier NOT NULL,
	Password nvarchar(128) NOT NULL,
	PasswordFormat int NOT NULL,
	PasswordSalt nvarchar(128) NOT NULL,
	Email nvarchar(256) NULL,
	PasswordQuestion nvarchar(256) NULL,
	PasswordAnswer nvarchar(128) NULL,
	IsApproved bit NOT NULL,
	IsLockedOut bit NOT NULL,
	CreateDate datetime NOT NULL,
	LastLoginDate datetime NOT NULL,
	LastPasswordChangedDate datetime NOT NULL,
	LastLockoutDate datetime NOT NULL,
	FailedPasswordAttemptCount int NOT NULL,
	FailedPasswordAttemptWindowStart datetime NOT NULL,
	FailedPasswordAnswerAttemptCount int NOT NULL,
	FailedPasswordAnswerAttemptWindowsStart datetime NOT NULL,
	Comment nvarchar(256) NULL,
 CONSTRAINT PK_dbo_Memberships PRIMARY KEY CLUSTERED 
(
	UserId ASC
))

GO

CREATE TABLE Profiles(
	UserId uniqueidentifier NOT NULL,
	PropertyNames nvarchar(max) NOT NULL,
	PropertyValueStrings nvarchar(max) NOT NULL,
	PropertyValueBinary varbinary(max) NOT NULL,
	LastUpdatedDate datetime NOT NULL,
 CONSTRAINT PK_dbo_Profiles PRIMARY KEY CLUSTERED 
(
	UserId ASC
))

GO

CREATE TABLE Roles(
	RoleId uniqueidentifier NOT NULL,
	ApplicationId uniqueidentifier NOT NULL,
	RoleName nvarchar(256) NOT NULL,
	Description nvarchar(256) NULL,
 CONSTRAINT PK_dbo_Roles PRIMARY KEY CLUSTERED 
(
	RoleId ASC
))

GO

CREATE TABLE Users(
	UserId uniqueidentifier NOT NULL,
	ApplicationId uniqueidentifier NOT NULL,
	Firstname varchar(45) NULL,
	LastName varchar(45) NULL,
	UserName nvarchar(50) NOT NULL,
	IsAnonymous bit NOT NULL,
	LastActivityDate datetime NOT NULL,
 CONSTRAINT PK_dbo_Users PRIMARY KEY CLUSTERED 
(
	UserId ASC
))

GO

CREATE TABLE UsersInRoles(
	UserId uniqueidentifier NOT NULL,
	RoleId uniqueidentifier NOT NULL,
 CONSTRAINT PK_dbo_UsersInRoles PRIMARY KEY CLUSTERED 
(
	UserId ASC,
	RoleId ASC
))

GO

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Contraintes référentielles
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

ALTER TABLE Roles  WITH CHECK ADD  CONSTRAINT FK_dbo_Roles_dbo_Applications_ApplicationId FOREIGN KEY(ApplicationId)
REFERENCES Applications (ApplicationId)
GO

ALTER TABLE Profiles  WITH CHECK ADD  CONSTRAINT FK_dbo_Profiles_dbo_Users_UserId FOREIGN KEY(UserId)
REFERENCES Users (UserId)
GO

ALTER TABLE Memberships  WITH CHECK ADD  CONSTRAINT FK_dbo_Memberships_dbo_Applications_ApplicationId FOREIGN KEY(ApplicationId)
REFERENCES Applications (ApplicationId)
GO

ALTER TABLE Memberships  WITH CHECK ADD  CONSTRAINT FK_dbo_Memberships_dbo_Users_UserId FOREIGN KEY(UserId)
REFERENCES Users (UserId)
GO

ALTER TABLE Users  WITH CHECK ADD  CONSTRAINT FK_dbo_Users_dbo_Applications_ApplicationId FOREIGN KEY(ApplicationId)
REFERENCES Applications (ApplicationId)
GO

ALTER TABLE UsersInRoles  WITH CHECK ADD  CONSTRAINT FK_dbo_UsersInRoles_dbo_Roles_RoleId FOREIGN KEY(RoleId)
REFERENCES Roles (RoleId)
GO

ALTER TABLE UsersInRoles  WITH CHECK ADD  CONSTRAINT FK_dbo_UsersInRoles_dbo_Users_UserId FOREIGN KEY(UserId)
REFERENCES Users (UserId)
GO

ALTER TABLE belongs  WITH CHECK ADD  CONSTRAINT FK_belongs_as FOREIGN KEY(fkRole)
REFERENCES role (idrole)
ON DELETE CASCADE

ALTER TABLE belongs  WITH CHECK ADD  CONSTRAINT FK_belongs_group FOREIGN KEY(fkGroup)
REFERENCES clubGroup (idclubGroup)
ON DELETE CASCADE

ALTER TABLE belongs  WITH CHECK ADD  CONSTRAINT FK_belongs_Users FOREIGN KEY(fkMember)
REFERENCES Users (UserId)
ON DELETE CASCADE

ALTER TABLE booking  WITH CHECK ADD  CONSTRAINT FK_booking_court FOREIGN KEY(fkCourt)
REFERENCES court (idcourt)

ALTER TABLE booking  WITH CHECK ADD  CONSTRAINT FK_booking_from FOREIGN KEY(fkMadeBy)
REFERENCES Users (UserId)
ON DELETE CASCADE

ALTER TABLE booking  WITH CHECK ADD  CONSTRAINT FK_booking_partner FOREIGN KEY(fkPartner)
REFERENCES Users (UserId)

ALTER TABLE tccmembership WITH CHECK ADD CONSTRAINT FK_user_info FOREIGN KEY(fkUser)
REFERENCES Users (UserId)
ON DELETE CASCADE

ALTER TABLE tccmembership WITH CHECK ADD CONSTRAINT FK_npa FOREIGN KEY(NPA)
REFERENCES NPA (NPAVal)

GO

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Contrainte de domaine
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

ALTER TABLE booking  WITH CHECK ADD  CONSTRAINT CK_bookingdate 
CHECK  ((moment>=getdate() AND moment<=dateadd(week,(2),getdate())))
GO


-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Vue
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

CREATE VIEW Committee
AS
SELECT UserName, Firstname, LastName, roleDescription
FROM   clubGroup INNER JOIN
			belongs ON clubGroup.idclubGroup = belongs.fkGroup INNER JOIN
				Users ON belongs.fkMember = Users.UserId INNER JOIN
					role ON belongs.fkRole = role.idrole
WHERE        (clubGroup.groupName = 'Comité')

GO

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Données
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

Use TCCXCL;
GO

declare @baseappid uniqueidentifier = NEWID()
INSERT INTO Applications (ApplicationId, ApplicationName) values (@baseappid,'/')

INSERT INTO Users (UserId,FirstName, LastName, UserName, LastActivityDate, ApplicationId, IsAnonymous) values (NEWID(),'Radu','Albot','RuAlbot',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Nicolas','Almagro','NsAlmagro',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Kevin','Anderson','KnAnderson',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Guido','Andreozzi','GoAndreozzi',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Pablo','Andujar','PoAndujar',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Facundo','Arguello','FoArguello',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Andrea','Arnaboldi','AaArnaboldi',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Matthias','Bachinger','MsBachinger',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marcos','Baghdatis','MsBaghdatis',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Facundo','Bagnis','FoBagnis',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Agut','Bautista','AtBautista',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Andreas','Beck','AsBeck',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Benjamin','Becker','BnBecker',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Aljaz','Bedene','AzBedene',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Thomaz','Bellucci','TzBellucci',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Ruben','Bemelmans','RnBemelmans',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Julien','Benneteau','JnBenneteau',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Ricardas','Berankis','RsBerankis',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Tomas','Berdych','TsBerdych',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Carlos','Berlocq','CsBerlocq',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Michael','Berrer','MlBerrer',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Simone','Bolelli','SeBolelli',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Alex','Bolt','AxBolt',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Liam','Broady','LmBroady',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Dustin','Brown','DnBrown',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Chase','Buchanan','CeBuchanan',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Baena','Carballes','BaCarballes',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Busta','Carreno','BaCarreno',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marco','Cecchinato','MoCecchinato',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jeremy','Chardy','JyChardy',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marco','Chiudinelli','MoChiudinelli',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Hyeon','Chung','HnChung',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marin','Cilic','MnCilic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marius','Copil','MsCopil',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Kimmer','Coppejans','KrCoppejans',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Borna','Coric','BaCoric',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Pablo','Cuevas','PoCuevas',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Frank','Dancevic','FkDancevic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Taro','Daniel','ToDaniel',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Steve','Darcis','SeDarcis',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jon','de Bakker','Jnde Bakker',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marc','De Schepper','McDe Schepper',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Juan','Del Potro','JnDel Potro',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Federico','Delbonis','FoDelbonis',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Mate','Delic','MeDelic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Somdev','Devvarman','SvDevvarman',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Grigor','Dimitrov','GrDimitrov',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Novak','Djokovic','NkDjokovic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Ivan','Dodig','InDodig',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Alexandr','Dolgopolov','ArDolgopolov',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Evgeny','Donskoy','EyDonskoy',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'James','Duckworth','JsDuckworth',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Farrukh','Dustov','FhDustov',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Damir','Dzumhur','DrDzumhur',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Matthew','Ebden','MwEbden',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Gastao','Elias','GoElias',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Burgos','Estrella','BsEstrella',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Alejandro','Falla','AoFalla',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Roger','Federer','RrFederer',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'David','Ferrer','DdFerrer',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Fabio','Fognini','FoFognini',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marton','Fucsovics','MnFucsovics',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Teymuraz','Gabashvili','TzGabashvili',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Guillermo','Garcia-Lopez','GoGarcia-Lopez',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Richard','Gasquet','RdGasquet',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Andre','Ghem','AeGhem',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Daniel','Gimeno-Traver','DlGimeno-Traver',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Santiago','Giraldo','SoGiraldo',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'David','Goffin','DdGoffin',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Peter','Gojowczyk','PrGojowczyk',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Andrey','Golubev','AyGolubev',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Norbert','Gombos','NtGombos',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Alejandro','Gonzalez','AoGonzalez',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Maximo','Gonzalez','MoGonzalez',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marcel','Granollers','MlGranollers',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Sam','Groth','SmGroth',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Ernests','Gulbis','EsGulbis',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Tommy','Haas','TyHaas',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Robin','Haase','RnHaase',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Andreas','Haider-Maurer','AsHaider-Maurer',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Victor','Hanescu','VrHanescu',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Ryan','Harrison','RnHarrison',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Pierre-Hugues','Herbert','PsHerbert',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Lleyton','Hewitt','LnHewitt',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Galung','Huta','GgHuta',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Uladzimir','Ignatik','UrIgnatik',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marsel','Ilhan','MlIlhan',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'John','Isner','JnIsner',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Denis','Istomin','DsIstomin',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Tatsuma','Ito','TaIto',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jerzy','Janowicz','JyJanowicz',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Malek','Jaziri','MkJaziri',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Steve','Johnson','SeJohnson',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Tobias','Kamke','TsKamke',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Ivo','Karlovic','IoKarlovic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Blaz','Kavcic','BzKavcic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Bradley','Klahn','ByKlahn',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Martin','Klizan','MnKlizan',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Philipp','Kohlschreiber','PpKohlschreiber',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Thanasi','Kokkinakis','TiKokkinakis',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Austin','Krajicek','AnKrajicek',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Filip','Krajinovic','FpKrajinovic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jason','Kubler','JnKubler',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Lukasz','Kubot','LzKubot',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Denis','Kudla','DsKudla',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Alexander','Kudryavtsev','ArKudryavtsev',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Mikhail','Kukushkin','MlKukushkin',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Andrey','Kuznetsov','AyKuznetsov',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Alex','Kuznetsov','AxKuznetsov',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Nick','Kyrgios','NkKyrgios',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Lukas','Lacko','LsLacko',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Dusan','Lajovic','DnLajovic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Feliciano','Lopez','FoLopez',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Paolo','Lorenzi','PoLorenzi',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Yen-Hsun','Lu','YnLu',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Nicolas','Mahut','NsMahut',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Adrian','Mannarino','AnMannarino',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Illya','Marchenko','IaMarchenko',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Andrej','Martin','AjMartin',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Paul-Henri','Mathieu','PiMathieu',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Marinko','Matosevic','MoMatosevic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Leonardo','Mayer','LoMayer',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Florian','Mayer','FnMayer',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'James','McGee','JsMcGee',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Miloslav','Mecir','MvMecir',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jurgen','Melzer','JnMelzer',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Gerald','Melzer','GdMelzer',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Adrian','Menendez-Maceiras','AnMenendez-Maceiras',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Axel','Michon','AlMichon',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'John','Millman','JnMillman',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Vincent','Millot','VtMillot',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Denys','Molchanov','DsMolchanov',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Juan','Monaco','JnMonaco',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Gael','Monfils','GlMonfils',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Albert','Montanes','AtMontanes',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Hiroki','Moriya','HiMoriya',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Gilles','Muller','GsMuller',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Andy','Murray','AyMurray',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Rafael','Nadal','RlNadal',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Aleksandr','Nedovyesov','ArNedovyesov',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jarkko','Nieminen','JoNieminen',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Kei','Nishikori','KiNishikori',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Yoshihito','Nishioka','YoNishioka',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Wayne','Odesnik','WeOdesnik',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Benoit','Paire','BtPaire',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Ante','Pavic','AePavic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Peter','Polansky','PrPolansky',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Vasek','Pospisil','VkPospisil',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Lucas','Pouille','LsPouille',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Michal','Przysiezny','MlPrzysiezny',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Tim','Puetz','TmPuetz',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Sam','Querrey','SmQuerrey',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Rajeev','Ram','RvRam',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Albert','Ramos-Vinolas','AtRamos-Vinolas',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Milos','Raonic','MsRaonic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Julian','Reister','JnReister',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Pere','Riba','PeRiba',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Stephane','Robert','SeRobert',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Tommy','Robredo','TyRobredo',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Edouard','Roger-Vasselin','EdRoger-Vasselin',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Blaz','Rola','BzRola',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Lukas','Rosol','LsRosol',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Michael','Russell','MlRussell',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Luke','Saville','LeSaville',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Diego','Schwartzman','DoSchwartzman',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Dudi','Sela','DiSela',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Andreas','Seppi','AsSeppi',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Igor','Sijsling','IrSijsling',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Gilles','Simon','GsSimon',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'John-Patrick','Smith','JkSmith',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Tim','Smyczek','TmSmyczek',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jack','Sock','JkSock',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Go','Soeda','GoSoeda',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Joao','Sousa','JoSousa',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Joao','Souza','JoSouza',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Sergiy','Stakhovsky','SyStakhovsky',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Potito','Starace','PoStarace',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Radek','Stepanek','RkStepanek',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jan-Lennard','Struff','JdStruff',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Yuichi','Sugita','YiSugita',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Dominic','Thiem','DcThiem',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Bernard','Tomic','BdTomic',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Stefano','Travaglia','SoTravaglia',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Viktor','Troicki','VrTroicki',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jo-Wilfried','Tsonga','JdTsonga',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Dmitry','Tursunov','DyTursunov',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Adrian','Ungur','AnUngur',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Luca','Vanni','LaVanni',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Fernando','Verdasco','FoVerdasco',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jiri','Vesely','JiVesely',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Matteo','Viola','MoViola',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Filippo','Volandri','FoVolandri',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Jimmy','Wang','JyWang',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'James','Ward','JsWard',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Stan','Wawrinka','SnWawrinka',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Donald','Young','DdYoung',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Mikhail','Youzhny','MlYouzhny',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Horacio','Zeballos','HoZeballos',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Ze','Zhang','ZeZhang',CURRENT_TIMESTAMP,@baseappid,0),(NEWID(),'Alexander','Zverev','ArZverev',CURRENT_TIMESTAMP,@baseappid,0);
GO

INSERT INTO court (courtName) VALUES ('Central'), ('Numéro 1'), ('Numéro 2');
GO

INSERT INTO clubGroup (groupName) VALUES ('Ecoliers'), ('Juniors'), ('Interclubs'), ('Comité');
GO

INSERT INTO [role] (roleDescription, isLeading) VALUES ('Président',0), ('Entraîneur',1), ('Coach',1), ('Caissier',0), ('Membre',0);
GO

INSERT INTO belongs (fkMember, fkGroup, fkRole, since) VALUES ((SELECT TOP 1 UserId FROM Users where LastName Like 'A%'),4,5,CURRENT_TIMESTAMP), ((SELECT TOP 1 UserId FROM Users where LastName Like 'E%'),4,5,CURRENT_TIMESTAMP), ((SELECT TOP 1 UserId FROM Users where LastName Like 'D%'),4,5,CURRENT_TIMESTAMP),((SELECT TOP 1 UserId FROM Users where LastName Like 'C%'),4,1,CURRENT_TIMESTAMP), ((SELECT TOP 1 UserId FROM Users where LastName Like 'B%'),4,4,CURRENT_TIMESTAMP);
GO

INSERT INTO NPA (NPAVal,City) VALUES (1000, 'Lausanne CT'),(1001, 'Lausanne'),(1002, 'Lausanne'),(1003, 'Lausanne'),(1004, 'Lausanne'),(1005, 'Lausanne'),(1006, 'Lausanne'),(1007, 'Lausanne'),(1008, 'Prilly'),(1009, 'Pully'),(1010, 'Lausanne'),(1011, 'Lausanne'),(1012, 'Lausanne'),(1014, 'Lausanne Adm cant'),(1015, 'Lausanne'),(1017, 'Lausanne Veillon'),(1018, 'Lausanne'),(1019, 'Lausanne'),(1020, 'Renens VD'),(1022, 'Chavannes-Renens'),(1023, 'Crissier'),(1024, 'Ecublens VD'),(1025, 'St-Sulpice VD'),(1026, 'Echandens-Denges'),(1027, 'Lonay'),(1028, 'Préverenges'),(1029, 'Villars-Ste-Croix'),(1030, 'Bussigny-Lausanne'),(1031, 'Mex VD'),(1032, 'Romanel-s-Lausanne'),(1033, 'Cheseaux-Lausanne'),(1034, 'Boussens'),(1035, 'Bournens'),(1036, 'Sullens'),(1037, 'Etagniéres'),(1038, 'Bercher'),(1039, 'Cheseaux Polyval'),(1040, 'Echallens'),(1041, 'Dommartin'),(1042, 'Bettens'),(1043, 'Sugnens'),(1044, 'Fey'),(1045, 'Ogens'),(1046, 'Rueyres'),(1047, 'Oppens'),(1052, 'Mont-sur-Lausanne'),(1053, 'Bretigny-Morrens'),(1054, 'Morrens VD'),(1055, 'Froideville'),(1058, 'Villars-Tiercelin'),(1059, 'Peney-le-Jorat'),(1061, 'Villars-Mendraz'),(1062, 'Sottens'),(1063, 'Peyres-Possens'),(1066, 'Epalinges'),(1068, 'Les Monts-de-Pully'),(1070, 'Puidoux'),(1071, 'Chexbres'),(1072, 'Forel (Lavaux)'),(1073, 'Savigny'),(1076, 'Ferlens VD'),(1077, 'Servion'),(1078, 'Essertes'),(1080, 'Les Cullayes'),(1081, 'Montpreveyres'),(1082, 'Corcelles-le-Jorat'),(1083, 'Méziéres VD'),(1084, 'Carrouge VD'),(1085, 'Vulliens'),(1088, 'Ropraz'),(1090, 'La Croix (Lutry)'),(1091, 'Grandvaux'),(1092, 'Belmont-Lausanne'),(1093, 'La Conversion'),(1094, 'Paudex'),(1095, 'Lutry'),(1096, 'Cully'),(1097, 'Riex'),(1098, 'Epesses'),(1110, 'Morges'),(1112, 'Echichens'),(1113, 'St-Saphorin-Morges'),(1114, 'Colombier VD'),(1115, 'Vullierens'),(1116, 'Cottens VD'),(1117, 'Grancy'),(1121, 'Bremblens'),(1122, 'Romanel-sur-Morges'),(1123, 'Aclens'),(1124, 'Gollion'),(1125, 'Monnaz'),(1126, 'Vaux-sur-Morges'),(1127, 'Clarmont'),(1128, 'Reverolle'),(1131, 'Tolochenaz'),(1132, 'Lully VD'),(1134, 'Vufflens-Ch‚teau'),(1135, 'Denens'),(1136, 'Bussy-Chardonney'),(1141, 'Sévery'),(1142, 'Pampigny'),(1143, 'Apples'),(1144, 'Ballens'),(1145, 'Biére'),(1146, 'Mollens VD'),(1147, 'Montricher'),(1148, 'LIsle'),(1149, 'Berolle'),(1162, 'St-Prex'),(1163, 'Etoy'),(1164, 'Buchillon'),(1165, 'Allaman'),(1166, 'Perroy'),(1167, 'Lussy-sur-Morges'),(1168, 'Villars-sous-Yens'),(1169, 'Yens'),(1170, 'Aubonne'),(1172, 'Bougy-Villars'),(1173, 'Féchy'),(1174, 'Montherod'),(1175, 'Lavigny'),(1176, 'St-Livres'),(1180, 'Rolle'),(1182, 'Gilly'),(1183, 'Bursins'),(1184, 'Vinzel'),(1185, 'Mont-sur-Rolle'),(1186, 'Essertines-Rolle'),(1187, 'St-Oyens'),(1188, 'Gimel'),(1189, 'Saubraz'),(1195, 'Dully-Bursinel'),(1196, 'Gland'),(1197, 'Prangins'),(1200, 'Genève'),(1201, 'Genève'),(1202, 'Genève'),(1203, 'Genève'),(1204, 'Genève'),(1205, 'Genève'),(1206, 'Genève'),(1207, 'Genève'),(1208, 'Genève'),(1209, 'Genève'),(1211, 'Genève 1'),(1212, 'Grand-Lancy'),(1213, 'Petit-Lancy'),(1214, 'Vernier'),(1215, 'Genève'),(1216, 'Cointrin'),(1217, 'Meyrin'),(1218, 'Le Grand-Saconnex'),(1219, 'Le Lignon'),(1220, 'Les Avanchets'),(1222, 'Vésenaz'),(1223, 'Cologny'),(1224, 'Chêne-Bougeries'),(1225, 'Chêne-Bourg'),(1226, 'Thonex'),(1227, 'Carouge GE'),(1228, 'Plan-les-Ouates'),(1231, 'Conches'),(1232, 'Confignon'),(1233, 'Bernex'),(1234, 'Vessy'),(1236, 'Cartigny'),(1237, 'Avully'),(1239, 'Collex'),(1240, 'Genève'),(1241, 'Puplinge'),(1242, 'Satigny'),(1243, 'Presinge'),(1244, 'Choulex'),(1245, 'Collonge-Bellerive'),(1246, 'Corsier GE'),(1247, 'Aniéres'),(1248, 'Hermance'),(1251, 'Gy'),(1252, 'Meinier'),(1253, 'Vandoeuvres'),(1254, 'Jussy'),(1255, 'Veyrier'),(1256, 'Troinex'),(1257, 'La Croix-de-Rozon'),(1258, 'Perly'),(1260, 'Nyon'),(1261, 'Marchissy'),(1262, 'Eysins'),(1263, 'Crassier'),(1264, 'St-Cergue'),(1265, 'La Cure'),(1266, 'Duillier'),(1267, 'Vich-Coinsins'),(1268, 'Burtigny'),(1269, 'Bassins'),(1270, 'Trélex'),(1271, 'Givrins'),(1272, 'Genolier'),(1273, 'Le Muids'),(1274, 'Grens'),(1275, 'Chéserex'),(1276, 'Gingins'),(1277, 'Borex'),(1278, 'La Rippe'),(1279, 'Chavannes-de-Bogis'),(1281, 'Russin'),(1283, 'Dardagny'),(1284, 'Chancy'),(1285, 'Athenaz (Avusy)'),(1286, 'Soral'),(1287, 'Laconnex'),(1288, 'Aire-la-Ville'),(1289, 'Genève Serv. Spéc.'),(1290, 'Versoix'),(1291, 'Commugny'),(1292, 'Chambésy'),(1293, 'Bellevue'),(1294, 'Genthod'),(1295, 'Mies-Tannay'),(1296, 'Coppet'),(1297, 'Founex'),(1298, 'Céligny'),(1299, 'Crans-prés-Céligny'),(1300, 'Eclépens CC'),(1302, 'Vufflens-la-Ville'),(1303, 'Penthaz'),(1304, 'Senarclens'),(1305, 'Penthalaz'),(1306, 'Daillens'),(1307, 'Lussery-Villars'),(1308, 'La Chaux-Cossonay'),(1310, 'Daillens Dist Ba'),(1311, 'Eclépens SC'),(1312, 'Eclépens'),(1313, 'Ferreyres'),(1315, 'La Sarraz'),(1316, 'Chevilly'),(1317, 'Orny'),(1318, 'Pompaples'),(1320, 'Daillens ST PP 1'),(1321, 'Arnex-sur-Orbe'),(1322, 'Croy'),(1323, 'RomainmÙtier'),(1324, 'Premier'),(1325, 'Vaulion'),(1326, 'Juriens'),(1329, 'Bretonniéres'),(1330, 'Daillens CALL'),(1337, 'Vallorbe'),(1338, 'Ballaigues'),(1341, 'Orient'),(1342, 'Le Pont'),(1343, 'Les Charbonniéres'),(1344, 'LAbbaye'),(1345, 'Le Lieu'),(1346, 'Les Bioux'),(1347, 'Le Sentier'),(1348, 'Le Brassus'),(1350, 'Orbe'),(1352, 'Agiez'),(1353, 'Bofflens'),(1354, 'Montcherand'),(1355, 'LAbergement'),(1356, 'Les Clées'),(1357, 'Lignerolle'),(1358, 'Valeyres-Rances'),(1372, 'Bavois'),(1373, 'Chavornay'),(1374, 'Corcelles-Chavorn'),(1375, 'Penthéréaz'),(1376, 'Goumoens-la-Ville'),(1377, 'Oulens-Echallens'),(1400, 'Yverdon-les-Bains'),(1401, 'Yverdon-les-Bains'),(1404, 'Cuarny'),(1405, 'Pomy'),(1406, 'Cronay'),(1407, 'Bioley-Magnoux'),(1408, 'Prahins'),(1409, 'Chanéaz'),(1410, 'Thierrens'),(1412, 'Valeyres-Ursins'),(1413, 'Orzens'),(1415, 'Molondin'),(1416, 'Pailly'),(1417, 'Epautheyres'),(1418, 'Vuarrens'),(1420, 'Fiez'),(1421, 'Fontaines-Grandson'),(1422, 'Grandson'),(1423, 'Villars-Burquin'),(1424, 'Champagne'),(1425, 'Onnens VD'),(1426, 'Concise'),(1427, 'Bonvillars'),(1428, 'Mutrux'),(1429, 'Giez'),(1430, 'Orges'),(1431, 'Vugelles-La Mothe'),(1432, 'Belmont-Yverdon'),(1433, 'Suchy'),(1434, 'Ependes VD'),(1435, 'Essert-Pittet'),(1436, 'Treycovagnes'),(1437, 'Suscévaz'),(1438, 'Mathod'),(1439, 'Rances'),(1440, 'Montagny-Chamard'),(1441, 'Valeyres-Montagny'),(1442, 'Montagny-Yverdon'),(1443, 'Champvent'),(1445, 'Vuiteboeuf');
GO

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Triggers
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------

-- CheckRes:	Verifies court bookings. Invalid bookings are reported in table booking_errors
--				Validation of:
--					1. Set of people involved
--					2. Datetime between now and now+2 weeks
--					3. Court availability
-- Author:		X. Carrel
-- Date:		Dec 2014

Create Trigger CheckRes
On booking
Instead Of Insert, Update
As
Begin
	Declare Resas Cursor For
	Select idbooking, moment, fkMadeBy, fkPartner, guest, fkCourt From inserted;

	Declare @idbooking int,
			@moment Datetime,
			@fkMadeBy uniqueidentifier,
			@fkPartner uniqueidentifier,
			@guest varchar(45),
			@fkCourt int;

	Declare @Error varchar(200)='',
			@count int = 0,
			@nbErrors int = 0;

	Open Resas;
	Fetch Next From Resas Into @idbooking, @moment, @fkMadeBy, @fkPartner, @guest, @fkCourt;

	while @@FETCH_STATUS = 0
	Begin
		Set @count = @count+1;

		-- Check people set
		if @fkMadeBy is null
			if @fkPartner is null
				if @guest is null
					Set @Error = 'Aucune référence à des joueurs';
				else
					Set @Error = '';-- No problem: guest only
			else
				Set @Error = 'Spécifier un membre principal avant un partenaire';
		else -- Main member specified
			if @fkPartner is null
				if @guest is null
					Set @Error = 'Pas de partenaire';
				else
					Set @Error = '';-- No problem: member and guest
			else
				if @guest is null
					Set @Error = '';-- No problem: Two members
				else
					Set @Error = 'Trop de monde';

		-- Check time
		if DATEDIFF(DAY,GETDATE(),@moment) <0 Set @Error='Date dans le passé';
		if DATEDIFF(DAY,GETDATE(),@moment) >15 Set @Error='Date trop loin dans le futur';

		-- Check fk
		if @fkMadeBy is not null AND not exists (Select * From Users where UserId = @fkMadeBy) Set @Error = 'Joueur inconnu';
		if @fkPartner is not null AND not exists (Select * From Users where UserId = @fkPartner) Set @Error = 'Partenaire inconnu';
		if not exists (Select * From Court where idcourt = @fkCourt) Set @Error = 'Court inexistant';

		-- Check court availability
		if exists (Select * from booking  where DATEPART(YEAR,moment)=DATEPART(YEAR,@moment) AND
												DATEPART(MONTH,moment)=DATEPART(MONTH,@moment) AND
												DATEPART(DAY,moment)=DATEPART(DAY,@moment) AND
												DATEPART(HOUR,moment)=DATEPART(HOUR,@moment) AND
												fkCourt = @fkCourt)
			Set @Error = 'Le court est pris';

		-- Finalize
		if @Error = '' -- No problem
		Begin
			print 'OK';
			Insert Into booking(moment, fkMadeBy, fkPartner, guest, fkCourt)
			Values (@moment, @fkMadeBy, @fkPartner, @guest, @fkCourt);
		End
		else
		Begin
			print 'Error: '+@Error;
			Insert Into bookingErrors(moment, fkMadeBy, fkPartner, guest, fkCourt, reason)
			Values (@moment, @fkMadeBy, @fkPartner, @guest, @fkCourt, @Error);
			Set @nbErrors = @nbErrors+1;
		End;

		-- Move on to next record
		Fetch Next From Resas Into @idbooking, @moment, @fkMadeBy, @fkPartner, @guest, @fkCourt;
	End
	Close Resas;
	Deallocate Resas;

	-- Return result
	if @nbErrors > 0
		if @nbErrors = @count
		Begin
			RAISERROR ('Tout faux',2,1);
			Rollback;
		End
		else
			RAISERROR ('Quelques soucis',1,1);
End

GO

-- Committee:	Allows insert, deletes and updates in the "committee" view
--				Specific constraint: there must always be one and only one "président"
--				and one and only one "caissier"
-- Author:		X. Carrel
-- Date:		Dec 2014

Create Trigger ValidateCommittee
On Committee
Instead Of Insert, Update, Delete
As
Begin
	Declare @uname varchar(45), -- username
			@rdesc varchar(45), -- role description
			@uid uniqueidentifier, -- user id
			@uidout uniqueidentifier, -- id of the user leaving a group
			@rid int, -- role id
			@rpres int, -- id of role "Président"
			@rcais int, -- id of role "Caissier"
			@cid int; -- id of group "Comité"

	Select @rpres=idrole From [role] Where roleDescription='Président';
	Select @rcais=idrole From [role] Where roleDescription='Caissier';
	Select @cid=idClubGroup From clubGroup Where groupName = 'Comité';

	-- Handle the special case: change of unique role
	if ((select count(*) from inserted) = 1) And
	   ((select count(*) from deleted) = 1) And
	   ((select roleDescription from inserted) = (select roleDescription from deleted))
	Begin
		Select @uid=UserId From Users Where Username = (select UserName from inserted);
		Select @uidout=UserId From Users Where Username = (select UserName from deleted);
		Select @rid=idrole From [role] Where roleDescription=(select roleDescription from inserted);
		update belongs set fkMember = @uid where fkMember=@uidout and fkGroup=@cid and fkRole=@rid
		return
	End

	-- Handle inserts				
	Declare cursins Cursor For
	Select UserName, roleDescription From inserted;

	Open cursins;
	Fetch Next From cursins Into @uname, @rdesc;

	while @@FETCH_STATUS = 0
	Begin
		Select @uid=UserId From Users Where Username = @uname;
		Select @rid=idrole From [role] Where roleDescription=@rdesc;
		
		if @uid is not null and @rid is not null -- Input is correct
		Begin
			if @rid = @rpres or @rid = @rcais
			Begin
				RAISERROR ('Duplication de fonction interdite',1,1);
				Rollback;
			End
			Else
			Begin
				Insert Into belongs (fkMember, fkGroup, fkRole, since) Values
									(@uid,@cid,@rid,CURRENT_TIMESTAMP)
			End
		End
		Else
			RAISERROR ('Données incorrectes',1,1);

		-- Move on to next record
		Fetch Next From cursins Into @uname, @rdesc;
	End
			
	Close cursins;
	Deallocate cursins;

	-- Handle deletes				
	Declare cursdel Cursor For
	Select UserName, roleDescription From deleted;

	Open cursdel;
	Fetch Next From cursdel Into @uname, @rdesc;

	while @@FETCH_STATUS = 0
	Begin
		Select @uid=UserId From Users Where Username = @uname;
		Select @rid=idrole From [role] Where roleDescription=@rdesc;
		
		if @uid is not null and @rid is not null -- Input is correct
		Begin
			if @rid = @rpres or @rid = @rcais
			Begin
				RAISERROR ('Suppression de fonction interdite',1,1);
				Rollback;
			End
			Else
			Begin
				Delete From belongs Where fkMember =  @uid And fkRole = @rid And fkGroup = @cid
			End
		End
		Else
			RAISERROR ('Données incorrectes',1,1);
			
		-- Move on to next record
		Fetch Next From cursdel Into @uname, @rdesc;
	End
	Close cursdel;
	Deallocate cursdel;
	
End

GO

-- NewUser:		Creates the tccmembership record that will hold the tcc-specific data
-- Author:		X. Carrel
-- Date:		Dec 2014
Create Trigger NewUser
On Users
After Insert
As
Begin
	Insert Into tccmembership (fkuser) Select UserId From inserted;
End

GO

-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Procedures
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- MemberBooking:		Creates a booking involving two members
-- Author:				X. Carrel
-- Date:				Dec 2014

CREATE PROCEDURE MemberBooking (@m1 varchar(45), @m2 varchar(45), @court varchar(45), @moment datetime)
AS
Begin
	Declare @u1 uniqueidentifier,
			@u2 uniqueidentifier,
			@cid int;

	Set @u1 = (Select UserId From Users Where UserName = @m1);
	Set @u2 = (Select UserId From Users Where UserName = @m2);
	Set @cid = (Select idCourt From court Where courtName = @court);

	If (@u1 is null or @u2 is null)
		RAISERROR ('Unknown member',16,1);
	Else
		If @cid is null
			RAISERROR ('Unknown court',16,1);
		Else
			if DATEDIFF(DAY,GETDATE(),@moment) <0 
				RAISERROR ('Date in the past',16,1);
			Else
				if DATEDIFF(DAY,GETDATE(),@moment) >15 
					RAISERROR ('Date too far in the future',16,1);
				Else
					if exists (Select * from booking  where DATEPART(YEAR,moment)=DATEPART(YEAR,@moment) AND
															DATEPART(MONTH,moment)=DATEPART(MONTH,@moment) AND
															DATEPART(DAY,moment)=DATEPART(DAY,@moment) AND
															DATEPART(HOUR,moment)=DATEPART(HOUR,@moment) AND
															fkCourt = @cid)
						RAISERROR ('Court is busy',16,1);
					Else
						Insert into booking (moment, fkMadeBy, fkPartner, fkCourt) Values (@moment, @u1, @u2, @cid);

End

GO
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Functions
-------------------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------------------
-- Occupation:		Returns the occupation rate of a court between two dates
-- Author:			X. Carrel
-- Date:			Dec 2014

CREATE FUNCTION Occupation (@court varchar(45), @from datetime, @to datetime)
RETURNS int
AS
Begin
	Declare @cid int,
			@nbres float,
			@nbhours float;

	Set @cid = (Select idCourt From court Where courtName = @court);

	If (@cid is null) 
		Return -1; -- Error code for bad court

	-- Beware of bad hours
	If @to <= @from or DatePart(HOUR,@from) < 8 or DatePart(HOUR,@from) > 21 or DatePart(HOUR,@to) < 8 or DatePart(HOUR,@to) > 21 
		Return -2; -- Error code for bad dates

	Select @nbres = count(*) from booking Where fkCourt = @cid And moment >= @from And moment <= @to;
	Set @nbhours = Datediff(DAY,@from,@to) * 14 + DatePart(HOUR,@to) - DatePart(HOUR,@from);

	return Round(@nbres/@nbhours*100,0);

End

GO
