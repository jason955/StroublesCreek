package net.codejava.spring.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import net.codejava.spring.model.Bookmark3D;
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

    public User checkUser(String name, String password) {
        String sql = "Select * from login_users WHERE username= '"+ name +"' and password= '" + password +"'";
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
    
    public void insertBmark(Bookmark3D bmrk) {
        String sql = "INSERT INTO bookmark3d (name, description, posX, posY, posZ, orient1, orient2, orient3, orient4, cor1, cor2, cor3)"
                + " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, bmrk.getName(),
                bmrk.getDescription(),bmrk.getPosX(), bmrk.getPosY(), bmrk.getPosZ(), bmrk.getOrient1(),
                bmrk.getOrient2(), bmrk.getOrient3(), bmrk.getOrient4(), bmrk.getCor1(), bmrk.getCor2(), bmrk.getCor3());
     
    }
    public Bookmark3D getBmark3D(String name, int id) {
        String sql = "Select * from bookmark3d WHERE username= '"+ name +"' and user_id= '" + id +"'";
        return jdbcTemplate.query(sql, new ResultSetExtractor<Bookmark3D>() {

            @Override
            public Bookmark3D extractData(ResultSet rs) throws SQLException,
            DataAccessException {
                if (rs.next()) {
                    Bookmark3D bmrk = new Bookmark3D(); 
                    bmrk.setUser_id(rs.getInt("user_id"));
                    bmrk.setName(rs.getString("name"));
                    bmrk.setDescription(rs.getString("description"));
                    bmrk.setPosX(rs.getInt("posX"));
                    bmrk.setPosY(rs.getInt("posY"));
                    bmrk.setPosZ(rs.getInt("posZ"));
                    bmrk.setOrient1(rs.getInt("orient1"));
                    bmrk.setOrient2(rs.getInt("orient2"));
                    bmrk.setOrient3(rs.getInt("orient3"));
                    bmrk.setOrient4(rs.getInt("orient4"));
                    bmrk.setCor1(rs.getInt("cor1"));
                    bmrk.setCor2(rs.getInt("cor2"));
                    bmrk.setCor3(rs.getInt("cor3"));

                    return bmrk;
                }

                return null;
            }

        });

    }
    public Bookmark3D getBmark3DLast() {
        String sql = "Select * from bookmark3d ORDER BY user_id DESC LIMIT 1;";
        return jdbcTemplate.query(sql, new ResultSetExtractor<Bookmark3D>() {

            @Override
            public Bookmark3D extractData(ResultSet rs) throws SQLException,
            DataAccessException {
                if (rs.next()) {
                    Bookmark3D bmrk = new Bookmark3D(); 
                    bmrk.setUser_id(rs.getInt("user_id"));
                    bmrk.setName(rs.getString("name"));
                    bmrk.setDescription(rs.getString("description"));
                    bmrk.setPosX(rs.getInt("posX"));
                    bmrk.setPosY(rs.getInt("posY"));
                    bmrk.setPosZ(rs.getInt("posZ"));
                    bmrk.setOrient1(rs.getInt("orient1"));
                    bmrk.setOrient2(rs.getInt("orient2"));
                    bmrk.setOrient3(rs.getInt("orient3"));
                    bmrk.setOrient4(rs.getInt("orient4"));
                    bmrk.setCor1(rs.getInt("cor1"));
                    bmrk.setCor2(rs.getInt("cor2"));
                    bmrk.setCor3(rs.getInt("cor3"));


                    return bmrk;
                }

                return null;
            }

        });

    }





}
