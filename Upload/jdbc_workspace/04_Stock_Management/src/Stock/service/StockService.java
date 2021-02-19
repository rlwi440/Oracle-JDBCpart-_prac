package Stock.service;

import static Stock.common.JDBCTemplate.cORr;
import static Stock.common.JDBCTemplate.closeC;
import static Stock.common.JDBCTemplate.getConnection;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.List;

import Stock.model.StockDAO;
import Stock.vo.Stock;
import Stock.vo.StockIO;
import member.model.vo.Member;

public class StockService {
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
	
	private StockDAO DAO = new StockDAO();
	List<Stock> list = null;
	Connection conn = null;
	String ID;
	int amount = 0;
	int result = 0;
	public List<Stock> selectAll() {
		conn = getConnection();
		list = DAO.selectAll(conn);
		closeC(conn);
		return list;
	}

	
	public String getID(String inputID) {
		conn = getConnection();
		ID = DAO.getID(conn, inputID);
		closeC(conn);
		return ID;
	}

	public List<Stock> selectID(String inputID) {
		conn = getConnection();
		list = DAO.selectID(conn, inputID);
		closeC(conn);
		return list;
	}
	public List<Stock> selectName(String nameStr) {
		conn = getConnection();
		list = DAO.selectName(conn, nameStr);
		closeC(conn);
		return list;
	}


	public int insertProduct(Stock stock) {
		conn = getConnection();
		result = DAO.insertProduct(conn, stock);
		cORr(result, conn);
		closeC(conn);
		return result;
	}


	public int deleteProduct(Stock stock) {
		conn = getConnection();
		result = DAO.deleteProduct(conn, stock);
		cORr(result, conn);
		closeC(conn);
		return result;
	}


	public int updateProduct(Stock stock, String whichOne) {
		conn = getConnection();
		result = DAO.updateProduct(conn, stock, whichOne);
		cORr(result, conn);
		closeC(conn);
		return result;
	}


	public List<StockIO> selectAllio() {
		List<StockIO> list = null;
		conn = getConnection();
		list = DAO.selectAllio(conn);
		closeC(conn);
		return list;	
		}


	public int addStock(StockIO stockIO, int i) {
		conn = getConnection();
		result = DAO.addStock(conn, stockIO, i);
		cORr(result, conn);
		closeC(conn);
		return result;
	}


	public int getAmount(String productID) {
		conn = getConnection();
		amount = DAO.getAmount(conn, productID);
		closeC(conn);
		return amount;
	}

}
