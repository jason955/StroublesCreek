package net.codejava.spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import net.codejava.spring.model.User;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;

/**
 * An implementation of the ContactDAO interface.
 * @author www.codejava.net
 *
 */
public class UserDAOImpl implements UserDAO {

	private JdbcTemplate jdbcTemplate;
	
	public UserDAOImpl(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	
	public void saveOrUpdate(User user) {
		if (user.getId() > 0) {
			// update
			String sql = "UPDATE login_users SET username=?, password=?, bookmark=?"
						+ " WHERE id=?";
			jdbcTemplate.update(sql, user.getName(), user.getPassword(),
			        user.getBookmark(), user.getId());
		} else {
			// insert
		    user.setBookmark("strobles.com");
			String sql = "INSERT INTO login_users (username, password, bookmark)"
						+ " VALUES (?, ?, ?)";
			jdbcTemplate.update(sql, user.getName(), user.getPassword(),
			        user.getBookmark());
		}
		
	}

	
	public void delete(int userID) {
		String sql = "DELETE FROM login_users WHERE id=?";
		jdbcTemplate.update(sql, userID);
	}

	@Override
	public List<User> list() {
		String sql = "SELECT * FROM login_users";
		List<User> listUser = jdbcTemplate.query(sql, new RowMapper<User>() {

			@Override
			public User mapRow(ResultSet rs, int rowNum) throws SQLException {
				User aUser = new User();
	
				aUser.setId(rs.getInt("id"));
				aUser.setName(rs.getString("username"));
				aUser.setPassword(rs.getString("password"));
				aUser.setBookmark(rs.getString("bookmark"));
				
				return aUser;
			}
			
		});
		
		return listUser;
	}

	@Override
	public User get(int userID) {
		String sql = "SELECT * FROM login_users WHERE id=" + userID;
		return jdbcTemplate.query(sql, new ResultSetExtractor<User>() {

			@Override
			public User extractData(ResultSet rs) throws SQLException,
					DataAccessException {
				if (rs.next()) {
					User user = new User();
					user.setId(rs.getInt("id"));
					user.setName(rs.getString("username"));
					user.setPassword(rs.getString("password"));
					user.setBookmark(rs.getString("bookmark"));
					return user;
				}
				
				return null;
			}
			
		});
	}
	public void updateBookmark(User user) {
            String sql = "UPDATE login_users SET username=?, password=?, bookmark=?"
                        + " WHERE id=?";
            jdbcTemplate.update(sql, user.getName(), user.getPassword(),
                    user.getBookmark(), user.getId());        
    }
 

}
