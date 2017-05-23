<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE html>
<html lang="en">
<head>
	<base href="<%=basePath%>">
    <meta charset="UTF-8">
    <title>商品详情页面</title>
    <link rel="stylesheet" href="css/common.css">
    <link rel="stylesheet" href="css/jquery-ui.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/bootstrap.css">
    <link rel="stylesheet" href="css/footer.css">
    <link rel="stylesheet" href="css/style.css">
    <link rel="stylesheet" href="css/form-elements.css">
    <link rel="stylesheet" href="css/goodsDetail.css">
    <link rel="stylesheet" href="css/comments.css">
    <script src="js/jquery-3.1.1.js"></script>
    <script src="js/jquery-ui.js"></script>
    <script src="js/Menu.js"></script>
    <script src="js/clothes/advertisement.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/scripts.js"></script>
	<script>
		$(document).ready(function (){
			detail(${detail}); 
		}); 
		function detail(goods){
			let coId = document.getElementById("commentGoods");
			coId.value = goods.id;
			
			$.getJSON({
				url:"boardInfoController/getBoard.do?id="+goods.id,
				success:getComments
			});
			
			let container = document.getElementsByClassName("goodsDesc")[0];
			let div = document.createElement("div");
			div.classList.add("imgDesc");
			let img = document.createElement("img");
			img.classList.add("goodsLogo");
			img.src = goods.pic;
			div.appendChild(img);
			container.appendChild(div);
			let desc = document.getElementsByClassName("title")[0];
			desc.innerHTML = goods.des;
			let price = document.getElementsByClassName("spanPN")[0];
			price.innerHTML = goods.price;
			let size = document.getElementsByClassName("spanSize")[0];
			size.innerHTML = goods.size;
			let color = document.getElementsByClassName("spanColor")[0];
			color.innerHTML = goods.color;
			let imgContainer = document.getElementsByClassName("goodsImages")[0];
			let img1 = document.createElement("img");
			img1.src = goods.pic;
			img1.style.width="100%";
			img1.style.margin="10px 0 10px 0";
			imgContainer.appendChild(img1);
		};
		function test(){
			let te = document.getElementById("test");
			if(${detail}.id)
				te.value = ${detail}.id;
			else{
				alert("商品已不存在");
			}
		}
		function test2(){
			let test2 = document.getElementById("test2");
			if(${detail}.id)
				test2.value = ${detail}.id;
			else{
				alert("商品已不存在");
			}
		}
		
		function confirmLike(){
			var ret = window.confirm("确定?");
    		if(ret){
    			$.post({
    				url:"commodityInfo/collectCommodity.do",
    				data:{id:${detail}.id},
    				success:reloadPage
    			});
    		}else{
    			return false;
    		}
		}
		function confirmBuy(){
			var ret = window.confirm("确定?");
    		if(ret){
    			$.post({
    				url:"commodityInfo/buyCommodity.do",
    				data:{id:${detail}.id},
    				success:reloadPage
    			});
    		}else{
    			return false;
    		}
		}
		function reloadPage(){
			window.location.href="http://localhost:8080/forsale/Cart.jsp";
		}
		function refresh(){
			window.location.href="http://localhost:8080/forsale/GoodsDetail.jsp";
		}
		
		
		
		function getComments(json){
			alert(json);
		}
		
	</script>
</head>
<body>
<div class="container">
    <%@ include file="Header.jsp" %>
    <div class="goodsContent">
        <div class="goodsDesc">
            <div class="logoDesc">
                <p class="title"></p>
                <div class="priceDiv">
                    <p class="price">原价<span class="spanPrice">很贵很贵</span></p>
                    <p class="priceDesc"></p>
                    <p class="priceNow" >当前价格<span class="spanPN"></span></p>
                    <p class="color" >衣服尺寸&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span class="spanSize"></span></p>
                    <p class="color">商品颜色<span class="spanColor"></span></p>
                </div>
                <br><br><br><br><br><br>
                <div class="btnGroup">
					<button class="btn col-sm-3" id="likeBtn" onclick=confirmLike()>加入购物车</button>
                    <span class="col-sm-4"></span>
	                <button class="btn col-sm-3" id="buyBtn" onclick=confirmBuy()>立即购买</button>
                </div>
            </div>
        </div>
            <div class="publishComments">
        <form role="form" action="boardInfoController/board.do" method="post" class="bootstrap-frm">
            <h1>评论框
                <span>请留下您对商品的评论，给其他用户参考</span>
            </h1>
            <label>
                <span>Message :</span>
                <textarea id="message" name="message" placeholder="请在此输入您的评论..."></textarea>
                
                <input class="hidden" name="id" id="commentGoods">
            </label>
            <label>
                <span>&nbsp;</span>
                <button class="btn btn-primary" type="submit">提交</button>
            </label>
        </form>
    </div>
    <div class="checkComments">
        <table>
            <table class="table table-hover">
                <thead>
                    <tr>
                        <th class="col-sm-2">用户名</th>
                        <th class="col-sm-2">账号</th>
                        <th class="col-sm-6">评论内容</th>
                        <th class="col-sm-2">评论时间</th>
                    </tr>
                </thead>
                <tbody class="userBody">
                    <tr>
                        <td>刘昌鑫</td>
                        <td>刘昌鑫</td>
                        <td>朱子微你为什么这么丑</td>
                        <td>2017/05/23</td>
                    </tr>
                </tbody>
            </table>
        </table>
    </div>
    </div>
    <%@ include file="Footer.jsp" %>
</div>

</body>
</html>
