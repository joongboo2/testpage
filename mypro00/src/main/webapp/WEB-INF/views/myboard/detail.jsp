<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>   

<c:set var="contextPath" value="${pageContext.request.contextPath }"/>
<%@include file="../myinclude/myheader.jsp" %>
<style>
/*th {text-align: center;}*/
</style>

<div id="page-wrapper"> 
    <div class="row">
        <div class="col-lg-12">
         <h3 class="page-header"
            style="white-space: nowrap;" >Board - Detail
            <small>
            	&nbsp;&nbsp;&nbsp;<c:out value="${myboard.bno}"/>번 게시물
            </small>
         </h3>        
        </div>
        <!-- /.col-lg-12 -->
    </div>
    <!-- /.row -->
    <div class="row">
        <div class="col-lg-12">
        
            <div class="panel panel-default"> 
            	<div class="panel-heading">
                   <div class="row">
	                  <div class="col-md-2" style="white-space: nowrap; height: 45px; padding-top:11px;">
	                     <strong style="font-size:16px;">${myboard.bwriter}님 작성</strong>
	                  </div>
	                  <div class="col-md-3" style="white-space: nowrap; height: 45px; padding-top:16px;">
	                     <span class="text-primary" style="font-size: smaller; height: 45px; padding-top: 19px;">
	                        <span>
	                           <span>등록일:&nbsp;</span>
	                           <strong><fmt:formatDate 
	                                    pattern="yyyy-MM-dd HH:mm:ss"
	                                    value="${myboard.bregDate}"
	                                  /></strong>
	                           <span>&nbsp;&nbsp;</span>
	                        </span>
	                        <span>조회수:&nbsp;<strong><c:out value="${myboard.bviewsCnt}"/></strong>
	                        </span>
	                     </span>
	                  </div>
	                  <div class="col-md-7" style="height: 45px; padding-top:6px;"><%-- vertical-align: middle; --%>
	                     <div class="button-group pull-right">
	                     
	
	
	
	                     <button type="button" id="btnToModify" data-oper="modify"
	                           class="btn btn-primary"><span>수정페이지로 이동</span></button>
	
	
	                           
	                     <button type="button" id="btnToList" data-oper="list"
	                           class="btn btn-warning"><span>목록페이지로 이동</span></button>
	                     </div>
	                  </div>
	               </div>
	                </div>         		
                <!-- /.panel-heading -->
                             
                <div class="panel-body">

	<div class="form-group">
	    <label>글제목</label>
	    <input class="form-control" name="btitle" id="btitle"
	           value="${myboard.btitle }" readonly="readonly" />
	</div>
	<div class="form-group">
        <label>글내용</label>
	    <textarea class="form-control" rows="3" name="bcontent" id="bcontent" 
	              readonly="readonly">${myboard.bcontent}</textarea>
    </div>

	    <div class="form-group">
	    <label>최종수정일</label>
	   	<input class="form-control" name="bmodDate" id="bmodDate" 
	           value='<fmt:formatDate pattern="yyyy/MM/dd HH:mm:ss" value="${myboard.bmodDate }"/>' readonly="readonly" />
	</div> 


	<form id="frmSendValue"><!-- 
		<input type="hidden" value="값" name="파라미터이름"> -->
		<input type="hidden" name="pageNum" value="${myboardPaging.pageNum}">
		<input type="hidden" name="rowAmountPerPage" value="${myboardPaging.rowAmountPerPage}">
	    <input type="hidden" name="scope" value="${myboardPaging.scope}">
	   	<input type="hidden" name="keyword" value="${myboardPaging.keyword}">
	    
	</form>

                </div><!-- /.panel-body -->
            </div><!-- /.panel -->
        </div><!-- /.col-lg-12 -->
    </div><!-- /.row -->


<div class="row">
   <div class="col-lg-12">
      <div class="panel panel-default" >
         <div class="panel-heading">
            <p style="margin-bottom: 0px; font-size: 16px;">
               <strong style="padding-top: 2px;"><%-- 
                  <span>댓글&nbsp;<c:out value="${board.breplyCnt}"/>개</span> --%>
                  <span id="replyTotal"></span>
                  <span>&nbsp;</span>
                  
                  <button type="button" id="btnChgCmtReg" class="btn btn-info btn-sm">댓글 작성</button>
                  
                  <button type="button" id="btnRegCmt" class="btn btn-warning btn-sm"
                        style="display:none">댓글 등록</button>
                  <button type="button" id="btnCancelRegCmt" class="btn btn-warning btn-sm"
                        style="display:none">취소</button>&nbsp;&nbsp;&nbsp;

               </strong>
            </p>
         </div> <%-- /.panel-heading --%>
         <div class="panel-body">

         <%-- 댓글 입력창 div 시작 --%>
            <div class="form-group" style="margin-bottom: 5px;">
               <textarea class="form-control txtBoxCmt" name="rcontent"
                       placeholder="댓글작성을 원하시면,&#10;댓글 작성 버튼을 클릭해주세요."
                       readonly="readonly"
                      ></textarea>
            </div>
            <hr style="margin-top: 10px; margin-bottom: 10px;"><%-- 댓글 입력창 div 끝 --%>

            

<ul class="chat" id="chat">
<%-- 댓글 목록 표시 영역 - JavaScript로 내용이 생성되어 표시됩니다.--%><%-- 
   <li class="left clearfix commentLi" data-bno="123456" data-rno="12">
      <div>
         <div>
            <span class="header info-rwriter">
               <strong class="primary-font">user00</strong>
               <span>&nbsp;</span>
               <small class="text-muted">2018-01-01 13:13</small>
            </span>
            <p>앞으로 사용할 댓글 표시 기본 템플릿입니다.</p>
         </div>
         
         <div class="btnsComment" style="margin-bottom:10px">
            <button type="button" style="display:in-block"
                  class="btn btn-primary btn-xs btnChgReg">답글 작성</button>
            <button type="button" style="display:none"
                  class="btn btn-warning btn-xs btnRegCmt">답글 등록</button>
            <hr class="txtBoxCmtHr" style="margin-top:10px; margin-bottom:10px">
            <textarea class="form-control txtBoxCmtMod" name="rcontent" 
                    style="margin-bottom:10px"
                    placeholder="답글작성을 원하시면,&#10;답글 작성 버튼을 클릭해주세요."
                   ></textarea>
         </div>
      </div>
   </li> --%>
</ul><%-- /.chat --%>


         </div><%-- /.panel-body --%>
         <div class="panel-footer text-center" id="showCmtPagingNums">
            <%-- 댓글 목록의 페이징 번호 표시 영역 - JavaScript로 내용이 생성되어 표시됩니다.--%>
         </div>
      </div><%-- /.panel --%>
   </div><%-- .col-lg-12 --%>
</div><%-- .row : 댓글 화면 표시 끝 --%>

<form id="frmCmtPagingValue"> 
	<input type="hidden" name="pageNum" value="" >
	<input type="hidden" name="rowAmountPerpage" value="" >
</form>

</div><!-- /#page-wrapper -->
        
<%-- Modal 모달 시작 --%>
<div class="modal fade" id="yourModal" tabindex="-1" role="dialog" aria-labelledby="yourModalLabel" aria-hidden="true">
 <div class="modal-dialog">
 <div class="modal-content">
 <div class="modal-header">
 <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
 <h4 class="modal-title" id="yourModalLabel">처리결과</h4>
 </div>
 <div class="modal-body" id="yourModal-body">메시지</div>
 	
 <div class="modal-footer">
 <button type="button" class="btn btn-primary" data-dismiss="modal">확인</button>
 </div>
</div><%-- END .modal-content --%>
</div><%-- END .modal-dialog --%>
</div><%-- END .modal --%>  
        
<script>

var frmSendValue = $("#frmSendValue") ;

//게시물 목록 페이지 이동
$("#btnToList").on("click", function(){
//	window.location.href="${contextPath}/myboard/list" ;

	frmSendValue.attr("action", "${contextPath}/myboard/list").attr("method", "get") ;
	frmSendValue.submit() ;
});

//게시물 수정-삭제 페이지 이동
$("#btnToModify").on("click", function(){
//	window.location.href='${contextPath}/myboard/modify?bno=<c:out value="${myboard.bno}"/>' ;
	
	var bno = '<c:out value="${myboard.bno}"/>' ;
	
	frmSendValue.append("<input type='hidden' name='bno' value='" + bno + "'/>") ;
	frmSendValue.attr("action", "${contextPath}/myboard/modify").attr("method", "get") ;
	frmSendValue.submit() ;
});




var result = '<c:out value="${result}" />' ;
//alert("result" + result);

function runModal(result) {
	
	if (result.length == 0) {
		return ;
	
	} else if ( result == "successModify" ) {
		var myMsg =  "게시글이 수정되었습니다. " ;
		
	}  

	$("#yourModal-body").html(myMsg) ;
	
	$("#yourModal").modal("show") ;
	
	myMsg = "" ;
}
</script>
<script src="${contextPath }/resources/js/mycomment.js"></script>
<script>

var bnoValue = '<c:out value="${myboard.bno}"/>' ;

var commentUL = $("chat") ;

var frmCmtPagingValue = $("#frmCmtPagingValue");

//댓글목록 표시 함수: 서버로부터 전달된 데이터를 이용해서 댓글 목록을 표시하는 JS 함수
function showCmtList(pageNum){
	
	myReplyClsr.getCmtList(
		{bno: bnoValue, pageNum: pageNum || 1} , 
		
		function(myReplyPagingCreator){
			var str = '' ;
			
			if(!myReplyPagingCreator.myreplyList || myReplyPagingCreator.myreplyList.length == 0){
				str += '<li class="left clearfix commentLi" '
		            + '    style="text-align: center; background-color: lightCyan;'
		            + '    height: 35px;margin-bottom: 0px;padding-bottom:0px;'
		            + '    padding-top:6px;border: 1px dotted;">'
		            + '    <strong>등록된 댓글이 없습니다.</strong></li>';
		        
				commentUL.html(str);
				return;
				
			}
			
			for(var i = 0, len = myReplyPagingCreator.myreplyList.length; i < len ; i++){
				if(myReplyPagingCreator.myreplyList[i].rdelFlag == 1){
				str +='<li class="left clearfix commentLi" '
	                + '    data-bno="' + bnoValue + '"'
	                + '    data-rno="' + myReplyPagingCreator.myreplyList[i].rno + '"' 
	                + '    data-rwriter="' + myReplyPagingCreator.myreplyList[i].rwriter + '"'
	                + '    data-rdelflag="' + myReplyPagingCreator.myreplyList[i].rdelFlag + '" >'      
	                + ' <div style="background-color: Moccasin; text-align: center">'
	                + '     <em>작성자에 의해서 삭제글입니다.</em>'
	                + ' </div>'
	                + '</li>';
				
				} else {
				str += '<li class="left clearfix commentLi" '
				    += '     data-bno="' + bnoValue + '" '
				    += '     data-rno="' + myReplyPagingCreator.myreplyList[i].rno + '" '
				    += '     data-rwriter="' + myReplyPagingCreator.myreplyList[i].rwriter + '" '     
				    += '     data-rdelflag="' + myReplyPagingCreator.myreplyList[i].rdelFlag + '"></li>'       
					
					
				}
				
			}
			
			
		}//callback-function-end
			
	);
	
}//showCmtList-end


</script>

<script>
$(document).ready(function(){
	runModal(result) ;
	
	//댓글-답글 표시 시작
	showCmtList(1);
});
</script>

<%@include file="../myinclude/myfooter.jsp" %>









<%-- mycomment.js 클로저 메서드 테스트 코드 --%>
<%--

console.log(myReplyClsr.myDateTimeFmt(1630701192000));
 
//229375

myReplyClsr.removeAllReply(
		229375,
		function (result){
			console.log(result);
		}
);



var bnoValue = '<c:out value="${myboard.bno}"/>' ;

myReplyClsr.removeCmtReply(
	{bno: bnoValue, rno: 102},
	function(result){
		console.log(result);
	}
);


myReplyClsr.modifyCmtReply(
	{bno: bnoValue, rno: 1, rcontent:"JS클로저댓글답글수정---"}, 
	function(result){
		console.log(result);
	}	
);


myReplyClsr.getCmtReply(
	{bno: bnoValue, rno: 1},
	function (reply){
		console.log(reply); 
	}
		
);


myReplyClsr.registerReply(
		{bno: bnoValue, rcontent: "JS댓글등록1", rwriter: "user7", prno: 1}	,
		function(result) {
			console.log("서버등록 결과: " + result) ; 
		}
	);


myReplyClsr.registerCmt(
	{bno: 229375, rcontent: "JS댓글등록1", rwriter: "user7"}	,
	function(result) {
		console.log("서버등록 결과: " + result) ; 
	}
);

//댓글 목록 호출
myReplyClsr.getCmtList(
		{bno: bnoValue} ,
		function(myReplyPagingCreator){
			console.log(myReplyPagingCreator.replyTotCnt);
			for(var reply of myReplyPagingCreator.myreplyList){
				console.log(reply);
				console.log(reply.rregDate);
			}
		}
			
);

 --%>
