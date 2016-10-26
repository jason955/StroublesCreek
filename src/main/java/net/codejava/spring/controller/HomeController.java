package net.codejava.spring.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpServletRequest;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;

import net.codejava.spring.dao.UserDAO;
import net.codejava.spring.model.Bookmark3D;
import net.codejava.spring.model.User;

/**
 * This controller routes accesses to the application to the appropriate
 * hanlder methods. 
 *
 */
@Controller
@EnableWebMvc
public class HomeController {

	@Autowired
	private UserDAO userDAO;
	
	@RequestMapping(value="/")
	public ModelAndView listUser(ModelAndView model) throws IOException{
		List<User> listUser = userDAO.list();
		model.addObject("listUser", listUser);
		model.setViewName("home");
		
		return model;
	}
	
	@RequestMapping(value = "/newUser", method = RequestMethod.GET)
	public ModelAndView newUser(ModelAndView model) {
		User newUser = new User();
		model.addObject("user", newUser);
		model.setViewName("UserForm");
		return model;
	}
	
	@RequestMapping(value = "/saveUser", method = RequestMethod.POST)
	public ModelAndView saveUser(@ModelAttribute User user) {
	    userDAO.saveOrUpdate(user);		
		return new ModelAndView("redirect:/");
	}
	
	@RequestMapping(value = "/deleteUser", method = RequestMethod.GET)
	public ModelAndView deleteUser(HttpServletRequest request) {
		int userId = Integer.parseInt(request.getParameter("id"));
		userDAO.delete(userId);
		return new ModelAndView("redirect:/");
	}
	
	@RequestMapping(value = "/editUser", method = RequestMethod.GET)
	public ModelAndView editUser(HttpServletRequest request) {
		int userId = Integer.parseInt(request.getParameter("id"));
		User user = userDAO.get(userId);
		ModelAndView model = new ModelAndView("UserForm");
		user.setBookmark(request.getParameter("bookmark"));
		model.addObject("user", user);
		
		return model;
	}
	
    @RequestMapping(value = "/checkUser", method = RequestMethod.POST, produces="application/json")
    public @ResponseBody User checkUser(HttpServletRequest request) {
        String[] parts = request.getParameterValues("mark")[0].split("~n0");
        String name = parts[0];
        String pass = parts[1];
        User user2 = userDAO.checkUser(name, pass);

        return user2;
        
    }
    @RequestMapping(value = "/editBookmark", method = RequestMethod.GET)
    public void editBookmark( @RequestParam(value="mark") String mark) {
        String[] parts = mark.split("~n0");
        String id = parts[0];
        String bm = parts[1];
        int userId = Integer.parseInt(id);
        User user = userDAO.get(userId);
        user.setBookmark(bm);
        userDAO.updateBookmark(user);     
  
        
    }
    @RequestMapping(value = "/getUser", method = RequestMethod.GET)
    public User getUser(@RequestParam(value="id") String id) {
        int userId = Integer.parseInt(id);
        User user = userDAO.get(userId);
        return user;
    }
    @RequestMapping(value = "/getBook3D", method = RequestMethod.POST, produces="application/json")
    public @ResponseBody Bookmark3D getBookmark3D(@RequestBody Bookmark3D bmrk) {
      
        Bookmark3D bmrkRet = userDAO.getBmark3D(bmrk.getName(), bmrk.getUser_id());

        return bmrkRet;
        
    }
    @RequestMapping(value = "/insertBook3D", method = RequestMethod.POST, produces="application/json")
    public void insertBookmark3D(@RequestBody Bookmark3D bmrk) {
        
        userDAO.insertBmark(bmrk);
    }

}
