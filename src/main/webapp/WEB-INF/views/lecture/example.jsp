<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp"%>
<!DOCTYPE html>
<head>
<title>${lecture.name}~${lecture.description}</title>
<%@ include file="/WEB-INF/includes/src.jsp"%>
<script src="/resources/forweaver/js/fileBrowser.js"></script>
</head>
<body>
<script>

function showUploadContent() {
	
	$('#show-content-button').hide();
	$('#hide-content-button').show();
	$('#upload-form').fadeIn('slow');
	$('#fileBrowserTable').fadeIn('slow');
}

function hideUploadContent() {
	$('#show-content-button').show();
	$('#hide-content-button').hide();
	$('#upload-form').hide();
	$('#fileBrowserTable').show('slow');
}

$(document).ready(function() {
	hideUploadContent();
	$('#labelPath').append("/");
	$('#tags-input').textext()[0].tags().addTags(
			getTagList("/tags:<c:forEach items='${lecture.tags}' var='tag'>	${tag},</c:forEach>"));

	$("select").selectpicker({style: 'btn-primary', menuStyle: 'dropdown-inverse'});
	$("#selectBranch").change(function(){
		if($("#selectBranch option:selected").val() != "체크아웃한 브랜치 없음")
			window.location = $("#selectBranch option:selected").val();
	});
});

var commitlogHref= "";
var fileBrowser = Array();
<c:forEach items="${gitFileInfoList}" var="gitFileInfo">
fileBrowser.push({
	"name" : "${fn:substring(gitFileInfo.name,0,20)}",
	"path" : "${gitFileInfo.path}",
	"directory" : ${gitFileInfo.isDirectory},
	"depth" : ${gitFileInfo.depth},
	"commitLog" :  "${fn:substring(gitFileInfo.simpleCommitLog,0,40)}",
	"dateInt" :  ${gitFileInfo.commitDateInt},
	"commitID" :  "${fn:substring(gitFileInfo.commitID,0,8)}",
	"date": "${gitFileInfo.getCommitDate()}"
});
</c:forEach>
var fileBrowserTree = fileListTransform(fileBrowser);
var fileBrowserURL = "/lecture/${lecture.name}/example/commit:";
showFileBrowser("/");
</script>
	<div class="container">
		<%@ include file="/WEB-INF/common/nav.jsp"%>

		<div class="page-header">
			<h5>
				<big><big><i class="fa fa-book"></i> ${lecture.name}</big></big> 
			<small>${lecture.description}</small>
			</h5>
		</div>
		<div class="row">
			<div class="span8">
				<ul class="nav nav-tabs">
					<li class="active"><a href="/lecture/${lecture.name}/">예제소스</a></li>
					<li><a href="/lecture/${lecture.name}/community">커뮤니티</a></li>
					<li><a href="javascript:void(0);" onclick="window.open('/lecture/${lecture.name}/chat','','width=400,height=500,top='+((screen.height-500)/2)+',left='+((screen.width-400)/2)+',location =no,scrollbars=no, status=no;');">채팅</a></li>
					<li><a href="/lecture/${lecture.name}/repo">숙제 저장소</a></li>
					<li><a href="/lecture/${lecture.name}/weaver">수강생</a></li>
				</ul>
			</div>
			<div class="span4">
				<div class="input-block-level input-prepend">
					<span class="add-on"><i class="fa fa-link"></i></span> <input
						value="http://forweaver.com/${lecture.name}/example.git" type="text"
						class="input-block-level">
				</div>
			</div>

			<div class="span12 row">
				<div class="span7"><label id ="labelPath"></label></div>

				<div style="width: 90px;" class="span2">
					<a id="show-content-button" class="btn btn-primary"
						href="javascript:showUploadContent();"> <i
						style="zoom: 1.3; -moz-transform: scale(1.3);"
						class="icon-white icon-circle-arrow-up"> </i></a> <a
						id="hide-content-button" class="btn btn-primary"
						href="javascript:hideUploadContent();"> <i
						style="zoom: 1.3; -moz-transform: scale(1.3);"
						class="icon-white icon-circle-arrow-up"> </i></a> <a class="btn btn-primary" href="/lecture/${lecture.name}/repo/example-${selectBranch}.zip">
					<i style="zoom: 1.3; -moz-transform: scale(1.3);" class="icon-white icon-circle-arrow-down">
					</i></a>
				</div>
				
				<select id="selectBranch" class="span3">
					<option value="/lecture/${lecture.name}/example/commit:${selectBranch}">${selectBranch}</option>
					<c:forEach items="${gitBranchList}" var="gitBranchName">
						<option value="/lecture/${lecture.name}/example/commit:${gitBranchName}">${gitBranchName}</option>
					</c:forEach>

				</select>
				
				<form id="upload-form" enctype="multipart/form-data" action="/lecture/${lecture.name}/repo/example/upload"
					method="post">
					<div class="span12">
						<input class="title span10" type="text" name="message"
							placeholder="커밋 내역을 입력해주세요!"></input>
						<button type="submit" class="post-button btn btn-primary"
							style="margin-top: -10px; display: inline-block;">
							<i class="icon-ok icon-white"></i>

						</button>
					</div>
					<div id="file-div" style="padding-left: 20px;">
						<div class='fileinput fileinput-new' data-provides='fileinput'>
							<div class='input-group'>
								<div class='form-control' data-trigger='fileinput'>
									<i class='icon-file '></i> <span class='fileinput-filename'></span>
								</div>
								<span class='input-group-addon btn btn-primary btn-file'><span
									class='fileinput-new'> <i class='icon-upload icon-white'></i></span>
									<span class='fileinput-exists'><i
										class='icon-repeat icon-white'></i></span> <input type='file'
									id='file' multiple='true' name='zip'></span> <a href='#'
									class='input-group-addon btn btn-primary fileinput-exists'
									data-dismiss='fileinput'><i class='icon-remove icon-white'></i></a>
							</div>
						</div>
					</div>
				</form>
				<table id="fileBrowserTable" class="table table-hover">
				</table>
			</div>

			<!-- .span9 -->
		</div>
		<!-- .row-fluid -->
		<%@ include file="/WEB-INF/common/footer.jsp"%>
	</div>

</body>
</html>