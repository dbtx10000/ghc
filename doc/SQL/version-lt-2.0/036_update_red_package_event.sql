use db_ghc;

set names gbk;

ALTER TABLE t_red_package_event ADD get_count int comment '领取数';
ALTER TABLE t_red_package_event ADD forward_count int comment '转发数';

update t_red_package_event set get_count = 0, forward_count = 0;