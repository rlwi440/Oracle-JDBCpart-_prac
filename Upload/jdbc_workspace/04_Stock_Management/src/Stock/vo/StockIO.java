package Stock.vo;

import java.sql.Date;

public class StockIO {

	private int ioNo;
	private String productID;
	private Date ioDate;
	private int amount;
	private String status;
	@Override
	public String toString() {
		return ioNo+"\t"+productID+"\t"+ioDate+"\t"+amount+"\t"+status;
	}
	public int getIoNo() {
		return ioNo;
	}
	public void setIoNo(int ioNo) {
		this.ioNo = ioNo;
	}
	public String getProductID() {
		return productID;
	}
	public void setProductID(String productID) {
		this.productID = productID;
	}
	public Date getIoDate() {
		return ioDate;
	}
	public void setIoDate(Date ioDate) {
		this.ioDate = ioDate;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public StockIO(int ioNo, String productID, Date ioDate, int amount, String status) {
		super();
		this.ioNo = ioNo;
		this.productID = productID;
		this.ioDate = ioDate;
		this.amount = amount;
		this.status = status;
	}
	public StockIO() {
		super();
	}
	
	public StockIO(String productID, int amount) {

		this.productID = productID;
		this.amount = amount;
	}
}