set names gbk;

use db_ghc;

alter table t_product add column game int comment '能否玩游戏提高收益率';

update t_product set game = 1 where type=1;
update t_product set game = 0 where type=2;