select * from channels;

select * from audit_unified_policies;

create audit policy mypoll
privileges create any trigger
actions update on channels;

audit policy mypoll by sys,admin, megha2;

update channels set channel_total = 40000;

select dbusername,event_timestamp,sql_text from unified_audit_trail where unified_audit_policies='MYPOLL';

CREATE USER megha2 IDENTIFIED BY "DemoATP12345678";
GRANT CREATE SESSION TO megha2;


SELECT SYSTEM_PRIVILEGE_USED FROM UNIFIED_AUDIT_TRAIL 
 WHERE OS_USERNAME = 'ADMIN' AND UNIFIED_AUDIT_POLICIES = 'MYPOLL';