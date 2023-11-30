
package com.ram.blog.dao;
import com.ram.blog.entities.Category;
import com.ram.blog.entities.Post;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class PostDao {
    Connection con;

    public PostDao(Connection con) {
        this.con = con;
    }
    
    public ArrayList<Category> getAllCategories(){
        ArrayList<Category> list=new ArrayList<>();
        
        try {
            String q="select * from catagories";
            Statement st=this.con.createStatement();
            ResultSet set=st.executeQuery(q);
            
            while(set.next()){
                int cid=set.getInt("cid");
                String name=set.getString("name");
                String description=set.getString("description");
                Category c=new Category(cid,name,description);
                list.add(c);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    public boolean savePost(Post p){
        boolean f=false;
        
        try {
            
            String q="insert into post(pTitle,pContent,pCode,pPic,cid,userId) values(?,?,?,?,?,?)";
            PreparedStatement pstmt=con.prepareStatement(q);
            pstmt.setString(1, p.getpTitle());
            pstmt.setString(2, p.getpContent());
            pstmt.setString(3, p.getpCode());
            pstmt.setString(4, p.getpPic());
            pstmt.setInt(5, p.getCid());
            pstmt.setInt(6, p.getUserId());
            
            pstmt.executeUpdate();
            f=true;
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return f;
    }
    
    public List<Post> getAllPost(){
        List<Post> list=new ArrayList<>();
        try {
            String query="select * from post";
            PreparedStatement p=con.prepareStatement(query);
            ResultSet set=p.executeQuery();
            
            while(set.next()){
                int pid=set.getInt("pid");
                String pTitle=set.getString("pTitle");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                Timestamp pDate=set.getTimestamp("pDate");
                int cid=set.getInt("cid");
                int userId=set.getInt("userId");
                
                Post ppost=new Post(pid, pTitle, pContent, pCode, pPic, pDate, cid, userId);
                list.add(ppost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        return list;
    }
    
    
    public List<Post> getPostByCatId(int cid){
         List<Post> list=new ArrayList<>();
          try {
            String query="select * from post where cid=?";
            
            PreparedStatement p=con.prepareStatement(query);
            p.setInt(1,cid);
            ResultSet set=p.executeQuery();
            
            while(set.next()){
                int pid=set.getInt("pid");
                String pTitle=set.getString("pTitle");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                Timestamp pDate=set.getTimestamp("pDate");
                int userId=set.getInt("userId");
                
                Post ppost=new Post(pid, pTitle, pContent, pCode, pPic, pDate, cid, userId);
                list.add(ppost);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
       
        
        return list;
    }
    
    public Post getPostByPostId(int postId){
        Post post=null;
        try {
            String q="select * from post where pid=?";
            PreparedStatement p=this.con.prepareStatement(q);
            p.setInt(1, postId);
            ResultSet set=p.executeQuery();
            
            if(set.next()){
                  int pid=set.getInt("pid");
                String pTitle=set.getString("pTitle");
                String pContent=set.getString("pContent");
                String pCode=set.getString("pCode");
                String pPic=set.getString("pPic");
                Timestamp pDate=set.getTimestamp("pDate");
                int cid=set.getInt("cid");
                int userId=set.getInt("userId");
                
                post=new Post(pid, pTitle, pContent, pCode, pPic, pDate, cid, userId);
            }
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return post;
    }
}
