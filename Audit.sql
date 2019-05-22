create sequence audit_seq;

Create table audit_channels (action_nr NUMBER,action_cd VARCHAR2(2000), descr_tx VARCHAR2(2000),user_cd VARCHAR2(10), date_dt DATE)

create or replace procedure p_log_audit(what_tx VARCHAR2, descr_tx VARCHAR2,who_tx VARCHAR2, when_dt DATE)
is
pragma autonomous_transaction;
begin
  insert into audit_channels
  values(audit_seq.nextval, what_tx, descr_tx, who_tx, when_dt);
  commit;
end;

select * from channels;

drop trigger bu_channels;
create or replace trigger bu_channels
before update of channel_total on channels
referencing new as new old as old for each row
begin
  p_log_audit ('update','update of channels.channel_total', user, SYSDATE);
end;

update channels set channel_total = 10000;

select * from audit_channels;

select * from channels;