package sec01.ex02;

public class MemberTest {

	public static void main(String[] args) {
		Address addr = new Address();
		addr.setCity("대구시");
		addr.setZipcode("777555");
		
		MemberBean bean = new MemberBean();
		bean.setId("lee");
		bean.setName("이순신");
		bean.setPwd("000");
		bean.setEmail("leeGeneral@joseon.com");
		bean.setAddress(addr);
		
		System.out.println("MemberBean : " + bean);
		System.out.println("도시이름 : " + bean.getAddress().getCity());
		System.out.println("우편번호 : " + bean.getAddress().getZipcode());
	}

}
