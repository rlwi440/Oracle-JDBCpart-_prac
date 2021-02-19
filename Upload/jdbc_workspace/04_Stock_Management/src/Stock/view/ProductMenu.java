package Stock.view;

import java.util.ArrayList;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

import Stock.controller.ProductController;
import Stock.vo.Stock;
import Stock.vo.StockIO;

public class ProductMenu {
	// Field Variables Declaration
	Scanner sc = new Scanner(System.in);
	Stock stock = new Stock();
	StockIO stockIO = new StockIO();
	ProductController pc = new ProductController();
	List<Stock> list = new ArrayList<>();
	List<Stock> selectByID = new ArrayList<>();
	List<Stock> selectByName = new ArrayList<>();
	String IDStr;
	String nameStr;
	String pDescStr;
	String realID;
	String realName;
	int existingStock = 0;
	String mainMenu = "***** 상품재고관리프로그램 *****\r\n" + "1. 전체상품조회\r\n" + "2. 상품아이디검색\r\n" + "3. 상품명검색\r\n" + "4. 상품추가\r\n"
			+ "5. 상품정보변경\r\n" + "6. 상품삭제\r\n" + "7. 상품입/출고 메뉴\r\n" + "9. 프로그램종료";
	String modifyMenu = "***** 상품정보변경메뉴 *****\r\n" + "1.상품명변경\r\n" + "2.가격변경\r\n" + "3.설명변경\r\n" + "9.메인메뉴로 돌아가기";
	String ioMenu = "***** 상품입출고메뉴*****\r\n" + "1. 전체입출고내역조회\r\n" + "2. 상품입고\r\n" + "3. 상품출고\r\n" + "9. 메인메뉴로 돌아가기";

	public void mainMenu() {
		while (true) {
			System.out.println(mainMenu);
			int choice1 = Integer.parseInt(sc.nextLine());
			try {
				switch (choice1) {
				case 1: // select All (DQL) (F)
					pc.selectAll();
					break;
				case 2: // select by productID (DQL) (F)
					IDStr = inputID();
					pc.selectID(IDStr);
					break;
				case 3: // select by productName (DQL) (F)
					nameStr = inputName();
					pc.selectName(nameStr);
					break;
				case 4: // insert new Product (DML) (F)
					stock = insertProduct();
					pc.insertProduct(stock);
					break;
				case 5: // update existing Product (DML) (F)
					updateMenu();
					break;
				case 6: // delete existing Product (DML) (F)
					stock = deleteStock();
					pc.deleteStock(stock);
					break;
				case 7: // management Stock Amount (DQL/DML)
					ioMenu();
					break;
				case 9: // Exit Program (F)
					System.out.println("Do you really wanna Quit? (Y/N)");
					char yn = sc.next().toUpperCase().charAt(0);
					if (yn == 'Y')
						return;
					break;
				}
			} catch (InputMismatchException imme) {
				printInvalid("Number");
				imme.printStackTrace();
			}
		}
	}

	private void ioMenu() {
		try {
			System.out.println(ioMenu);
			int choice3 = Integer.parseInt(sc.nextLine());
			switch (choice3) {
			case 1:
				pc.selectAllio();
				break;
			case 2:
				pc.selectAllio();
				stockIO = addStock(1);
				pc.addStock(stockIO, 1);
				break;
			case 3:
				pc.selectAllio();
				stockIO = addStock(0);
				pc.addStock(stockIO, 0);
				break;
			case 9:
				return;
			}
		} catch (Exception e) {
			printInvalid("Number");
			e.printStackTrace();
		}

	}

	private StockIO addStock(int i) {
		try {
			System.out.println("Which Product would you wanna carry In/take Off?\nPlease fill up the form");
			System.out.println("\"Exact\" Product ID? > ");
			String productID = sc.nextLine();
			System.out.println("Amount? > ");
			int amount = Integer.parseInt(sc.nextLine());
			existingStock = pc.getAmount(productID);

			if (i == 0) {
				if (amount <= existingStock) {
					stockIO = new StockIO(productID, amount);
				} else
					return null;
			} else if (i == 1) {
				stockIO = new StockIO(productID, amount);
			}
		} catch (Exception e) {
			printInvalid("Form");
			e.printStackTrace();
		}
		return stockIO;
	}

	private void updateMenu() {
		System.out.println(modifyMenu);
		int choice2 = Integer.parseInt(sc.nextLine());
		try {
			switch (choice2) {
			case 1:
				stock = updateProduct("product_name");
				pc.updateProduct(stock, "product_name");
				break;
			case 2:
				stock = updateProduct("price");
				pc.updateProduct(stock, "price");
				break;
			case 3:
				stock = updateProduct("description");
				pc.updateProduct(stock, "description");
				break;
			case 9:
				return;
			}
			printInvalid("Number");
		} catch (Exception e) {
			printInvalid("Form");
			e.printStackTrace();
		}
	}

	private Stock updateProduct(String whichOne) {
		pc.selectAll();
		System.out.print("which Product would you wanna modify?\nPlease insert Product ID: > ");
		String inputID = sc.nextLine();
		String newInfo;
		realID = pc.getID(inputID);

		if (inputID.contentEquals(realID)) {
			System.out.println("New " + whichOne + "? > ");
			switch (whichOne) {
			case "product_name":
				newInfo = sc.nextLine();
				stock = new Stock(inputID, newInfo, null);
				break;
			case "price":
				int newPrice = Integer.parseInt(sc.nextLine());
				stock = new Stock(inputID, newPrice);
			case "description":
				newInfo = sc.nextLine();
				stock = new Stock(inputID, newInfo);
				break;
			}
			return stock;
		}
		printInvalid("Product ID");
		return null;
	}

	private Stock deleteStock() {
		pc.selectAll();
		System.out.println("Please choose a Product ID to delete");

		System.out.println("\"Exact\" Product ID? > ");
		String inputID = sc.nextLine();
		return new Stock(inputID);
	}

	private Stock insertProduct() {
		System.out.println("system: Please fill up the form");

		System.out.print("Product ID: > ");
		stock.setProductID(sc.nextLine());

		System.out.print("Product Name: >");
		stock.setpName(sc.nextLine());

		System.out.print("Price: > ");
		stock.setPrice(Integer.parseInt(sc.nextLine()));

		System.out.print("Description: > ");
		stock.setDescription(sc.nextLine());

		System.out.print("Stock: > ");
		stock.setStock(Integer.parseInt(sc.nextLine()));

		return stock;
	}

	private String inputName() {
		System.out.println("Product Name? > ");
		String inputName = sc.nextLine();
		return inputName;
	}

	private String inputID() {
		System.out.println("Product ID? > ");
		String inputID = sc.nextLine();
		return inputID;
	}

	public void displayMsg(int result, String msg) {
		if (result > 0 && msg == "Delete" || result > 0 && msg == "Update")
			System.out.println("Process Success: successfully " + msg + "d");
		else if (result > 0 && msg == "Carry On" || result > 0 && msg == "Take Off")
			System.out.println("Process Success: successfully " + msg);
		else if (result > 0 && msg != "Delete")
			System.out.println("Process Success: successfully " + msg + "ed");

		else
			System.out.println("Process Failed: " + msg + " failed");
	}

	public void printInvalid(String msg) {
		System.out.println("system: Invalid " + msg + ".\nPlease Check Again\n");
	}

	public void displayList(List<Stock> list) {
		System.out.println("--------------------------------------------------------------\r\n"
				+ "PRODUCT ID	    PRODUCT NAME	    PRICE	    DESCRIPTION     STOCK\r\n"
				+ "--------------------------------------------------------------");
		if (list == null || list.isEmpty()) {
			printInvalid("Data");
			System.out.println("--------------------------------------------------------------");
		} else {
			for (Stock stock : list) {
				System.out.println(stock);
			}
			System.out.println("--------------------------------------------------------------");
		}
	}

	public void displayListIO(List<StockIO> list) {
		System.out.println("--------------------------------------------------------------\r\n"
				+ "IO NUMBER	    PRODUCT ID	    IO DATE	    AMOUNT     STATUS\r\n"
				+ "--------------------------------------------------------------");
		if (list == null || list.isEmpty()) {
			printInvalid("Data");
		} else {
			for (StockIO stockIO : list) {
				System.out.println(stockIO);
			}
			System.out.println("--------------------------------------------------------------");
		}
	}
}