set names gbk;

use db_ghc;

alter table t_order add column type int not null comment '抵扣使用类型0.未使用,1.使用金币,2.使用代金券,3.两个都使用';
alter table t_order add column cash_id varchar(1000) comment '代金券来源ID,多个用逗号分隔';
alter table t_order add column cash_money int comment '代金券抵扣金额';

update t_order set type = 0 where source_id is null;
update t_order set type = 1 where source_id != '';
update t_order set cash_money = 0;