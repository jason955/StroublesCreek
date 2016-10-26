package net.codejava.spring.model;

public class Bookmark3D {
    private int user_id;
    private String name;
    private String description;
    private int posX;
    private int posY;
    private int posZ;
    private int orient1;
    private int orient2;
    private int orient3;
    private int orient4;
    public Bookmark3D(int user_id, String name, String description, int posX, int posY,
            int posZ, int orient1, int orient2, int orient3, int orient4) {
        this.user_id = user_id;
        this.name = name;
        this.description = description;
        this.posX = posX;
        this.posY = posY;
        this.posZ = posZ;
        this.orient1 = orient1;
        this.orient2 = orient2;
        this.orient3 = orient3;
        this.orient4 = orient4;
    }
    public Bookmark3D() {
        
    }
    public int getUser_id() {
        return user_id;
    }
    public void setUser_id(int user_id) {
        this.user_id = user_id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public int getPosX() {
        return posX;
    }
    public void setPosX(int posX) {
        this.posX = posX;
    }
    public int getPosY() {
        return posY;
    }
    public void setPosY(int posY) {
        this.posY = posY;
    }
    public int getPosZ() {
        return posZ;
    }
    public void setPosZ(int posZ) {
        this.posZ = posZ;
    }
    public int getOrient1() {
        return orient1;
    }
    public void setOrient1(int orient1) {
        this.orient1 = orient1;
    }
    public int getOrient2() {
        return orient2;
    }
    public void setOrient2(int orient2) {
        this.orient2 = orient2;
    }
    public int getOrient3() {
        return orient3;
    }
    public void setOrient3(int orient3) {
        this.orient3 = orient3;
    }
    public int getOrient4() {
        return orient4;
    }
    public void setOrient4(int orient4) {
        this.orient4 = orient4;
    }
}
