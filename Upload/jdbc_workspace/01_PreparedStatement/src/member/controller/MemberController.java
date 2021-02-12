package member.controller;

import java.util.List;

import member.model.dao.MemberDao;
import model.vo.Member;

/**
 * 
 * MVC패턴의 시작점이자 전체흐름을 제어.
 * 
 * view단으로부터 요청을 받아서 dao에 다시 요청. 그 결과를 view단에 다시 전달.
 */

public class MemberController {
	private MemberDao memberDao = new MemberDao();

	public int insertMember(Member member) {
		return memberDao.insertMember(member);
	}

	public List<Member> selectAll() {
		return memberDao.selectAll();
	}

	public Member selectOne(String memberId) {
		return memberDao.selectOne(memberId);
	}

	// 이름조회구간
	public Member selectName(String memberName) {
		return memberDao.selectName(memberName);
	}

	// 아이디 하나 조회하는 메서드 구간
	public Member selectone(String memberId, String memberPassWord) {
		return memberDao.selectOne(memberId, memberPassWord);
	}

	/*
	 * public int insertMember(Member member) { return
	 * memberDao.insertMember(member); }
	 * 
	 */
	// 회원정보 수정구간
	public int changeMember(Member member) {
		return memberDao.changeMember(member);
	}

	// 회원탈퇴
	public int deleteMember(Member member) {
		return memberDao.deleteMember(member);
	}

}
