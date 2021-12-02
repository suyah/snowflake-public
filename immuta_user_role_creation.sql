use role securityadmin;
create user svc_immuta_int_sandpit password='*';
create user svc_immuta_ds_sandpit password='*' default_role='R_F_IMMUTA_DS_sandpit';
create role r_f_immuta_ds_sandpit;
create role r_f_immuta_int_sandpit;
grant role r_f_immuta_int_sandpit to user svc_immuta_int_sandpit;
grant role r_f_immuta_ds_sandpit to user svc_immuta_ds_sandpit;

grant role r_f_immuta_int_sandpit to role sysadmin;
grant role r_f_immuta_ds_sandpit to role sysadmin;

-- give Immuta Integration creation user minimum privileges.
GRANT apply masking policy on account to role r_f_immuta_int_sandpit with grant option;
GRANT apply row access policy on account to role r_f_immuta_int_sandpit with grant option;
GRANT apply tag on account to role r_f_immuta_int_sandpit with grant option;
GRANT create database  on account to role r_f_immuta_int_sandpit ;
GRANT role securityadmin to role r_f_immuta_int_sandpit;

use role sysadmin;
CREATE WAREHOUSE WH_SVC_IMMUTA_XS_sandpit WITH WAREHOUSE_SIZE = 'XSMALL' WAREHOUSE_TYPE = 'STANDARD' AUTO_SUSPEND = 300 AUTO_RESUME = TRUE MIN_CLUSTER_COUNT = 1 MAX_CLUSTER_COUNT = 1 SCALING_POLICY = 'STANDARD' COMMENT = 'Warehouse used by Immuta Service Accounts';
grant usage on warehouse wh_svc_immuta_xs_sandpit to role r_f_immuta_ds_sandpit ;
grant usage on warehouse wh_svc_immuta_xs_sandpit to role r_f_immuta_int_sandpit ;

-- give Immuta Data Source Creation User Read Only Access to all objects that needs to be managed by Immuta

grant usage on database DB_ETL_OPS_sandpit to role r_f_immuta_ds_sandpit;
grant usage on database DB_ETL_OPS_sandpit to role r_f_immuta_ds_sandpit;
grant usage on database DB_ETL_OPS_sandpit to role r_f_immuta_ds_sandpit;

grant usage on schema DB_ETL_OPS_sandpit.DATA_QUALITY to role r_f_immuta_ds_sandpit;
grant usage on schema DB_ETL_OPS_sandpit.PUBLIC to role r_f_immuta_ds_sandpit;
grant usage on schema DB_ETL_OPS_sandpit.REPLICATION to role r_f_immuta_ds_sandpit;


grant select on all tables in schema DB_ETL_OPS_sandpit.DATA_QUALITY to role r_f_immuta_ds_sandpit;
grant select on all tables in schema DB_ETL_OPS_sandpit.PUBLIC to role r_f_immuta_ds_sandpit;
grant select on all tables in schema DB_ETL_OPS_sandpit.REPLICATION to role r_f_immuta_ds_sandpit;


grant select on  future tables in schema DB_ETL_OPS_sandpit.DATA_QUALITY to role r_f_immuta_ds_sandpit;
grant select on  future tables in schema DB_ETL_OPS_sandpit.PUBLIC to role r_f_immuta_ds_sandpit;
grant select on  future tables in schema DB_ETL_OPS_sandpit.REPLICATION to role r_f_immuta_ds_sandpit;
