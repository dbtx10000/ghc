use db_ghc;

set names gbk;

alter table t_product add column small_product int comment '是否是小投资额的产品,0不是,按现有的逻辑啥都不改,1是,产品字段的万元单位都默认当作是元的单位';

update t_product set small_product = 0;
update t_order set invest_money = invest_money * 10000;
update t_user_invest set invest_money = invest_money * 10000;
update t_user set assets = assets * 10000;