package com.spring.recruit.dao.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.recruit.dao.RecruitDao;
import com.spring.recruit.vo.CareerVo;
import com.spring.recruit.vo.CertVo;
import com.spring.recruit.vo.EduVo;
import com.spring.recruit.vo.RecruitVo;

@Repository
public class RecruitDaoImpl implements RecruitDao{

	@Autowired
	SqlSession sqlSession;
	
	@Override
	public RecruitVo selectRecruit(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("selectRecruit", recruitVo);
	}
	
	@Override
	public List<EduVo> selectEdu(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectEdu", recruitVo);
	}

	@Override
	public List<CareerVo> selectCareer(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectCareer", recruitVo);
	}

	@Override
	public List<CertVo> selectCert(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("selectCert", recruitVo);
	}
	
	@Override
	public int insertRecruit(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("insertRecruit", recruitVo);
	}
	
	@Override
	public int updateRecruit(RecruitVo recruitVo) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("updateRec", recruitVo);
	}

	@Override
	public int mergeEdu(List<EduVo> eduList) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("mergeEdu", eduList);
	}
	
	@Override
	public int mergeCareer(List<CareerVo> careerList) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("mergeCar", careerList);
	}
	
	@Override
	public int mergeCert(List<CertVo> certList) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.update("mergeCert", certList);
	}

	@Override
	public int deleteEdu(List<EduVo> eduList) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("deleteEdu", eduList);
	}

	@Override
	public int deleteCareer(List<CareerVo> carList) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("deleteCareer", carList);
	}

	@Override
	public int deleteCert(List<CertVo> certList) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("deleteCert", certList);
	}
}
