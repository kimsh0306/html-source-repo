package project.restaurant;
//1
import java.awt.BorderLayout;
import java.awt.FlowLayout;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JPanel;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

//ActionListener => 이벤트 처리를 위한 선작업
public class RestaurantView extends JFrame implements ActionListener{
	//선언부
	JPanel jp_north = new JPanel();
	JButton jbtn_ins = new JButton("입력");
	JButton jbtn_upd = new JButton("수정");
	JButton jbtn_del = new JButton("삭제");
	JButton jbtn_sel = new JButton("조회");
	JPanel jp_center = new JPanel();
	String cols[] = {"식당이름","주소","전화번호"};
	//로우 수는 결정되지 않았고 컬럼은 3으로 결정된 상태이다.
	String datas[][] = new String[0][3];
	DefaultTableModel dtm_res = new DefaultTableModel(datas,cols);
	JTable jtb_res = new JTable(dtm_res);
	//스크롤바를 제공하는 속지 => JPanel과 동급, 속지의 기능을 갖고 있다.
	JScrollPane jsp_res = new JScrollPane(jtb_res);
	
	//생성자
	public RestaurantView() {
		initDisplay();
	}
	//화면처리부
	public void initDisplay() {
		/*************************************************
		이벤트를 감지하는 게 ActionLisener
		*************************************************/
		jbtn_ins.addActionListener(this);
		jbtn_upd.addActionListener(this);
		jbtn_del.addActionListener(this);
		jbtn_sel.addActionListener(this);
		
		/********************문법 패턴에 대한 정리***************
		jp_north.setLayout(new FlowLayout(FlowLayout.LEFT));
		
		패널의 주소번지.setLayout(new FlowLayout(){
			이 영역에서 속성을 정의하는 일(재정의),메소드 선언
		});
		
		setLayout => 배치에 대한 설정
		setLayout 다음에 오는() 안에서 클래스를 정의할 수 있다.
		메소드 안에서 클래스 호출만 할 수 있는 것이 아니라 재정의할 수 있다.
		**************************************************/
		jp_north.setLayout(new FlowLayout(FlowLayout.LEFT));
		jp_north.add(jbtn_ins);
		jp_north.add(jbtn_upd);
		jp_north.add(jbtn_del);
		jp_north.add(jbtn_sel);
		jp_center.setLayout(new BorderLayout());
		jp_center.add("Center",jsp_res);
		this.add("North",jp_north);
		this.add("Center",jp_center);
		this.setTitle("골목식당 정보 Ver1.0");
		this.setSize(800, 550);
		this.setVisible(true);
	}
	//메인메소드
	public static void main(String[] args) {
		//생성자 호출
		new RestaurantView();
	}
	//이벤트 처리를 담당하는 메소드를 내 안에 처리했으니까
	@Override
	public void actionPerformed(ActionEvent e) {
		/*************************************************
		이벤트가 처리될 때 어떤 정보가 (ActionEvent e) e로 넘어왔다.
		이벤트에 대한 주소번지를 알기 위해서 e.getSource()한다.
		obj는 오브젝트 타입의 변수를 선언했다.
		그 변수에 e.getSource()로 초기화시켰다. =-> 주소번지를 obj에 넣었다.
		*************************************************/
		Object obj = e.getSource();
		if(obj.equals(jbtn_ins)) {
			System.out.println("입력 버튼 호출 성공");
			//이벤트를 감지하는 게 ActionLisener
			//입력을 눌렀을 때 RestINSView이 열린다*****
			RestINSView riv = new RestINSView();
		}
	}
}
