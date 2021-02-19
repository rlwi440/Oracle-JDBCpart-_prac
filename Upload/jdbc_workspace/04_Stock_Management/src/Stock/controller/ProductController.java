package Stock.controller;

import java.util.List;

import Stock.service.StockService;
import Stock.view.ProductMenu;
import Stock.vo.Stock;
import Stock.vo.StockIO;

public class ProductController {

	private StockService service = new StockService();
	int result = 0;
	int amount = 0;
	String ID;

	public void selectAll() {
		// Must declare menu(view) to Local Variable.
		// (If declare to Field Variable, it cause StackOverFlow.)
		ProductMenu menu = new ProductMenu();
		try {
			List<Stock> list = service.selectAll();
			menu.displayList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public String getID(String inputID) {
		ID = service.getID(inputID);
		return ID;
	}
	public int getAmount(String productID) {
		amount = service.getAmount(productID);
		return amount;
	}

	public void selectID(String IDStr) {
		ProductMenu menu = new ProductMenu();
		Stock stock = new Stock();
		try {
			List<Stock> list = service.selectID(IDStr);
			menu.displayList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void selectName(String nameStr) {
		ProductMenu menu = new ProductMenu();
		Stock stock = new Stock();
		try {
			List<Stock> list = service.selectName(nameStr);
			menu.displayList(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void insertProduct(Stock stock) {
		ProductMenu menu = new ProductMenu();
		try {
			int result = service.insertProduct(stock);
			menu.displayMsg(result, "Insert");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void deleteStock(Stock stock) {
		ProductMenu menu = new ProductMenu();
		try {
			int result = service.deleteProduct(stock);
			menu.displayMsg(result, "Delete");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void updateProduct(Stock stock, String whichOne) {
		ProductMenu menu = new ProductMenu();
		try {
			int result = service.updateProduct(stock, whichOne);
			menu.displayMsg(result, "Update");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void selectAllio() {
		ProductMenu menu = new ProductMenu();
		try {
			List<StockIO> list = service.selectAllio();
			menu.displayListIO(list);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void addStock(StockIO stockIO, int i) {
		//Remark: if int i = 0, decrement. int i = 1, increment
		ProductMenu menu = new ProductMenu();
		try {
			int result = service.addStock(stockIO, i);
			if(i == 1) {
			menu.displayMsg(result, "Carry On");
			}else menu.displayMsg(result, "Take Off");
		} catch(Exception e){
			e.printStackTrace();
		}
	}
}
