package member.model.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import common.JDBCTemplate;
import member.model.dao.MemberDao;
import member.model.exception.MemberException;
import member.model.vo.Member;

import static common.JDBCTemplate.*;

/**
 * Service
 * 1. DriverClass등록(최초1회)
 * 2. Connection객체생성 url, user, password
 * 2.1 자동커밋 false설정
 * ------Dao 요청 -------
 * 6. 트랜잭션처리(DML) commit/rollback
 * 7. 자원반납(conn) 
 * 
 * Dao
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

public class MemberService {
	
	private MemberDao memberDao = new MemberDao();
//1. 회원 전체 조회
	public List<Member> selectAll() {
		Connection conn = getConnection();
		List<Member> list = memberDao.selectAll(conn);
		close(conn);
		return list;
	}
	//2. 회원 아이디 조회
	public Member selectOneMember(String memberId) {
		//1.Connection생성
		Connection conn = getConnection();
		//2.dao요청
		Member member = memberDao.selectOneMember(conn, memberId);
		//3.자원반납 - select문이랑 트랜잭션 필요없다
		close(conn);
		
		return member;
	}
	//3. 회원 이름 조회
	public List<Member> selectMemberName(String name) {
		//1.Connection생성
				Connection conn = getConnection();
				//2.dao요청
				List<Member> list  = memberDao.selectByName(conn, name);
				close(conn);
				return list;
	}
	//4. 회원 가입
	public int insertMember(Member member) {
		Connection conn = getConnection();
		int result = memberDao.insertMember(conn, member);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	// 5. 회원 정보 변경 비밀번호 구간
	public int newPassword(Member member) {
		Connection conn 	=getConnection()	;
		int result =memberDao.newPassword(conn,member);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	// 5. 회원 정보 변경 이메일 구간
	public int newEmail( Member member) {
		Connection conn 	=getConnection()	;
		int result =memberDao.newEmail(conn, member);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	// 5. 회원 정보 변경 전화번호 구간
	public int newPhone( Member member) {
		Connection conn 	=getConnection()	;
		int result =memberDao.newPhone(conn, member);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	// 5. 회원 정보 변경 주소 구간
	public int newAddress( Member member) {
		Connection conn 	=getConnection()	;
		int result =memberDao.newAddress(conn,member);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	//6. 회원 탈퇴
	public int deleteMember(Member member) {
		Connection conn 	=getConnection()	;
		int result =memberDao.deleteMember(conn, member);
		if(result > 0) commit(conn);
		else rollback(conn);
		close(conn);
		return result;
	}
	//7. 탈퇴 회원 조회
	public List<Member> selectDelAll() {
		Connection conn = getConnection();
		List<Member> list = memberDao.selectDelAll(conn);
		close(conn);
		return list;
	}
	
	
	public List<Member> selectone() {
		Connection conn = getConnection();
		List<Member> list = memberDao.selectAll(conn);
		close(conn);
		return list;
	}
	/**
	 *  
	 * 1. DriverClass등록(최초1회)
	 * 2. Connection객체생성 url, user, password
	 * 2.1 자동커밋 false설정
	 * ------Dao 요청 -------
	 * 6. 트랜잭션처리(DML) commit/rollback
	 * 7. 자원반납(conn) 
	 * @return
	 * 
	 */
	public List<Member> selectAll_() {
		String driverClass = "oracle.jdbc.OracleDriver";
		String url = "jdbc:oracle:thin:@localhost:1521:xe";
		String user = "student";
		String password = "student";
		Connection conn = null;
		List<Member> list = null;
		
		try {
			//1. DriverClass등록(최초1회)
			Class.forName(driverClass);
			//2. Connection객체생성 url, user, password
			conn = DriverManager.getConnection(url, user, password);
			//2.1 자동커밋 false설정
			conn.setAutoCommit(false);
			
			//------Dao 요청 -------
			//Connection객체 전달
			list = memberDao.selectAll(conn);
			//6. 트랜잭션처리(DML) commit/rollback
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//7. 자원반납(conn) 
			try {
				if(conn != null)
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return list;
	}
	public List<Member> selectMEMembers(String name) {
		//1.Connection생성
				Connection conn = getConnection();
				//2.dao요청
				List<Member> list  = memberDao.selectByName(conn, name);
				close(conn);
				return list;
		
		
	}
}