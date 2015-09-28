package com.alidao.basic.service.impl;

import java.util.Date;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alidao.basic.dao4mybatis.OptionDao;
import com.alidao.basic.dao4mybatis.QuestionnaireDao;
import com.alidao.basic.dao4mybatis.QuestionnaireRecordDao;
import com.alidao.basic.dao4mybatis.TopicDao;
import com.alidao.basic.entity.Option;
import com.alidao.basic.entity.Questionnaire;
import com.alidao.basic.entity.QuestionnaireRecord;
import com.alidao.basic.entity.Topic;
import com.alidao.basic.service.QuestionnaireRecordService;
import com.alidao.common.Constants;
import com.alidao.jse.util.DateUtil;
import com.alidao.jxe.model.Page;
import com.alidao.jxe.model.PageParam;
import com.alidao.users.authorizing.UseridTracker;
import com.alidao.users.dao4mybatis.UserBindDao;
import com.alidao.users.dao4mybatis.UserDao;
import com.alidao.users.entity.User;
import com.alidao.users.entity.UserBind;
import com.alidao.users.entity.UserIntegral;
import com.alidao.users.service.UserIntegralService;
import com.alidao.users.service.UserService;
import com.alidao.wxapi.bean.TokenForWxapis;
import com.alidao.wxapi.util.WxapiUtil;

@Service
public class QuestionnaireRecordServiceImpl implements QuestionnaireRecordService {

	@Autowired 
	private QuestionnaireRecordDao questionnaireRecordDao;
	
	@Autowired
	private QuestionnaireDao questionnaireDao;
	 
	@Autowired
	private TopicDao topicDao;
	 
	@Autowired
	private OptionDao optionDao;
	 
	@Autowired
	private UserDao userDao;
	 
	@Autowired
	private UserService userService;
     
	@Autowired
	private UserIntegralService userIntegralService;
	
	@Autowired
	private UserBindDao userBindDao;
	
	private Log log = LogFactory.getLog(this.getClass());

    public int save(QuestionnaireRecord object) {
        return questionnaireRecordDao.insert(object);
    }

    public int save(List<QuestionnaireRecord> objects) {
        int result = 0;
        for (QuestionnaireRecord object : objects) {
            result &= questionnaireRecordDao.insert(object);
        }
        return result;
    }

    public int lose(String id) {
        return questionnaireRecordDao.deleteByPrimaryKey(id);
    }

    public int lose(QuestionnaireRecord object) {
        return questionnaireRecordDao.delete(object);
    }

    public int mdfy(QuestionnaireRecord object) {
        return questionnaireRecordDao.update(object);
    }

    public QuestionnaireRecord find(String id) {
        return questionnaireRecordDao.selectByPrimaryKey(id);
    }

    public QuestionnaireRecord find(QuestionnaireRecord object) {
        return questionnaireRecordDao.select(object);
    }

    public Page<QuestionnaireRecord> page(PageParam pageParam, QuestionnaireRecord object) {
        return questionnaireRecordDao.queryForPage(pageParam,object);
    }

    public List<QuestionnaireRecord> list(QuestionnaireRecord object) {
        return questionnaireRecordDao.queryForList(object);
    }

	public int save(String questionnaireId, String[] topicId, String[] optionId) {
		String userId=UseridTracker.get();
		QuestionnaireRecord questionnaireRecord=new QuestionnaireRecord();
		questionnaireRecord.setQuestionnaireId(questionnaireId);
		questionnaireRecord.setUserId(userId);
		questionnaireRecord=questionnaireRecordDao.select(questionnaireRecord);
		if(questionnaireRecord == null){
			Questionnaire questionnaire=questionnaireDao.selectByPrimaryKey(questionnaireId);
			for(int i=0;i<topicId.length;i++){
				String optionName="";
				String [] optionIds=optionId[i].split(",");
				Topic topic=topicDao.selectByPrimaryKey(topicId[i]);
				QuestionnaireRecord object=new QuestionnaireRecord();
				object.setQuestionnaireId(questionnaireId);
				object.setQuestionnaireTitle(questionnaire.getTitle());
				object.setTopicId(topicId[i]);
				object.setTopicName(topic.getName());
				User user=userDao.selectByPrimaryKey(userId);
				object.setUsername(user.getRealname());
				object.setUserAccount(user.getMobile());
				object.setUserId(userId);
				for(String optionIid:optionIds){
					Option option=optionDao.selectByPrimaryKey(optionIid);
					optionName+=option.getOrdinal()+'.'+option.getName()+", ";
					object.setOptionOrdinal(option.getOrdinal());
					object.setOptionId(optionIid);
				}
				object.setOptionName(optionName.substring(0,optionName.length()-2));
				questionnaireRecordDao.insert(object);
			}
			Questionnaire question=new Questionnaire();
			question.setId(questionnaireId);
			question.setUserCount(1);
			// 设置用户金币数量变化
			{
				Integer integral = questionnaire.getIntegral();
				UserIntegral userIntegral = new UserIntegral();
				userIntegral.setIntegral(integral);
				userIntegral.setRelate(questionnaire.getId());
				userIntegral.setUserId(userId);
				userIntegral.setType(UserIntegral.TYPE_GET_QUESTION);
				userIntegral.setStatus(UserIntegral.STATUS_UN_READ);
				userIntegral.setNote("问卷调查获得" + integral + "金币");
				userIntegralService.save(userIntegral);
				User user = new User();
				user.setId(userId);
				user.setIntegral(integral);
				userService.plus(user);
				try {
					// 根据UID获取用户
					user = userDao.selectByPrimaryKey(userId);
					//积分变动模版推送
					String json_data = "";
					//组装json_data数据
					json_data = "{\"first\": {\"value\":\"亲爱的" + user.getRealname() + "，请查看您的金币变动。\",\"color\":\"#173177\"}," +
								"\"time\":{\"value\":\"" + DateUtil.getDateSampleString(new Date(), "yyyy年MM月dd日 HH:mm") + "\",\"color\":\"#173177\"}," +
								"\"add_Jifen\": {\"value\":\"" + integral + "个金币\",\"color\":\"#173177\"}," +
								"\"consume_Jifen\": {\"value\":\"0个金币\",\"color\":\"#173177\"}," +
								"\"jifen\": {\"value\":\"" + userIntegralService.getMyVaildIntegral(user.getId(), null) + "个金币\",\"color\":\"#173177\"}," +
								"\"remark\": {\"value\":\"如有疑问，请拨打高和畅客服热线400-6196-805。\",\"color\":\"#173177\"}}";
					String goldTemplateId = Constants.get("gold.templateId");
					TokenForWxapis tokenForWxapis = WxapiUtil.getWxapisToken(Constants.get("wxapi.appid"), Constants.get("wxapi.appsecret"));
					UserBind userBind = new UserBind();
					userBind.setUserId(user.getId());
					userBind = userBindDao.select(userBind);
					if (userBind != null) {
						//推送消息模版
						WxapiUtil.sendTM2WxUser(tokenForWxapis.getAccess_token(), userBind.getAccount(), goldTemplateId, "", json_data);
					}
				} catch (Exception e) {
					log.error(e.getMessage(), e);
				}
			}
			return questionnaireDao.modifyCounts(question);
		} else {
			return -1;//已经参与该调查问卷
		}
		
	}
}