package com.newsfeed;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;

import java.io.IOException;
import java.io.PrintWriter;

import org.json.JSONArray;
import org.json.JSONObject;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.interceptor.ServletRequestAware;
import org.apache.struts2.interceptor.ServletResponseAware;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;

public class NewsFeed extends ActionSupport implements ServletRequestAware, ServletResponseAware{
	public HttpServletResponse response;
	public HttpServletRequest request;
	
	@Override
	public void setServletResponse(HttpServletResponse response) {
		this.response = response;
	}
	@Override
	public void setServletRequest(HttpServletRequest request) {
		this.request = request;
	}
	public void fetchJSON() throws IOException{
		PrintWriter out = response.getWriter();
		try{
			Class.forName("com.mysql.jdbc.Driver");  
			Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/AE","root","");
			Statement stmt = conn.createStatement();
			ResultSet rs=stmt.executeQuery("select * from newsdata");
			JSONArray jsonArr = new JSONArray();
			while(rs.next()){  
				JSONObject json = new JSONObject();
				json.put("article",rs.getString(2));
				json.put("link",rs.getString(3));
				json.put("publisher",rs.getString(4));
				jsonArr.put(json);
			}
			out.println(jsonArr.toString());
		}
		catch(Exception e){
			out.println("ERROR");
		}
	}
}
