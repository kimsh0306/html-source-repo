package com.util;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class DBConnectionMgr {
	//선언부-전역변수는 초기화를 생성자가 해준다.
	//Connection ->특정 데이터베이스와의 연결(세션). SQL 문은 실행되고 결과는 연결의 맥락 안에서 반환된다.
	Connection			con			=	null;
	public static final String _DRIVER  
		= "oracle.jdbc.driver.OracleDriver";
	//물리적으로 떨어져 있는 오라클 서버에 URL정보 추가
	public static final String _URL 
		= "jdbc:oracle:thin:@192.168.0.26:1521:orcl11";//여기까지-------------전역변수이면서 상수
	public static String _USER = "scott";//bank
	public static String _PW = "tiger";
	//static은 클래스급이다.공유를 생각하라(하나다)=>하나를 접근하는 것이다.정적변수다.
	private static DBConnectionMgr dbMgr = null;
	private DBConnectionMgr() {}
	//싱글톤 패턴으로 객체 관리하기 ------------------------------- 인스턴스화 과정이다.
	public static DBConnectionMgr getInstance() {//타입이 하나다, 싱글톤. 하나의 객체를 2천만명이 공유할 수 있다.
		if(dbMgr==null) {
			dbMgr = new DBConnectionMgr();
		}
		return dbMgr;
	}//---------------------------------------------------- 인스턴스화 과정 여기가지.
	//물리적으로 떨어져 있는 오라클 서버와 연결통로 만들기
	public Connection getConnection() {//static이 없다.
		System.out.println("getConnection 호출 성공");
		//오라클 회사 정보를 수집함.
		try {
			Class.forName(_DRIVER);
			//인스턴스화를 해주는 메소드 구현.con을 리턴하니까.그 어디에도 인스턴화가 없다.con = new Connection();이 없다.
			//반드시 구현체 클래스가 있어야 한다.
			con=DriverManager.getConnection(_URL,_USER,_PW);//변경가능
		}catch(ClassNotFoundException ce) {
			System.out.println("드라이버 클래스 이름을 찾을 수 없어요.");
		}catch(Exception e) {
			System.out.println("예외가 발생했음. 정상적으로 처리가 안됨.");
		}
		return con;
	}
	/* DBConnectionMgr은 여러 업무에서 공통으로 사용하는 클래스입니다.
	 * 사용한 자원(Connection, PreparedStatment, ResultSet)은 
	 * 반드시 반납을 하도록 합니다.
	 * 동시 접속자 수가 많은 시스템에서 자원사용은 곧 메모리랑 직결되므로
	 * 서버가 다운되거나 시스템 장애 발생에 원인이 됩니다.
	 */
	public void freeConnection(Connection con 
								,PreparedStatement pstmt 
								,ResultSet rs) {
		try {
		//사용자원의 생성 역순으로 반환할 것.	
			if(rs!=null) {
				rs.close();
			}
			if(pstmt!=null) {
				pstmt.close();
			}
			if(con!=null) {
				con.close();
			}
		}catch(Exception e) {
			System.out.println("Exception: "+e.toString());
		}
	}
	//1)메소드 오버로딩 - 파라미터갯수
	//2)메소드 오버라이딩
	public void freeConnection(Connection con 
			,PreparedStatement pstmt) {
		try {
			//사용자원의 생성 역순으로 반환할 것.	
			if(pstmt!=null) {
				pstmt.close();
			}
			if(con!=null) {
				con.close();
			}
		}catch(Exception e) {
			System.out.println("Exception: "+e.toString());
		}
	}
	public void freeConnection(Connection con 
			,CallableStatement cstmt) {
		try {
			//사용자원의 생성 역순으로 반환할 것.	
			if(cstmt!=null) {
				cstmt.close();
			}
			if(con!=null) {
				con.close();
			}
		}catch(Exception e) {
			System.out.println("Exception: "+e.toString());
		}
	}
}
