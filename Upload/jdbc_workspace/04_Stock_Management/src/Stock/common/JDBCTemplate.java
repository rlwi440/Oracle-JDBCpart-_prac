package Stock.common;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;


	public class JDBCTemplate {

		private static String driver;
		private static String url;
		private static String user;
		private static String password;

		static {
			try {
				Properties prop = new Properties();
				try {
					prop.load(new FileReader("Resources/datasource.properties"));
					driver = prop.getProperty("driver");
					url = prop.getProperty("url");
					user = prop.getProperty("user");
					password = prop.getProperty("password");
					Class.forName(driver);

				} catch (IOException e) {
					e.printStackTrace();
				}
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}

		public static Connection getConnection() {
			Connection conn = null;
			try {
				conn = DriverManager.getConnection(url, user, password);
				conn.setAutoCommit(false);

			} catch (SQLException e) {
				e.printStackTrace();
			}
			return conn;
		}

		public static void cORr(int result, Connection conn) {
			if (result > 0)
				try {
					if (conn != null && !conn.isClosed())
						conn.commit();
				} catch (SQLException e) {
					e.printStackTrace();
				}
			else
				try {
					if (conn != null && !conn.isClosed())
						conn.rollback();
				} catch (SQLException e) {
					e.printStackTrace();
				}
		}

		public static void closeC(Connection conn) {
			try {
				if (conn != null && !conn.isClosed())
					conn.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		public static void closeS(Statement stmt) {
			try {
				if (stmt != null && !stmt.isClosed())
					stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

		public static void closeR(ResultSet rset) {
			try {
				if (rset != null && !rset.isClosed())
					rset.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
