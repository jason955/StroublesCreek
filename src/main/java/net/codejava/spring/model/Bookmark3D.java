package net.codejava.spring.model;

public class Bookmark3D {
    private int user_id;
    private String name;
    private String description;
    private String posX;
    private String posY;
    private String posZ;
    private String orient1;
    private String orient2;
    private String orient3;
    private String orient4;
    private String cor1;
    private String cor2;
    private String cor3;
    public Bookmark3D(int user_id, String name, String description, String posX, String posY,
            String posZ, String orient1, String orient2, String orient3, String orient4, String cor1, String cor2, String cor3) {
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
        this.cor1 = cor1;
        this.cor2 = cor2;
        this.cor3 = cor3;
    }
    public String getCor1() {
        return cor1;
    }
    public void setCor1(String cor1) {
        this.cor1 = cor1;
    }
    public String getCor2() {
        return cor2;
    }
    public void setCor2(String cor2) {
        this.cor2 = cor2;
    }
    public String getCor3() {
        return cor3;
    }
    public void setCor3(String cor3) {
        this.cor3 = cor3;
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
    public String getPosX() {
        return posX;
    }
    public void setPosX(String posX) {
        this.posX = posX;
    }
    public String getPosY() {
        return posY;
    }
    public void setPosY(String posY) {
        this.posY = posY;
    }
    public String getPosZ() {
        return posZ;
    }
    public void setPosZ(String posZ) {
        this.posZ = posZ;
    }
    public String getOrient1() {
        return orient1;
    }
    public void setOrient1(String orient1) {
        this.orient1 = orient1;
    }
    public String getOrient2() {
        return orient2;
    }
    public void setOrient2(String orient2) {
        this.orient2 = orient2;
    }
    public String getOrient3() {
        return orient3;
    }
    public void setOrient3(String orient3) {
        this.orient3 = orient3;
    }
    public String getOrient4() {
        return orient4;
    }
    public void setOrient4(String orient4) {
        this.orient4 = orient4;
    }
}
