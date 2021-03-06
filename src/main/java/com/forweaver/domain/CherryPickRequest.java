package com.forweaver.domain;

import java.util.Date;

import javax.persistence.Id;

import org.springframework.data.mongodb.core.mapping.DBRef;

/**<pre>  채리픽 요청을 저장하는 클래스
 * id 아이디
 * orginalProject 원본 프로젝트
 * cherryPickProject 체리픽 프로젝트
 * commitID 커밋 아이디
 * requestWeaver 요청자
 * state 상태
 * cherryPickDate 날짜
 * </pre>
 */
public class CherryPickRequest {
	static final long serialVersionUID = 541112234L;
	@Id
	private String id;
	@DBRef
	private Project orginalProject;
	@DBRef
	private Project cherryPickProject;
	private String commitID;
	@DBRef
	private Weaver requestWeaver;
	private String state;
	private Date cherryPickDate;
	
	public CherryPickRequest(Project orginalProject, Project cherryPickProject,
			String commitID, Weaver requestWeaver) {
		super();
		this.orginalProject = orginalProject;
		this.cherryPickProject = cherryPickProject;
		this.commitID = commitID;
		this.requestWeaver = requestWeaver;
		this.state = "Wait";
		this.cherryPickDate = new Date();
	}
	
	public Project getOrginalProject() {
		return orginalProject;
	}
	public void setOrginalProject(Project orginalProject) {
		this.orginalProject = orginalProject;
	}
	public Project getCherryPickProject() {
		return cherryPickProject;
	}
	public void setCherryPickProject(Project cherryPickProject) {
		this.cherryPickProject = cherryPickProject;
	}
	public String getCommitID() {
		return commitID;
	}
	public void setCommitID(String commitID) {
		this.commitID = commitID;
	}
	public Weaver getRequestWeaver() {
		return requestWeaver;
	}
	public void setRequestWeaver(Weaver requestWeaver) {
		this.requestWeaver = requestWeaver;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getCherryPickDate() {
		return cherryPickDate;
	}
	public void setCherryPickDate(Date cherryPickDate) {
		this.cherryPickDate = cherryPickDate;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}
