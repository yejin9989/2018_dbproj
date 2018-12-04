package phase3;
import java.sql.Date;

public class MemberBean {
	private Date date;
	private int orderNum;
	private String pitem;
	private int pquantity;
	
	public Date getDate() {return date;}
	public void setDate(Date date) {this.date = date;}
	
	public int getOrdernum() {return orderNum;}
	public void setOrdernum(int orderNum) {this.orderNum = orderNum;}
	
	public String getPitem() {return pitem;}
	public void setPitem(String pitem) {this.pitem = pitem;}
	
	public int getPquantity() {return pquantity;}
	public void setPquantity(int pquantity) {this.pquantity = pquantity;}
}
