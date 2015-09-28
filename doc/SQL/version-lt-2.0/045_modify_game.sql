alter table t_game_record add column friend_score int comment '朋友帮玩的分数';

alter table t_friend_game_record add column max_score int comment '最高分数';

alter table t_game_record add column friend_count int comment '亲友团人数';