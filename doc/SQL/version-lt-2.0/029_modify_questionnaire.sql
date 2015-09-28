ALTER TABLE t_topic ADD (choose int not null comment '是否必选{1.是 0.否}');
ALTER TABLE t_topic ADD (type int not null comment '题目类型{0.单选 1.多选}');