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
public class Guest {

    private int guestID;
    private String firstName, lastName;
    private Date dateOfBirth;
    private String address;
    private String city, country;
    private String phone, email;

    public Guest() {
    }

    public Guest(int guestID, String firstName, String lastName, Date dateOfBirth, String address, String city, String country, String phone, String email) {
        this.guestID = guestID;
        this.firstName = firstName;
        this.lastName = lastName;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.city = city;
        this.country = country;
        this.phone = phone;
        this.email = email;
    }
    
    public Guest(int guestID, String phone, String email) {
        this.guestID = guestID;
        this.phone = phone;
        this.email = email;
    }
    
    public Guest(String firstName, String lastName, Date dateOfBirth, String address, String city, String country, String phone, String email) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.dateOfBirth = dateOfBirth;
        this.address = address;
        this.city = city;
        this.country = country;
        this.phone = phone;
        this.email = email;
    }

    public int getGuestID() {
        return guestID;
    }

    public void setGuestID(int guestID) {
        this.guestID = guestID;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public Date getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(Date dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }
    
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    @Override
    public String toString() {
        return "Guest{" + "guestID=" + guestID + ", firstName=" + firstName + ", lastName=" + lastName + ", dateOfBirth=" + dateOfBirth + ", address=" + address + ", phone=" + phone + ", email=" + email + '}';
    }

}
