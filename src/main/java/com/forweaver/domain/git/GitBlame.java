package com.forweaver.domain.git;

import java.text.SimpleDateFormat;

import org.eclipse.jgit.revwalk.RevCommit;

public class GitBlame {

	private String commitID;
	private String userName;
	private String userEmail;
	private String commitTime;
	
	public GitBlame(RevCommit rc) {
		super();
		this.commitID = rc.getName();
		this.userName = rc.getAuthorIdent().getName();
		this.userEmail = rc.getAuthorIdent().getEmailAddress();
		this.commitTime = new SimpleDateFormat("yy-MM-dd").format(rc.getAuthorIdent().getWhen());
	}
	public String getCommitID() {
		return commitID;
	}
	public void setCommitID(String commitID) {
		this.commitID = commitID;
	}
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserEmail() {
		return userEmail;
	}
	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}
	public String getCommitTime() {
		return commitTime;
	}
	public void setCommitTime(String commitTime) {
		this.commitTime = commitTime;
	}
	

	
}
