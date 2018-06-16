CREATE TABLE [dbo].[BIS_Planning_WSSI]
(
[Calendar_Week_Dim_ID] [smallint] NOT NULL,
[Subdepartment_Dim_ID] [smallint] NOT NULL,
[Mgn_%_Plan_FP] [numeric] (19, 7) NOT NULL,
[Mgn_%_Plan_MD] [numeric] (19, 7) NOT NULL,
[Sales_Tot_£_Plan] [numeric] (19, 7) NOT NULL,
[Sales_Tot_£_FP_Plan] [numeric] (19, 7) NOT NULL,
[Sales_Tot_£_MD_Plan] [numeric] (19, 7) NOT NULL,
[VAT] [numeric] (19, 7) NOT NULL,
[Sales_Totl_£_Prev_Fcst] [numeric] (19, 7) NOT NULL,
[Profit_£_Tot_Prev_Fcst] [numeric] (19, 7) NOT NULL,
[COS_£_Plan_FP] AS ((([Sales_Tot_£_FP_Plan]/((1)+[VAT]/(100)))*((100)-[Mgn_%_Plan_FP]))/(100)),
[COS_£_Plan_MD] AS ((([Sales_Tot_£_MD_Plan]/((1)+[VAT]/(100)))*((100)-[Mgn_%_Plan_MD]))/(100)),
[COS_£_Plan] AS ((([Sales_Tot_£_FP_Plan]/((1)+[VAT]/(100)))*((100)-[Mgn_%_Plan_FP]))/(100)+(([Sales_Tot_£_MD_Plan]/((1)+[VAT]/(100)))*((100)-[Mgn_%_Plan_MD]))/(100)),
[Department_Dim_ID] [tinyint] NOT NULL CONSTRAINT [BIS_Planning_WSSI_Department_DF] DEFAULT ((0)),
[Division_Dim_ID] [tinyint] NOT NULL CONSTRAINT [BIS_Planning_WSSI_Division_DF] DEFAULT ((0)),
[Territory_Dim_ID] [tinyint] NOT NULL CONSTRAINT [BIS_Planning_WSSI_Territory_DF] DEFAULT ((0)),
[Zone_Dim_ID] [tinyint] NOT NULL CONSTRAINT [BIS_Planning_WSSI_Zone_DF] DEFAULT ((0)),
[Intake_U_FP_Total] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_IntakeUFpTotal_DF] DEFAULT ((0)),
[Profit_£_Tot_Plan_FP] AS (([Sales_Tot_£_FP_Plan]/((1)+[VAT]/(100)))*([Mgn_%_Plan_FP]/(100))),
[Profit_£_Tot_Plan_MD] AS (([Sales_Tot_£_MD_Plan]/((1)+[VAT]/(100)))*([Mgn_%_Plan_MD]/(100))),
[Profit_£_Tot_Plan] AS (([Sales_Tot_£_FP_Plan]/((1)+[VAT]/(100)))*([Mgn_%_Plan_FP]/(100))+([Sales_Tot_£_MD_Plan]/((1)+[VAT]/(100)))*([Mgn_%_Plan_MD]/(100))),
[Intake_U_FP_Prev_Fcst] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_IntakeUFpPrevFcst_DF] DEFAULT ((0)),
[Sales_U_FP_Prev_Fcst] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_Sales_U_FP_Prev_Fcst_DF] DEFAULT ((0)),
[Sales_U_MD_Prev_Fcst] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_Sales_U_MD_Prev_Fcst_DF] DEFAULT ((0)),
[Sales_Tot_U_Prev_Fcst] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_Sales_Tot_U_Prev_Fcst_DF] DEFAULT ((0)),
[Sales_U_FP_Plan] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_SalesUFPPlan_DF] DEFAULT ((0)),
[Sales_U_MD_Plan] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_SalesUMDPlan_DF] DEFAULT ((0)),
[Sales_U_Tot_Plan] AS ([Sales_U_FP_Plan]+[Sales_U_MD_Plan]),
[Sales_£_FP_Prev_Fcst] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_SalesPoundFPPrevFcst_DF] DEFAULT ((0)),
[Sales_£_MD_Prev_Fcst] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_SalesPoundMDPrevFcst_DF] DEFAULT ((0)),
[Profit_£_FP_Prev_Fcst] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_ProfitPoundFPPrevFcst_DF] DEFAULT ((0)),
[Profit_£_MD_Prev_Fcst] [numeric] (19, 7) NOT NULL CONSTRAINT [BIS_Planning_WSSI_ProfitPoundMDPrevFcst_DF] DEFAULT ((0))
) ON [PRIMARY]
ALTER TABLE [dbo].[BIS_Planning_WSSI] ADD 
CONSTRAINT [BIS_Planning_WSSI_PK] PRIMARY KEY CLUSTERED  ([Calendar_Week_Dim_ID], [Subdepartment_Dim_ID], [Department_Dim_ID], [Division_Dim_ID], [Territory_Dim_ID], [Zone_Dim_ID]) ON [PRIMARY]
GO
