package com.forweaver.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;

@Document
public class RePost implements Serializable {

	static final long serialVersionUID = 573464611669134L;
	@Id
	private int rePostID;
	private String content;
	private Date created;
	private int push;
	private Date recentReplyDate;
	private int kind; // 1이 일반 공개글의 답변, 2가 비밀 글 답변 , 3이 메세지글 답변 , 4가 코드의 답변.
	
	@DBRef
	private Post originalPost;
	@DBRef
	private Code originalCode;
	@DBRef
	private Weaver writer;
	@DBRef
	private Weaver origianlWriter;
	
	@DBRef
	private List<Data> datas = new ArrayList<Data>();
	private List<Reply> replys = new ArrayList<Reply>();
	private List<String> tags = new ArrayList<String>();
	public RePost() {
	}

	public RePost(Post originalPost,Weaver writer, String content,List<String> tags,int kind) {
		this.writer = writer;
		this.origianlWriter = originalPost.getWriter();
		this.content = content;
		this.kind = kind;
		this.created = new Date();
		this.originalPost = originalPost;
		this.tags = originalPost.getTags();
	}
	
	public RePost(Code originalCode,Weaver writer, String content,List<String> tags,int kind) {
		this.writer = writer;
		this.origianlWriter = originalCode.getWriter();
		this.content = content;
		this.kind = kind;
		this.created = new Date();
		this.originalCode = originalCode;
		this.tags = originalCode.getTags();
	}

	public int getRePostID() {
		return rePostID;
	}

	public void setRePostID(int rePostID) {
		this.rePostID = rePostID;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

	public String getFormatCreated() {
		SimpleDateFormat df = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
		return df.format(created);
	}

	public String getWriterName() {
		return this.writer.getId();
	}

	public int getPush() {
		return push;
	}

	public void setPush(int push) {
		this.push = push;
	}

	public String getWriterEmail() {
		return this.writer.getEmail();
	}

	public String getImgSrc() {
		return this.writer.getImgSrc();
	}


	public void push() {
		this.push += 1;
	}

	public List<Reply> getReplys() {
		return replys;
	}

	public void setReplys(List<Reply> replys) {
		this.replys = replys;
	}

	public void addReply(Reply reply) {
		if (this.replys.size() == 0)
			reply.setNumber(1);
		else
			reply.setNumber(this.replys.get(0).getNumber() + 1);
		this.replys.add(0, reply);
	}

	public void updateReply(Reply reply, Weaver weaver, int number) {
		for (Reply tmpReply : this.replys) {
			if (tmpReply.getNumber() == number
					&& weaver.getId().equals(tmpReply.getWriterName()))
				tmpReply = reply;

		}
	}

	public boolean removeReply(Weaver weaver, int number) {
		for (int i = 0; i < this.replys.size(); i++) {
			if (this.replys.get(i).getNumber() == number
					&& weaver.getId()
							.equals(this.replys.get(i).getWriterName()))
				this.replys.remove(i);
			return true;
		}
		return false;
	}

	public Date getRecentReplyDate() {
		return recentReplyDate;
	}

	public void setRecentReplyDate(Date recentReplyDate) {
		this.recentReplyDate = recentReplyDate;
	}

	public void addData(Data data){
		this.datas.add(data);
	}
	
	public void deleteData(String name){
		for(int i = 0 ; i< this.datas.size() ; i++){
			if(this.datas.get(i).getName().equals(name)){
				this.datas.remove(i);
				return;
			}
		}
		
	}

	public List<Data> getDatas() {
		return datas;
	}

	public void setDatas(List<Data> datas) {
		this.datas = datas;
	}

	public int getKind() {
		return kind;
	}

	public void setKind(int kind) {
		this.kind = kind;
	}
	
	public Data getData(String dataName){
		for(Data data:this.datas)
			if(data.getName().equals(dataName))
				return data;
		return null;
	}

	public Weaver getWriter() {
		return writer;
	}

	public void setWriter(Weaver writer) {
		this.writer = writer;
	}

	public Weaver getOrigianlWriter() {
		return origianlWriter;
	}

	public void setOrigianlWriter(Weaver origianlWriter) {
		this.origianlWriter = origianlWriter;
	}

	public List<String> getTags() {
		return null;
	}

	public Post getOriginalPost() {
		return originalPost;
	}

	public void setOriginalPost(Post originalPost) {
		this.originalPost = originalPost;
	}

	public Code getOriginalCode() {
		return originalCode;
	}

	public void setOriginalCode(Code originalCode) {
		this.originalCode = originalCode;
	}	
	
	
}
