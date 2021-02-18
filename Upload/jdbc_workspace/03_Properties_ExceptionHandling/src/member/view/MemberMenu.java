package member.view;

import java.util.List;
import java.util.Scanner;

import member.controller.MemberController;
import member.model.vo.Member;

public class MemberMenu {
	/**
	 * 줄정리 하는습관, MAC 흐름구분 공부 (완료) ,resorces(완료) 
	 * 메뉴번호 0~7번 Dao부분 
	 * Exception은 Checked Exception과 Unchecked Exception으로 구분할 수 있는데, 간단하게
	 *  RuntimeException을 상속하지 않는 클래스는 Checked Exception, 반대로 상속한 클래스는 Unchecked Exception으로 분류할 수 있다.
	 * @author 깔끔한청년
	 * @Date 2020 년 02월 18일 
	 * 
	 */

	private Scanner sc = new Scanner(System.in);
	private MemberController memberController = new MemberController();

	public void mainMenu() {
		String menu = "========== 회원 관리 프로그램 ==========\n" + "1.회원 전체조회\n" + "2.회원 아이디조회\n" + "3.회원 이름조회\n"
				+ "4.회원 가입\n" + "5.회원 정보변경\n" + "6.회원 탈퇴\n"+"7.탈퇴 회원 조회\n" + "0.프로그램 끝내기\n"
				+ "======================================\n" + "선택 : ";
		do {
			System.out.print(menu);
			String choice = sc.next();
			int result = 0;
			List<Member> list = null;
			Member member = null;
			String memberId = null;
			switch (choice) {
			case "1":
				list = memberController.selectAll();
				displayMemberList(list);
				break;
			case "2":
				member = memberController.selectone(inputMemberId());
				displayMember(member);
				break;
			case "3":
				list = memberController.selectMemberName(intputMemberName());
				displayMember(list);
				break;
			case "4":
				// 1.사용자입력값 회원객체
				// 2.컨트롤러에 insertMember요청
				// 3.사용자피드백
				result = memberController.insertMember(inputMember());
				displayMsg(result > 0 ? "회원가입성공!" : "회원가입실패!");
				break;
			case "5":
				member = null;
				memberId = inputMemberId();
				member = memberController.selectone(memberId);
				if (member == null) {
					System.out.println("존재하지않은 회원입니다.");
					break;
				} else {
					displayMember(member);
				}
				member = memberController.selectone(memberId);
				if (member == null)
					System.out.println("회원이 존재하지 않습니다.");
				else
					displayUpdate(member);
				break;
			case "6":
				member = deleteMember();		//private Scanner 
				result = memberController.deleteMember(member);
				displayMsg(result > 0 ? "회원탈퇴 성공" : "회원탈퇴실패");
				break;
			case "7":
				list = memberController.selectDelAll();
				displayMemberList(list);
				break;
			case "0":
				System.out.print("정말 끝내시겠습니까?(y/n) : ");
				if (sc.next().charAt(0) == 'y')
					return;
				break;
			default:
				System.out.println("잘못 입력하셨습니다.");
			}
		} while (true);

	}

	private Member deleteMember() {
		Member member = new Member();
		System.out.print("탈퇴할 아이디 : ");
		member.setMemberId(sc.next());
		System.out.print("비밀번호 : ");
		member.setPassword(sc.next());
		return member;
	}

	private void displayUpdate(Member member) {
		while (true) {
			String subMenu = "======================= 회원 정보 변경 메뉴 =======================\n" // String subString
					+ "1. 암호 변경\n" + "2. 이메일 변경\n" + "3. 전화번호 변경\n" + "4. 주소 변경\n" + "9. 메인메뉴 돌아가기\n"
					+ "=============================================================\n" + "선택 : ";
			System.out.print(subMenu);
			int choice = sc.nextInt();
			int result = 0;
			switch (choice) {
			case 1:
				System.out.println("새 비밀번호: ");
				String password = sc.next();
				result = memberController.newPassword( member);
				displayMsg(result > 0 ? "비밀번호 변경 성공!" : "비밀번호 변경 실패!");
				member = memberController.selectone(member.getMemberId());
				displayMember(member);
				break;
			case 2:
				System.out.println("새 이메일: ");
				String email = sc.next();
				result = memberController.newEmail( member);
				displayMsg(result > 0 ? "이메일 변경 성공!" : "이메일 변경 실패!");
				member = memberController.selectone(member.getMemberId());
				displayMember(member);
			case 3:
				System.out.println("새 전화번호 ");
				String phone = sc.next();
				result = memberController.newPhone(member);
				displayMsg(result > 0 ? "전화번호 변경 성공!" : "전화번호 변경 실패!");
				member = memberController.selectone(member.getMemberId());
				displayMember(member);
				break;
			case 4:
				System.out.println("새 주소 ");
				String address = sc.nextLine();
				result = memberController.newAddress(member);
				displayMsg(result > 0 ? "주소 변경 성공!" : "주소 변경 실패!");
				member = memberController.selectone(member.getMemberId());
				displayMember(member);
				break;
			case 9:
				System.out.println("메인화면으로 돌아갑니다.");
				return;

			default:
				System.out.println("잘못입력하셨습니다.");
				break;
			}
		}
	}

	private void displayMsg(String msg) {
		System.out.println(msg);
	}

	private Member inputMember() {
		System.out.println("새로운 회원정보를 입력하세요.");
		System.out.println("-------------------------------");
		System.out.print("아이디 : ");
		String memberId = sc.next();
		System.out.println("비밀번호 : ");
		String password = sc.next();
		System.out.println("이름 : ");
		String memberName = sc.next();
		System.out.println("나이 : ");
		int age = sc.nextInt();
		System.out.println("성별(M/F) : ");
		String gender = sc.next().toUpperCase();
		System.out.println("이메일 : ");
		String email = sc.next();
		System.out.println("전화번호(-빼고 입력) : ");
		String phone = sc.next();
		sc.nextLine(); // 개행문자 날리기용
		System.out.println("주소 : ");
		String address = sc.nextLine();
		System.out.println("취미(,으로 나열) : ");
		String hobby = sc.nextLine();

		return new Member(memberId, password, memberName, gender, age, email, phone, address, hobby, null);
	}

	private String intputMemberName() {
		System.out.println("조회할 이름 입력: ");
		return sc.next();
	}

	private void displayMember(List<Member> list) {
		System.out.println("=======================================");
		// 조회된 회원정보가 있을 때
		if (list != null && !list.isEmpty()) {
			System.out.println("memberId\tMemberName\tGender\tAge\tEmail\tPhone\tAddress\tHobby\tEnrollDate");
			// "memberId\tMemberName\tGender\tAge\tEmail\tPhone\tAddress\tHobby\tEnrollDate\tDel_date\tDel_flag"
			System.out.println("--------------------------------------------------------------------------------");
			for (Member member : list)
				System.out.println(member);
		}
		// 조회된 회원정보가 없을 때
		else {
			System.out.println("조회된 회원이 없습니다.");
		}
		System.out.println("=======================================");
	}

	private String inputMemberName() {
		System.out.print("조회할 이름 입력 : ");
		return sc.next();
	}

	private void displayMember(Member member) {
		if (member != null) {
			System.out.println("======================");
			System.out.println(member);
			System.out.println("======================");
		} else
			System.out.println("조회된정보가 없습니다");
	}

	private String inputMemberId() {
		System.out.println("조회할 아이디를 입력 :");
		return sc.next();
	}

	/**
	 * n행의 회원정보 출력
	 * 
	 * @param list
	 */
	private void displayMemberList(List<Member> list) {
		if (list != null && !list.isEmpty()) {
			System.out.println(
					"==========================================================================================");
			for (int i = 0; i < list.size(); i++)
				System.out.println((i + 1) + " : " + list.get(i));
			System.out.println(
					"==========================================================================================");
		} else {
			System.out.println(">>> 조회된 회원 정보가 없습니다.");
		}
	}

	/**
	 * 사용자에게 오류메세지 출력하시
	 * @param errorMsg
	 */

	public void displayError(String errorMsg) {
		System.err.println(errorMsg);
	}
}