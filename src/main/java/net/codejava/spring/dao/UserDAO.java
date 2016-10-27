package net.codejava.spring.dao;

import java.util.List;

import net.codejava.spring.model.Bookmark3D;
import net.codejava.spring.model.User;

/**
 * Defines DAO operations for the contact model.
 * @author www.codejava.net
 *
 */
public interface UserDAO {
	/**
	 * Insert user or upadte if in db
	 * @param user the user
	 */
	public void saveOrUpdate(User user);
	/**
	 * delete the user
	 * @param userId id of user to delete
	 */
	public void delete(int userId);
	/**
	 * get the user by id
	 * @param userId the id 
	 * @return the user
	 */
	public User get(int userId);
	/**
	 * a list of all users in db
	 * @return the users
	 */
	public List<User> list();
	/**
	 * update bookmark to whatever the current url is
	 * this is for saving photospheres
	 * @param user the user with a new bookmark
	 */
	public void updateBookmark(User user);
	/**
	 * checks if user is in db
	 * @param name username
	 * @param password password
	 * @return true if yes false if no
	 */
	public User checkUser(String name, String password); 

	public void insertBmark(Bookmark3D bmrk);
	public Bookmark3D getBmark3D(String name, int id);
	public Bookmark3D getBmark3DLast();
	
}
