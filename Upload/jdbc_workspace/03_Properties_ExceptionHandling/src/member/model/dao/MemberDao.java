package member.model.dao;

import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import static common.JDBCTemplate.close;

import member.model.exception.MemberException;
import member.model.vo.Member;

public class MemberDao {
	private Properties prop = new Properties();
	/**
	 * MemberDao객체 생성시(최초1회) member-query.properties의 내용을 읽어서
	 * prop에 저장한다
	 * dao메소드 호출시마다 prop으로 부터 sql문을 받는다
	 * @param conn
	 * @return
	 */
	public MemberDao() {
		String fileName = "resources/member-query.properties";
		try {
			prop.load(new FileReader(fileName));
//			System.out.println(prop);
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	/**
	 *  Dao
	 * 
	 * 3. PreparedStatement객체 생성(미완성쿼리)
	 * 3.1 ? 값대입
	 * 4. 실행 : DML(executeUpdate) -> int, DQL(executeQuery) -> ResultSet
	 * 4.1 ResultSet -> Java객체 옮겨담기
	 * 5. 자원반납(생성역순 rset - pstmt) 
	 *
	 */
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
	//1. 회원 전체 조회
	public List<Member> selectAll(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		String sql = "select * from member order by enroll_date desc";
		String  sql =prop.getProperty("selectAll");
		List<Member> list = null;
		
		try {
			//3. PreparedStatement객체 생성(미완성쿼리)
			pstmt = conn.prepareStatement(sql);
			//3.1 ? 값대입
			
			//4. 실행 : DML(executeUpdate) -> int, DQL(executeQuery) -> ResultSet
			rset = pstmt.executeQuery();
			//4.1 ResultSet -> Java객체 옮겨담기
			list = new ArrayList<>();
			while(rset.next()) {
				String memberId = rset.getString("member_id");
				String password = rset.getString("password");
				String memberName = rset.getString("member_name");
				String gender = rset.getString("gender");
				int age = rset.getInt("age");
				String email = rset.getString("email");
				String phone = rset.getString("phone");
				String address = rset.getString("address");
				String hobby = rset.getString("hobby");
				Date enrollDate = rset.getDate("enroll_date");
				Member member = new Member(memberId, password, memberName, gender, age, email, phone, address, hobby, enrollDate);
				list.add(member);
			}
			
	} catch (SQLException e) {
//		e.printStackTrace();
		throw new MemberException("회원 전체 조회", e);
	}finally {
		//5. 자원반납(생성순서 역순)
		close(rset);
		close(pstmt);
	}
	return list;
}
	//2. 회원 아이디 조회
	public Member selectOneMember(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		String sql = "select * from member where member_id = ?";
		String sql = prop.getProperty("selectOne");
		Member member = null;
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				memberId = rset.getString("member_id");
				String password = rset.getString("password");
				String memberName = rset.getString("member_name");
				String gender = rset.getString("gender");
				int age = rset.getInt("age");
				String email = rset.getString("email");
				String phone = rset.getString("phone");
				String address = rset.getString("address");
				String hobby = rset.getString("hobby");
				Date enrollDate = rset.getDate("enroll_date");
				member = new Member(memberId, password, memberName, gender, age, email, phone, address, hobby, enrollDate);
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			throw new MemberException("아이디 조회",e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return member;
	}
	//3. 회원 이름 조회
	public List<Member> selectByName(Connection conn, String memberName) {
		PreparedStatement pstmt = null;
		ResultSet rset = null; // DQL이기 때문
//		String sql = "select * from member where member_name = ?";
		String sql = prop.getProperty("selectByName");
		List<Member> list = null;

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberName);
			rset = pstmt.executeQuery();
			list = new ArrayList<>();
			
			while (rset.next()) {
				String memberId = rset.getString("member_id");
				String password = rset.getString("password");
				memberName = rset.getString("member_name");
				String gender = rset.getString("gender");
				int age = rset.getInt("age");
				String email = rset.getString("email");
				String phone = rset.getString("phone");
				String address = rset.getString("address");
				String hobby = rset.getString("hobby");
				Date enrollDate = rset.getDate("enroll_date");
				Member member = new Member(memberId, password, memberName, gender, age, email, phone, address, hobby,
						enrollDate);
				list.add(member);
			}
		} catch (SQLException e) {
//			e.printStackTrace();
			throw new MemberException("이름조회",e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
	//4. 회원 가입
	public int insertMember(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		int result = 0;
//		String sql = "insert into member values(?, ?, ?, ?, ?, ?, ?, ?, ?, default)";
		String sql = prop.getProperty("insertMember");
		try {
			//3. PreparedStatement 객체 생성(미완성 쿼리)
			pstmt = conn.prepareStatement(sql);
			//3.1 ? 값대입
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getMemberName());
			pstmt.setString(4, member.getGender());
			pstmt.setInt(5, member.getAge());
			pstmt.setString(6, member.getEmail());
			pstmt.setString(7, member.getPhone());
			pstmt.setString(8, member.getAddress());
			pstmt.setString(9, member.getHobby());
			//4. 실행 DML(executeUpdate)-> 정수형 리턴, DQL(executeQuery)-> resultSet으로 리턴
			result = pstmt.executeUpdate();
			//4.1 DQL인 경우 ResultSet -> JAVA객체로 옮겨담기
		} catch (SQLException e) {
//			e.printStackTrace();
			throw new MemberException("회원가입",e);
		}finally {
			//5. 자원반납(생성순서 역순)
			close(pstmt);
		}
		return result;
	}
	// 5. 회원 정보 변경 비밀번호 구간
	public int newPassword(Connection conn,Member member) {
		PreparedStatement pstmt = null;
		int result = 0;
//		String sql = "update member set password = ? where member_id = ?";
		String sql = prop.getProperty("newPassword");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getMemberId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			throw new MemberException("비밀번호 수정",e);
		}finally {
			close(pstmt);
		}
		return result;
	}
	// 5. 회원 정보 변경 이메일 구간
	public int newEmail(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		int result = 0;
//		String sql = "update member set password = ? where member_id = ?";
		String sql = prop.getProperty("newEmail");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getMemberId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			throw new MemberException("이메일 수정",e);
		}finally {
			close(pstmt);
		}
		return result;
	}
	// 5. 회원 정보 변경 전화번호 구간
	public int newPhone(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		int result = 0;
//		String sql = "update member set password = ? where member_id = ?";
		String sql = prop.getProperty("newPhone");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getMemberId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			throw new MemberException("전화번호수정",e);
		}finally {
			close(pstmt);
		}
		return result;
	}
	// 5. 회원 정보 변경 전화번호 구간
	public int newAddress(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		int result = 0;
//		String sql = "update member set password = ? where member_id = ?";
		String sql = prop.getProperty("newAddress");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getMemberId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			throw new MemberException("주소 수정",e);
		}finally {
			close(pstmt);
		}
		return result;
	}
	//6. 회원 탈퇴
	public int deleteMember(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		int result = 0;
//		String sql = "delete member where member_id = ? and password = ?";
		String sql = prop.getProperty("deleteMember");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getPassword());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
//			e.printStackTrace();
			throw new MemberException("회원탈퇴",e);
		}
		return result;
	}
	//7. 탈퇴 회원 조회
	public List<Member> selectDelAll(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
//		String sql = "select * from member order by enroll_date desc";
		String  sql =prop.getProperty("selectDelAll");
		List<Member> list = null;
		
		try {
			//3. PreparedStatement객체 생성(미완성쿼리)
			pstmt = conn.prepareStatement(sql);
			//3.1 ? 값대입
			
			//4. 실행 : DML(executeUpdate) -> int, DQL(executeQuery) -> ResultSet
			rset = pstmt.executeQuery();
			//4.1 ResultSet -> Java객체 옮겨담기
			list = new ArrayList<>();
			while(rset.next()) {
				String memberId = rset.getString("member_id");
				String password = rset.getString("password");
				String memberName = rset.getString("member_name");
				String gender = rset.getString("gender");
				int age = rset.getInt("age");
				String email = rset.getString("email");
				String phone = rset.getString("phone");
				String address = rset.getString("address");
				String hobby = rset.getString("hobby");
				Date enrollDate = rset.getDate("del_date");
				Member member = new Member(memberId, password, memberName, gender, age, email, phone, address, hobby, enrollDate);
				list.add(member);
			}
			
	} catch (SQLException e) {
//		e.printStackTrace();
		throw new MemberException("탈퇴회원 전체조회", e);
	}finally {
		//5. 자원반납(생성순서 역순)
		close(rset);
		close(pstmt);
	}
	return list;
}

	
	public Member selectOne(Connection conn, String memberId){
		Member m = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//미리준비된 statement(query)
		String query = "select * from member where member_id=?";
		
		try {
			//미완성쿼리문을 가지고 객체생성함
			pstmt = conn.prepareStatement(query);
			//쿼리문 완성작업
			pstmt.setString(1, memberId);
			//쿼리문실행
			//pstmt에 이제 완성된 쿼리를 가지고 있기때문에 파라미터없이 실행한다.
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				m = new Member();
				m.setMemberId(rset.getString("member_id"));
				m.setPassword(rset.getString("password"));
				m.setMemberName(rset.getString("member_name"));
				m.setGender(rset.getString("gender"));
				m.setAge(rset.getInt("age"));
				m.setEmail(rset.getString("email"));
				m.setPhone(rset.getString("phone"));
				m.setAddress(rset.getString("address"));
				m.setHobby(rset.getString("hobby"));
				m.setEnrollDate(rset.getDate("enroll_date"));
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
			
		}
		
		return m;
	}
	public int updateMember(Connection conn, Member m) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update member set "
					 + " password=?"
					 + ",email=?"
					 + ",phone=?"
					 + ",address=?"
					 + " where member_id=?";
		
		try {
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, m.getPassword());
			pstmt.setString(2, m.getEmail());
			pstmt.setString(3, m.getPhone());
			pstmt.setString(4, m.getAddress());
			pstmt.setString(5, m.getMemberId());
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}
}