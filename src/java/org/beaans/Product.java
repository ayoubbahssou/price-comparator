package org.beaans;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author ayoub
 */
public class Product {
public String title;
//public String description;
public String price;
public String url;
public String supplier;
    public Product(String title,String supplier, String price, String url) {
        this.title = title;
  //      this.description = description;
        this.price = price;
        this.url = url;
        this.supplier=supplier;
    }

    public Product() {
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

   
    
    
}
