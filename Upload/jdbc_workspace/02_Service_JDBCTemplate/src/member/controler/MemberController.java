package member.controler;

import java.util.List;

import member.model.service.MemberService;
import member.model.vo.Member;

public class MemberController {

	private MemberService memberService = new MemberService();

	public List<Member> selectAll() {
		return memberService.selectAll();
	}

	public int insertMember(Member member) {
		return memberService.insertMember(member);
	}


	public Member selectone(String inputMemberId) {
		return memberService.selectOneMember(inputMemberId);
	}

	public List<Member> selectMemberName(String intputMemberName) {
		return memberService.selectMemberName(intputMemberName);
	}

	public int newPassword(String password, Member member) {
		return memberService.newPassword(password,member);
	}

	public int newEmail(String email, Member member) {
		return  memberService.newEmail(email,member);
	}

	public int newPhone(String phone, Member member) {
		return memberService.newPhone( phone,member);
	}

	public int newAddress(String address, Member member) {
		return  memberService.newAddress(address,member);
	}
	public int deleteMember(String memberId) {
		return memberService.deleteMember(memberId);
	}
	

}