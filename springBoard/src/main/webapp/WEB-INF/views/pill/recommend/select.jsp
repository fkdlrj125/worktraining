<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ include file="/WEB-INF/views/common/common.jsp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="https://kit.fontawesome.com/b7d831082a.js" crossorigin="anonymous"></script>
<link rel="stylesheet" href="<c:url value="/resources/css/pill/bootstrap.min.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/pill/default.css"/>">
<link rel="stylesheet" href="<c:url value="/resources/css/pill/recommend/select.css"/>">
<title>Recommend</title>
</head>
<script type="text/javascript">
	$j(document).ready(function() {
		var selectCnt = 0;
		
		$j(".list-item").on("click", function() {
			if($j(this).find("img").css("background-color") == "rgb(254, 254, 254)") {
				$j(this).find("img").css("background-color", "#e0e0ff");
				selectCnt++;
				$j(".submit-btn").css("background-color", "#6c2ef1");
				$j(".submit-btn").css("pointer-events", "auto");
				$j("#selectCnt").text(`\${selectCnt}/8`);
				return;
			}
			$j(this).find("img").css("background-color", "#fefefe");
			selectCnt--;
			if(selectCnt == 0) {
				$j(".submit-btn").css("background-color", "#e0e0ff");
				$j(".submit-btn").css("pointer-events", "none");
			}
			
			$j("#selectCnt").text(`\${selectCnt}/8`);
		});
	});
	
	
</script>
<body>
	<div class="wrap">
		<%@include file="/WEB-INF/views/pill/fix/header.jsp" %>

		<div class="container">
      <div class="health-box">
        <div class="health-header">
          <div class="header-title">
            ��εǽðų� �����ϰ� ���� �ǰ� ����� �������ּ���
          </div>
          <div class="header-comment">
            �ִ� 8�� ����
          </div>
        </div>
        <div class="health-list">
          <div class="list-item">
            <img src="/resources/img/functionIcon/fatigue.png" alt="�Ƿΰ�" class="item-img">
            <div class="item-title">�Ƿΰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/eyes.png" alt="�� �ǰ�" class="item-img">
            <div class="item-title">�� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/skincare.png" alt="�Ǻ� �ǰ�" class="item-img">
            <div class="item-title">�Ǻ� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/fat.png" alt="ü����" class="item-img">
            <div class="item-title">ü����</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/blood_circulation.png" alt="���� & ���׼�ȯ" class="item-img">
            <div class="item-title">���� & ���׼�ȯ</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/liver.png" alt="�� �ǰ�" class="item-img">
            <div class="item-title">�� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/intestine.png" alt="�� �ǰ�" class="item-img">
            <div class="item-title">�� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/sleep.png" alt="��Ʈ���� & ����" class="item-img">
            <div class="item-title">��Ʈ���� & ����</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/immunity.png" alt="�鿪 ���" class="item-img">
            <div class="item-title">�鿪 ���</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/cholesterol.png" alt="���� �ݷ����׷�" class="item-img">
            <div class="item-title">���� �ݷ����׷�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/bones2.png" alt="�� �ǰ�" class="item-img">
            <div class="item-title">�� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/anti-aging.png" alt="��ȭ & �׻�ȭ" class="item-img">
            <div class="item-title">��ȭ & �׻�ȭ</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/women.png" alt="���� �ǰ�" class="item-img">
            <div class="item-title">���� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/stomach.png" alt="��ȭ & ���ĵ� �ǰ�" class="item-img">
            <div class="item-title">��ȭ & ���ĵ� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/men.png" alt="���� �ǰ�" class="item-img">
            <div class="item-title">���� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/blood_pressure.png" alt="����" class="item-img">
            <div class="item-title">����</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/strength.png" alt="� �ɷ� & ������" class="item-img">
            <div class="item-title">� �ɷ� & ������</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/brain.png" alt="�γ�Ȱ��" class="item-img">
            <div class="item-title">�γ�Ȱ��</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/blood_sugar.png" alt="����" class="item-img">
            <div class="item-title">����</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/cholesterol.png" alt="���� �߼�����" class="item-img">
            <div class="item-title">���� �߼�����</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/tooth.png" alt="ġ�� & �ո�" class="item-img">
            <div class="item-title">ġ�� & �ո�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/pregnant.png" alt="�ӻ�� & �¾� �ǰ�" class="item-img">
            <div class="item-title">�ӻ�� & �¾� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/hair_loss.png" alt="Ż�� & ���� �ǰ�" class="item-img">
            <div class="item-title">Ż�� & ���� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/joint.png" alt="���� �ǰ�" class="item-img">
            <div class="item-title">���� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/menopause.png" alt="���� �����" class="item-img">
            <div class="item-title">���� �����</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/breath.png" alt="ȣ��� �ǰ�" class="item-img">
            <div class="item-title">ȣ��� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/thyroid.png" alt="���� �ǰ�" class="item-img">
            <div class="item-title">���� �ǰ�</div>
          </div>
          <div class="list-item">
            <img src="/resources/img/functionIcon/anemia.png" alt="����" class="item-img">
            <div class="item-title">����</div>
          </div>
        </div>
        <div class="submit-btn-box">
          <button class="submit-btn" onclick="location.href='/pill/recommend/result'">Ȯ��<div id="selectCnt">0/8</div></button>
        </div>
      </div>
    </div>
  </div>
</body>
</html>

