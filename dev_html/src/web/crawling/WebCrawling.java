package web.crawling;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;

public class WebCrawling {
	//웹 페이지를 그대로 가져와서 거기서 데이터를 추출해 내는 행위 => 크롤링
	void methodA() {
		try {
			//크롤링할 URL입력받아야 한다.
	        URL url = new URL("http://localhost:8000/day4/deptList2.jsp");
	        InputStreamReader isr = new InputStreamReader(url.openStream());
	        BufferedReader br = new BufferedReader(isr);
	        String tags = null;
	        StringBuilder sb = new StringBuilder();
	        while((tags = br.readLine())!=null) {
	           sb.append(tags);
	        }
	        br.close();
			//크롤링 시작 - 키(데이터)값을 추출해 보자
	        List<String> titleList = new ArrayList<>();
	        String strs[] = sb.toString().split("<th>");
	        for(int i=0;i<strs.length;i++) {
	        	System.out.println("strs["+i+"]==>"+strs[i]);
	        }
	        String strs2[]	= null;
	        for(int i=1;i<strs.length;i++) {
	        	strs2 = strs[i].split("</th>");
	        	titleList.add(strs2[0]);
	        }
	        for(String title:titleList) {
	        	System.out.println(title);
	        }
		} catch (Exception e) {
			// TODO: handle exception
		}
	}
	public static void main(String[] args) {
		WebCrawling wc = new WebCrawling();
		wc.methodA();
	}

}
