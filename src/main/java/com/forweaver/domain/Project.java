package com.forweaver.domain;

import java.io.Serializable;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.data.annotation.Id;
import org.springframework.data.annotation.Transient;
import org.springframework.data.mongodb.core.mapping.DBRef;
import org.springframework.data.mongodb.core.mapping.Document;
import org.springframework.web.multipart.MultipartFile;

@Document
public class Project implements Serializable {

	static final long serialVersionUID = 4231232323123124234L;
	@Id
	private String name; //프로젝트 이름 이게 기본 키
	private int category; // 프로젝트 종류 값이 0이면 공개 프로젝트 1이면 비공개 프로젝트.
	private String description; // 프로젝트 소개
	private Date openingDate; // 프로젝트 시작일
	private String creatorName; // 프로젝트 개설자 이름
	private String creatorEmail; // 프로젝트 개설자 이메일
	private int push; // 프로젝트 추천수
	
	@Transient
	private boolean isJoin;
	
	private List<String> tags = new ArrayList<String>(); // 프로젝트의 태그 모음
	
	@DBRef
	private List<Weaver> adminWeavers = new ArrayList<Weaver>(); // 관리자들
	@DBRef
	private List<Weaver> joinWeavers = new ArrayList<Weaver>(); // 비 관리자 회원들
	
	public Project() {
		
	}
	
	public Project(String name, int category, String description,
			Weaver weaver,List<String> tagList) {
		super();
		this.name = weaver.getId()+"/"+name;
		this.category = category;
		this.description = description;
		this.openingDate = new Date();
		this.creatorName = weaver.getId();
		this.creatorEmail = weaver.getEmail();
		this.adminWeavers.add(weaver);
		this.tags = tagList;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getCategory() {
		return category;
	}

	public void setCategory(int category) {
		this.category = category;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Date getOpeningDate() {
		return openingDate;
	}

	public void setOpeningDate(Date openingDate) {
		this.openingDate = openingDate;
	}

	public String getCreatorName() {
		return creatorName;
	}

	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}

	
	public String getOpeningDateFormat() {
		SimpleDateFormat df = new SimpleDateFormat("yy/MM/dd");
		return df.format(this.openingDate); 
	}

	public String getCreatorEmail() {
		return creatorEmail;
	}

	public void setCreatorEmail(String creatorEmail) {
		this.creatorEmail = creatorEmail;
	}
	public void addAdminWeaver(Weaver weaver){
		this.adminWeavers.add(weaver);
	}
	
	public void addJoinWeaver(Weaver weaver){
		this.joinWeavers.add(weaver);
	}
	public List<String> getTags() {
		return tags;
	}

	public void setTags(List<String> tags) {
		this.tags = tags;
	}


	public int getPush() {
		return push;
	}

	public void setPush(int push) {
		this.push = push;
	}
	
	public void push(){
		this.push +=1;
	}

	public List<Weaver> getAdminWeavers() {
		return adminWeavers;
	}

	public void setAdminWeavers(List<Weaver> adminWeavers) {
		this.adminWeavers = adminWeavers;
	}

	public List<Weaver> getJoinWeavers() {
		return joinWeavers;
	}

	public void setJoinWeavers(List<Weaver> joinWeavers) {
		this.joinWeavers = joinWeavers;
	}
	
	public boolean isJoin() {
		return isJoin;
	}

	public void setJoin(boolean isJoin) {
		this.isJoin = isJoin;
	}
	public String getImgSrc(){
		return "/img/"+this.creatorName;
	}
	
	public void removeJoinWeaver(Weaver weaver){
		this.joinWeavers.remove(weaver);
	}
	
}
