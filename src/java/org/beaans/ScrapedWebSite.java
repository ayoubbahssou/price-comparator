package org.beaans;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import org.beaans.Product;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 *
 * @author ayoub
 */
public class ScrapedWebSite {
    private String url;
    private String productClass;
    private String productName;
    private String productUrl;
    private String productPrice;

    public ScrapedWebSite(String url, String productClass, String productName, String productUrl, String productPrice) {
        this.url = url;
        this.productClass = productClass;
        this.productName = productName;
        this.productUrl = productUrl;
        this.productPrice = productPrice;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public void setProductClass(String productClass) {
        this.productClass = productClass;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public void setProductUrl(String productUrl) {
        this.productUrl = productUrl;
    }

    public void setProductPrice(String productPrice) {
        this.productPrice = productPrice;
    }

    public String getUrl() {
        return url;
    }

    public String getProductClass() {
        return productClass;
    }

    public String getProductName() {
        return productName;
    }

    public String getProductUrl() {
        return productUrl;
    }

    public String getProductPrice() {
        return productPrice;
    }

    public List<Product> scrapeProduct(String query){
       List <Product> sr=new ArrayList<Product>();
       // SearchRes[] sr=new SearchRes[10];     
        //sr = new SearchRes()[];
       //
      //  SearchRes sr[]=new SearchRes();
        switch(this.url){
            case "microchoix.ma":
                 try {
        
           
        Document   doc= Jsoup.connect("http://www.microchoix.ma/recherche.html")
               .data("Mcle",query)
               .post();
                
    
           Elements content = doc.getElementsByClass(this.productClass);
           
//System.out.println(Arrays.toString(content.toArray()));

     int i = 0;
           for (Element c : content) {
              
                String title = c.getElementsByTag("a").attr(this.productName);
    //         System.out.println(title); 
                String urlProduct=c.getElementsByTag("a").attr(this.productUrl);
      //      System.out.println(urlProduct); 
               //String description=c.getElementsByClass("stDscp").text();
                //System.out.println(description); 
                  String price=c.getElementsByClass(this.productPrice).first().text();
        //        System.out.println(price); 
                Product result=new Product(title,this.url,price,urlProduct);
           sr.add(result);
                   i=i++;
           }
            
        } catch (IOException ex) {
            //Logger.getLogger(.class.getName()).log(Level.SEVERE, null, ex);
        System.out.println("check connection");
        }
        
                break;
              case "kaymu.ma":
                 try {
            // TODO code application logic here
           
        Document   doc= Jsoup.connect("https://www.jumia.ma/catalog/?q=samsung s5")
                //.data("q","samsung")
                .get();
                //.header("Content-Type","application/x-www-form-urlencoded;charset=UTF-8")
                
             
   
           Elements content = doc.getElementsByClass("link");
           
//System.out.println(Arrays.toString(content.toArray()));

       // Elements links = doc.select("a");
           for (Element c : content) {
              
                String title = c.getElementsByClass(this.productName).text();
             System.out.println(title); 
                String url=c.getElementsByTag("a").attr("href");
            System.out.println(url); 
                     String price=c.getElementsByTag("span").attr("data-price");
                 
                System.out.println(price); 
               // SearchRes result=new SearchRes(title,description,price,url);
           
           }
            
        } catch (IOException ex) {
          //  Logger.getLogger(WebCrawler.class.getName()).log(Level.SEVERE, null, ex);
        }
      /*  String price="1 520DH00";
        price=price.replace("DH00", "");
        price=price.replace(" ", "");
            Float pric=Float.parseFloat(price);
//price=price.replace("","");
                  System.out.println(pric); */
                  break;
            case "jumia.ma":
                
                break; 
        }
               
   return sr; 
    }
}