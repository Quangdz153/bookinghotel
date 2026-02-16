/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.sql.Date;

/**
 *
 * @author ASUS
 */
public class Account {

    private int accountID;
    private String username, password, role;
    private Date createAt;
    private String staffID;
    private int guestID;
    private Staff staff;
    private Guest guest;

    public Account() {
    }

    public Account(String username, String password, String role) {
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public Account(int accountID, String username, String password, String role, Date createAt) {
        this.accountID = accountID;
        this.username = username;
        this.password = password;
        this.role = role;
        this.createAt = createAt;
    }

    public Account(int accountID, String username, String password, String role, Date createAt, Staff staff) {
        this.accountID = accountID;
        this.username = username;
        this.password = password;
        this.role = role;
        this.createAt = createAt;
        this.staff = staff;
    }

    public Account(int accountID, String username, String password, String role, Date createAt, Guest guest) {
        this.accountID = accountID;
        this.username = username;
        this.password = password;
        this.role = role;
        this.createAt = createAt;
        this.guest = guest;
    }

    public Account(int accountID, String username, String password, String role) {
        this.accountID = accountID;
        this.username = username;
        this.password = password;
        this.role = role;
    }

    public int getAccountID() {
        return accountID;
    }

    public void setAccountID(int accountID) {
        this.accountID = accountID;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public Date getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Date createAt) {
        this.createAt = createAt;
    }

    public String getStaffID() {
        return staffID;
    }

    public void setStaffID(String staffID) {
        this.staffID = staffID;
    }

    public int getGuestID() {
        return guestID;
    }

    public void setGuestID(int guestID) {
        this.guestID = guestID;
    }

    public Staff getStaff() {
        return staff;
    }

    public void setStaff(Staff staff) {
        this.staff = staff;
    }

    public Guest getGuest() {
        return guest;
    }

    public void setGuest(Guest guest) {
        this.guest = guest;
    }

    @Override
    public String toString() {
        return "Account{" + "accountID=" + accountID + ", username=" + username + ", password=" + password + ", role=" + role + ", createAt=" + createAt + ", staffID=" + staffID + ", guestID=" + guestID + ", staff=" + staff + ", guest=" + guest + '}';
    }

}
