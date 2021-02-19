package Stock.model;

import static Stock.common.JDBCTemplate.closeR;
import static Stock.common.JDBCTemplate.closeS;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import Stock.controller.ProductController;
import Stock.vo.Stock;
import Stock.vo.StockIO;

public class StockDAO {
	int result = 0;
	Properties prop = new Properties();
	String ID;
	String name;
	int amount= 0;

	public StockDAO() {
		try {
			prop.load(new FileReader("Resources/stock-query.properties"));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public List<Stock> selectAll(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAll");
		List<Stock> list = new ArrayList<>();

		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();

			while (rset.next()) {
				Stock stock = new Stock();
				stock.setProductID(rset.getString("product_id"));
				stock.setpName(rset.getString("product_name"));
				stock.setPrice(rset.getInt("price"));
				stock.setDescription(rset.getString("description"));
				stock.setStock(rset.getInt("stock"));
				list.add(stock);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeR(rset);
			closeS(pstmt);
		}
		return list;
	}

	public String getID(Connection conn, String inputID) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getID");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, inputID);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				ID = rset.getString("product_id");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeR(rset);
			closeS(pstmt);
		}
		return ID;
	}

	public List<Stock> selectID(Connection conn, String inputID) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Stock> list = new ArrayList<>();
		String sql = prop.getProperty("selectID");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + inputID + "%");
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Stock stock = new Stock();
				stock.setProductID(rset.getString("product_id"));
				stock.setpName(rset.getString("product_name"));
				stock.setPrice(rset.getInt("price"));
				stock.setDescription(rset.getString("description"));
				stock.setStock(rset.getInt("stock"));
				list.add(stock);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeR(rset);
			closeS(pstmt);
		}
		return list;
	}

	public List<Stock> selectName(Connection conn, String nameStr) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<Stock> list = new ArrayList<>();
		String sql = prop.getProperty("selectName");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + nameStr + "%");
			rset = pstmt.executeQuery();
			while (rset.next()) {
				Stock stock = new Stock();
				stock.setProductID(rset.getString("product_id"));
				stock.setpName(rset.getString("product_name"));
				stock.setPrice(rset.getInt("price"));
				stock.setDescription(rset.getString("description"));
				stock.setStock(rset.getInt("stock"));
				list.add(stock);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeR(rset);
			closeS(pstmt);
		}
		return list;
	}

	public int insertProduct(Connection conn, Stock stock) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insert");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stock.getProductID());
			pstmt.setString(2, stock.getpName());
			pstmt.setInt(3, stock.getPrice());
			pstmt.setString(4, stock.getDescription());
			pstmt.setInt(5, stock.getStock());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeS(pstmt);
		}
		return result;
	}

	public int deleteProduct(Connection conn, Stock stock) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("delete");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stock.getProductID());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public int updateProduct(Connection conn, Stock stock, String whichOne) {
		int result = 0;
		PreparedStatement pstmt = null;
		String part1 = prop.getProperty("update1");
		String part2 = whichOne;
		String part3 = prop.getProperty("update3");
		String sql = part1 + part2 + part3;
		try {
			pstmt = conn.prepareStatement(sql);
			switch (whichOne) {
			case "product_name":
				pstmt.setString(1, stock.getpName());
				break;
			case "price":
				pstmt.setInt(1, stock.getPrice());
				break;
			case "description":
				pstmt.setString(1, stock.getDescription());
				break;
			}
			pstmt.setString(2, stock.getProductID());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeS(pstmt);
		}
		return result;
	}

	public List<StockIO> selectAllio(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAllio");
		List<StockIO> list = new ArrayList<>();

		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();

			while (rset.next()) {
				StockIO stockIO = new StockIO();
				stockIO.setIoNo(rset.getInt("io_no"));
				stockIO.setProductID(rset.getString("product_id"));
				stockIO.setIoDate(rset.getDate("iodate"));
				stockIO.setAmount(rset.getInt("amount"));
				stockIO.setStatus(rset.getString("status"));
				list.add(stockIO);
			}
			return list;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeR(rset);
			closeS(pstmt);
		}
		return list;	}

	public int addStock(Connection conn, StockIO stockIO, int i) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = null;
		if(i == 1) 
		sql = prop.getProperty("addStock");
		else sql = prop.getProperty("subtractStock");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, stockIO.getProductID());
			pstmt.setInt(2, stockIO.getAmount());
		
			result = pstmt.executeUpdate();
		} catch(NullPointerException npe) {
			System.out.println("Input Amount less than Existing Amount of Stock.\nPlease check Again.");
			System.exit(0);
		}catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeS(pstmt);
		}
		return result;
	}

	public int getAmount(Connection conn, String productID) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("getAmount");
		try {

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productID);
			rset = pstmt.executeQuery();
			while (rset.next()) {
				amount = rset.getInt("stock");
				}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			closeR(rset);
			closeS(pstmt);
		}
		return amount;
	}
}