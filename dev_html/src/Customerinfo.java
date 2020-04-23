import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public class Customerinfo {

	public static void main(String[] args) {
		List<Map<String, Object>> mList = new ArrayList<Map<String,Object>>();	
		Map<String, Object> rMap =  new HashMap<String, Object>();
		
		rMap.put("mem_name", "김유신");
		rMap.put("mem_addr", "서울시 강남구");
		rMap.put("mem_tel", "02-111-1111");
		mList.add(rMap);
		
		rMap =  new HashMap<String, Object>();
		rMap.put("mem_name", "강감찬");
		rMap.put("mem_addr", "서울시 관악구");
		rMap.put("mem_tel", "02-222-2222");
		mList.add(rMap);
		
		rMap =  new HashMap<String, Object>();
		rMap.put("mem_name", "김소월");
		rMap.put("mem_addr", "서울시 구로구");
		rMap.put("mem_tel", "02-333-3333");
		mList.add(rMap);
		
		//아래줄 코드 기억하기
		Gson g = new GsonBuilder().setPrettyPrinting().create();
		String result = g.toJson(mList);
		System.out.println(result);

	}

}
