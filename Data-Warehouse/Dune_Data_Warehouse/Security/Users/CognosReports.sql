IF NOT EXISTS (SELECT * FROM master.dbo.syslogins WHERE loginname = N'CognosReports')
CREATE LOGIN [CognosReports] WITH PASSWORD = 'p@ssw0rd'
GO
CREATE USER [CognosReports] FOR LOGIN [CognosReports]
GO
