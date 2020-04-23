<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%! 
//여기에 선언한 변수는 전역변수이고, 스크립틀릿에 선언한 변수는 지역변수이다.
	int x = 1;//전역변수이다.
	public String newsList(String news[]){
		//자바성능튜닝 지적사항 
		StringBuilder sb = new StringBuilder();
		sb.append("<table width='500px' border='1'>");
		sb.append("<tr><td>"+news[0]+" > "+news[1]+"</td></tr>");
		sb.append("</table>");
		return sb.toString();
	}
%>
<%//이 기호는 스크립틀릿이라고 한다. - 메소드 선언불가
//여기는 디클러레이션 - 전역변수이다.
//싱글톤으로 관리한다.(서블릿으로 관리한다.- newData_jsp.jaba가 HttpServlet을 상속받았다.-이 객체는 계속 유지됨-새로고침을 당해도.)
	String news1[] = {"박가영","벤틀리 걷어찬 20대 남성 내가 왜 그랬는지 몰라"};
	String news2[] = {"오문영","추미애 정책보좌관 청탁 의혹…檢 수사 검토중"};
	String news3[] = {"최인영","코로나19 어제 13명 증가·총 1만674명…서울 신규확진 0명"};
	String news4[] = {"오수희","교회·식당·투표…첫 증상 발현 후 9일간 일상생활"};
	String news5[] = {"안영","등록금 횡령 광운대 전 이사장 징역 1년, 법정구속"};
	
	//화면에 내보내질 코드 담기
	String datas = "";
	switch(x){
	case 1:
		datas= newsList(news1);
		x++;
		break;
	
	case 2:
		datas= newsList(news2);
		x++;
		break;
	
	case 3:
		datas= newsList(news3);
		x++;
		break;
	
	case 4:
		datas= newsList(news4);
		x++;
		break;
	
	case 5:
		datas= newsList(news5);
		x=1;
		break;
	}
	out.clear();
	out.print(datas);
%>