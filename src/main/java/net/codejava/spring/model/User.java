package net.codejava.spring.model;

public class User {
	private int id;
	private String name;
	private String password;
    private String bookmark;

	public User() {
	}

	public User(int id,String name, String password, String bookmark) {
	    this.id = id;
		this.name = name;
		this.password = password;
		this.bookmark = bookmark;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getBookmark() {
        return bookmark;
    }

    public void setBookmark(String bookmark) {
        this.bookmark = bookmark;
    }

	
}
