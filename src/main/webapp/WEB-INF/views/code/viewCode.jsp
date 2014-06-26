<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ include file="/WEB-INF/includes/taglibs.jsp"%>
<!DOCTYPE html>
<head>
<title>Forweaver : 소통해보세요!</title>
<%@ include file="/WEB-INF/includes/src.jsp"%>
<%@ include file="/WEB-INF/includes/syntaxhighlighterSrc.jsp"%>
</head>
<body>
	<script type="text/javascript">
	var fileCount = 1;
	var comment = 0;
	var fileArray = [];
	
	function hideAndShowSourceCode(number){
		$(function (){
			if($("#td-code-"+number).is(":visible")){
				$("#td-code-"+number).fadeOut();
			}else{
				$("#td-code-"+number).fadeIn();
			}
		});
	}
	
	function fileUploadChange(fileUploader){
		$(function (){
		if($(fileUploader).val()!=""){ // 파일을 업로드하거나 수정함
			if(fileUploader.id == "file"+fileCount){ // 업로더의 마지막 부분을 수정함
		fileCount++;
		$(".file-div").append("<div class='fileinput fileinput-new' data-provides='fileinput'>"+
				  "<div class='input-group'>"+
				    "<div class='form-control' data-trigger='fileinput'><i class='icon-file '></i> <span class='fileinput-filename'></span></div>"+
				    "<span class='input-group-addon btn btn-primary btn-file'><span class='fileinput-new'>"+
				    "<i class='icon-upload icon-white'></i></span><span class='fileinput-exists'><i class='icon-repeat icon-white'></i></span>"+
					"<input onchange ='fileUploadChange(this);' type='file' multiple='true' id='file"+fileCount+"' name='files["+(fileCount-1)+"]'></span>"+
				   "<a id='remove-file' href='#' class='input-group-addon btn btn-primary fileinput-exists' data-dismiss='fileinput'><i class='icon-remove icon-white'></i></a>"+
				  "</div>"+
				"</div>");
			}
		}else{
			if(fileUploader.id == "file"+(fileCount-1)){ // 업로더의 마지막 부분을 수정함
				
			$("#file"+fileCount).parent().parent().remove();

				--fileCount;
		}}});
	}
		function showCommentAdd(rePostID){
			$("#repost-form").hide();
			$(".comment-form").remove();
			if(comment != rePostID){
			$("#comment-form-td-"+rePostID).append("<form class='comment-form' action='/code/${code.codeID}/"+rePostID+"/add-reply' method='POST'>"+
			"<div style='padding-left:20px;' class='span10'>"+
			"<input id='reply-input'  type ='text' name='content' class='reply-input span10'  placeholder='답변할 내용을 입력해주세요!'></input></div>"+
			"<div class='span1'><span><button type='submit' class='post-button btn btn-primary'>"+
			"<i class='icon-ok icon-white'></i></button></span></div></form>");
			comment = rePostID;
			$("#reply-input").focus();
			
			}else{
				$("#repost-form").show();
				comment = 0;
			}
		}
	
		
		$(function() {
			
			$( "#"+getSort(document.location.href) ).addClass( "active" );
			
			$("#repost-content").focus(function(){				
					$(".file-div").fadeIn();
					$("#repost-table").hide();
					$("#myTab").hide();
			});
			
			$("#repost-content").focusout(function(){	

				if( !this.value ) {
					$(".file-div").hide();
					$("#repost-table").fadeIn();
					$("#myTab").fadeIn();
		      }
		});
			
			$(".file-div").append("<div class='fileinput fileinput-new' data-provides='fileinput'>"+
					  "<div class='input-group'>"+
					    "<div class='form-control' data-trigger='fileinput'><i class='icon-file '></i> <span class='fileinput-filename'></span></div>"+
					    "<span class='input-group-addon btn btn-primary btn-file'><span class='fileinput-new'>"+
					    "<i class='icon-upload icon-white'></i></span><span class='fileinput-exists'><i class='icon-repeat icon-white'></i></span>"+
						"<input onchange ='fileUploadChange(this);' type='file' id='file1' multiple='true' name='files[0]'></span>"+
					   "<a href='#' class='input-group-addon btn btn-primary fileinput-exists' data-dismiss='fileinput'><i class='icon-remove icon-white'></i></a>"+
					  "</div>"+
					"</div>");
			
			$(".file-div").hide();
			
			$('#tags-input').textext()[0].tags().addTags(
					getTagList("/tags:<c:forEach items='${code.tags}' var='tag'>	${tag},</c:forEach>"));

			$('.tag-name').click(
					function() {
						var tagname = $(this).text();
						movePage("[\"" + tagname + "\"]","");	
			});
			
			<c:forEach	items="${code.codes}" var="simpleCode" varStatus="status">	
			$("#code-${status.count}").addClass("brush: "+extensionSeach('${simpleCode.fileName}')+";");
			</c:forEach>
		});
		
		SyntaxHighlighter.all();
	</script>
	<div class="container">
		<%@ include file="/WEB-INF/common/nav.jsp"%>
		<div class="row">
			<div class=" span12">
				<table id="post-table" class="table table-hover">
					<tbody>
						<tr>
							<td class="td-post-writer-img none-top-border" rowspan="2">
								<img src="${code.getImgSrc()}">
							</td>
							<td colspan="2" class="post-top-title none-top-border"><a
								rel="external" class="a-post-title"
								href="/code/tags:<c:forEach items='${code.tags}' var='tag'>${tag},</c:forEach>">
									<i class="fa fa-download"></i>&nbsp;${code.name} -
									${code.content}
							</a></td>
							<td class="td-button none-top-border" rowspan="2"><a
								href="/code/${code.codeID}/${code.name}.zip"> <span
									class="span-button"> ${code.downCount}
										<p class="p-button">다운</p>
								</span></a></td>
							<td class="td-button none-top-border" rowspan="2"><span
								class="span-button">${rePosts.size()}
									<p class="p-button">답변</p>
							</span></td>
						</tr>
						<tr>
							<td class="post-bottom"><b>${code.writerName}</b>
								${code.getFormatCreated()}</td>
							<td class="post-bottom-tag"><c:forEach items="${code.tags}"
									var="tag">
									<span
										class="tag-name
										<c:if test="${tag.startsWith('@')}">
										tag-private
										</c:if>
										<c:if test="${tag.startsWith('$')}">
										tag-massage
										</c:if>
										">${tag}</span>
								</c:forEach>
								<div class="function-div pull-right">
									<a onclick="return confirm('정말로 삭제하시겠습니까?');"
										href="/code/${code.codeID})"> <span
										class="function-button">삭제</span></a>
								</div></td>

						</tr>
						<c:forEach items="${code.codes}" var="simpleCode"
							varStatus="status">
							<tr>
								<td colspan="5"><span
									onclick="javascript:hideAndShowSourceCode(${status.count})"
									class="function-button function-file"> <i
										class='icon-file icon-white'></i> ${simpleCode.fileName}
								</span></td>
							</tr>

							<tr>
								<td
									<c:if test="${status.count > 5}" >style='display:none;'</c:if>
									id="td-code-${status.count}" style="max-width: 500px;"
									colspan="5"><pre id="code-${status.count}">${simpleCode.getContent()}</pre></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>


				<!-- 답변에 관련된 테이블 시작-->

				<form enctype="multipart/form-data" id="repost-form"
					action="/code/${code.codeID}/add-repost" method="POST">

					<div style="margin-left: 0px" class="span11">
						<textarea name="content" id="repost-content"
							class="post-content span10" onkeyup="textAreaResize(this)"
							placeholder="답변할 내용을 입력해주세요!"></textarea>
					</div>
					<div class="span1">
						<span>
							<button type="submit" class="post-button btn btn-primary">
								<i class="icon-ok icon-white"></i>
							</button>
						</span>
					</div>
					<div class="file-div"></div>
				</form>

				<c:if test="${code.rePostCount != 0}">

					<div class="span12"></div>
					<ul class="nav nav-tabs" id="myTab">
						<li id="age-desc"><a
							href="/code/${code.codeID}/sort:age-desc">최신순</a></li>
						<li id="push-desc"><a
							href="/code/${code.codeID}/sort:push-desc">추천순</a></li>
						<li id="reply-desc"><a
							href="/code/${code.codeID}/sort:reply-desc">최신 답변순</a></li>
						<li id="reply-many"><a
							href="/code/${code.codeID}/sort:reply-many">많은 답변순</a></li>
						<li id="age-asc"><a href="/code/${code.codeID}/sort:age-asc">오래된순</a></li>
					</ul>

				</c:if>
				<table id="repost-table" class="table table-hover">
					<tbody>
						<c:forEach items="${rePosts}" var="rePost">
							<tr>
								<td class=" td-post-writer-img "><img
									src="${rePost.getImgSrc()}"></td>

								<td class="font-middle"><b>${rePost.writerName}</b>
									${rePost.getFormatCreated()}</td>
								<td class="function-div font-middle">
									<div class="pull-right">
										<a onClick='javascript:showCommentAdd(${rePost.rePostID})'><span
											class="function-button function-comment">댓글달기</span></a>
										<!-- <a href="/code/${code.codeID}/${rePost.rePostID}/update"> <span
											class="function-button">수정</span></a>-->
										<a onclick="return confirm('정말로 삭제하시겠습니까?');"
											href='/code/${code.codeID}/${rePost.rePostID}/delete'> <span
											class="function-button">삭제</span>
										</a>
									</div>
								</td>
								<td class="td-button"><span class="span-button">${rePost.push}
										<p class="p-button">추천</p>
								</span></td>
								<td class="td-button"><span class="span-button">${rePost.replys.size()}
										<p class="p-button">댓글</p>
								</span></td>
							</tr>
							<c:if test="${rePost.dataNames.size() > 0}">
								<tr>
									<td colspan="5"><c:forEach var="index" begin="0"
											end="${rePost.dataNames.size()-1}">
											<a href='/data/${rePost.dataIDs.get(index)}'><span
												class="function-button function-file"><i
													class='icon-file icon-white'></i>
													${rePost.dataNames.get(index)}</span></a>
										</c:forEach></td>
								</tr>
								<c:forEach var="index" begin="0"
									end="${rePost.dataNames.size()-1}">
									<c:if
										test="${rePost.dataNames.get(index).endsWith('jpg')||
									rePost.dataNames.get(index).endsWith('png') ||
										rePost.dataNames.get(index).endsWith('bmp') ||
										rePost.dataNames.get(index).endsWith('jpeg')}">

										<tr>
											<td colspan="5"><img class="post-img"
												src="/data/${rePost.dataIDs.get(index)}"></td>
										</tr>
									</c:if>
								</c:forEach>
							</c:if>
							<tr>
								<td class="none-top-border repost-top-title" colspan="5">${rePost.content}</td>
							</tr>

							<tr>
								<td id="comment-form-td-${rePost.rePostID}"
									class="none-top-border" colspan="5"></td>

							</tr>
							<c:forEach items="${rePost.replys}" var="reply">
								<tr>
									<td class="none-top-border"></td>
									<td class="reply dot-top-border" colspan="4"><b>${reply.number}.</b>
										${reply.content} - <b>${reply.writerName}</b>
										${reply.getFormatCreated()}
										<div class="function-div pull-right">
											<a onclick="return confirm('정말로 삭제하시겠습니까?');"
												href='/code/${code.codeID}/${rePost.rePostID}/${reply.number}/delete'>
												<i class='icon-remove'></i>
											</a>
										</div></td>
								</tr>
							</c:forEach>
						</c:forEach>

					</tbody>
				</table>
				<!-- 답변에 관련된 테이블 끝-->

			</div>
		</div>
		<%@ include file="/WEB-INF/common/footer.jsp"%>
	</div>

</body>


</html>