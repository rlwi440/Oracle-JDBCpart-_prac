package member.controller;

import java.util.List;

import member.model.exception.MemberException;
import member.model.service.MemberService;
import member.model.vo.Member;
import member.view.MemberMenu;

public class MemberController {
	/*
	 * 		1. 회원 전체 조회
				2. 회원 아이디 조회
				3. 회원 이름 조회
				4. 회원 가입
				5. 회원 정보 변경
				6. 회원 탈퇴
				7. 탈퇴 회원 조회
				0. 프로그램 끝내기
	 */
	private MemberService memberService = new MemberService();
//	1. 회원 전체 조회\n
	public List<Member> selectAll() {
		List<Member> list =null;
		try {
			list =memberService.selectAll();
			//서버로깅
			//관리자 이메일 알림
			
			//사용자 피드백
		}catch (MemberException e) {
			new MemberMenu().displayError(e.getMessage()+" : 관리자에게 문의하세요.");
		}
		return list ;
	}
	//2. 회원 아이디 조회
	public Member selectone(String inputMemberId) {
		Member member =null;
		try {
			member =memberService.selectOneMember(inputMemberId);
			//서버로깅
			//관리자 이메일 알림
			//사용자 피드백
		}catch (MemberException e) {
			new MemberMenu().displayError(e.getMessage()+" : 관리자에게 문의하세요.");
		}
		return member;
	}
//3. 회원 이름 조회
	public List<Member> selectMemberName(String intputMemberName) {
		List<Member> list =null;
		try {
			list =memberService.selectMemberName(intputMemberName);
			//서버로깅
			//관리자 이메일 알림
			
			//사용자 피드백
		}catch (MemberException e) {
			new MemberMenu().displayError(e.getMessage()+" : 관리자에게 문의하세요.");
		}
		return list ;
	}	
//4. 회원 가입
	public int insertMember(Member member) {
		int result =0;
		try {
			result =memberService.insertMember(member);
			//서버로깅
			//관리자 이메일 알림
			
			//사용자 피드백
		}catch (MemberException e) {
			new MemberMenu().displayError(e.getMessage()+" : 관리자에게 문의하세요.");
		}
		return result;
	}


	// 5. 회원 정보 변경 비밀번호 구간
	public int newPassword( Member member) {
	int result =0;
	try {
		result =memberService.newPassword(member);
	}catch(MemberException e) {
		new MemberMenu().displayError(e.getMessage() + " : 관리자에게 문의하세요.");
		}
	return result;
	}
	// 5. 회원 정보 변경 이메일 구간
	public int newEmail(Member member) {
		int result =0;
		try {
			result =memberService.newEmail( member);
		}catch(MemberException e) {
			new MemberMenu().displayError(e.getMessage() + " : 관리자에게 문의하세요.");
			}
		return result;
		}
	// 5. 회원 정보 변경 전화번호 구간
	public int newPhone( Member member) {
		int result =0;
		try {
			result =memberService.newPhone(member);
		}catch(MemberException e) {
			new MemberMenu().displayError(e.getMessage() + " : 관리자에게 문의하세요.");
			}
		return result;
		}
	// 5. 회원 정보 변경 주소 구간
	public int newAddress( Member member) {
		int result =0;
		try {
			result =memberService.newAddress(member);
		}catch(MemberException e) {
			new MemberMenu().displayError(e.getMessage() + " : 관리자에게 문의하세요.");
			}
		return result;
		}
	//6. 회원 탈퇴
	public int deleteMember(Member  member) {
		int result =0;
		try {
			result =memberService.deleteMember(member);
		}catch(MemberException e) {
			new MemberMenu().displayError(e.getMessage() + " : 관리자에게 문의하세요.");
			}
		return result;
		}
//7. 탈퇴 회원 조회
	public List<Member> selectDelAll() {
		List<Member> list =null;
		try {
			list =memberService. selectDelAll();
			//서버로깅
			//관리자 이메일 알림
			
			//사용자 피드백
		}catch (MemberException e) {
			new MemberMenu().displayError(e.getMessage()+" : 관리자에게 문의하세요.");
		}
		return list ;
	}
}