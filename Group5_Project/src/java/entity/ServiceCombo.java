/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author minhq
 */
import java.util.*;
public class ServiceCombo {
    private int comboID;
    private String name;
    private String description;
    private double comboPrice;
    private boolean isActive;
    private List<Service> combo;

    public ServiceCombo() {
    }

    public ServiceCombo(int comboID, String name, String description, double comboPrice,boolean isActive, List<Service> combo) {
        this.comboID = comboID;
        this.name = name;
        this.description = description;
        this.comboPrice = comboPrice;
        this.combo = combo;
        this.isActive=isActive;
    }

    public int getComboID() {
        return comboID;
    }

    public void setComboID(int comboID) {
        this.comboID = comboID;
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

    public double getComboPrice() {
        return comboPrice;
    }

    public void setComboPrice(double comboPrice) {
        this.comboPrice = comboPrice;
    }

    public List<Service> getCombo() {
        return combo;
    }

    public void setCombo(List<Service> combo) {
        this.combo = combo;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
    
    
}
