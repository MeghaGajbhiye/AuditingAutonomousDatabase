SELECT VALUE FROM V$OPTION WHERE PARAMETER = 'Unified Auditing';

select * from soe.orders;

create audit policy myorders_test
privileges create any trigger
actions update on soe.orders;


audit policy myorders_test by soe,admin;

EXEC SYS.DBMS_AUDIT_MGMT.FLUSH_UNIFIED_AUDIT_TRAIL;

SELECT policy_name, enabled_opt, user_name
  FROM audit_unified_enabled_policies
  WHERE policy_name = 'MYORDERS_TEST'
  ORDER BY user_name;


select dbusername,event_timestamp,sql_text from unified_audit_trail where unified_audit_policies='MYORDERS_TEST';

grant execute on DBMS_REDACT to soe;

NOAUDIT POLICY MYORDERS1 by soe,admin;
DROP AUDIT POLICY MYORDERS1;

