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

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
//import javax.xml.bind.Element;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

public class AmazonProductLookup {

    
    private static final String AWS_ACCESS_KEY_ID = "AKIAIRIFIDBCPNNCVQGQ";

    
    private static final String AWS_SECRET_KEY = "kLO0cDrPYa0962N0g6GEox4/GKLWgwfCYeitsAwP";

    /*
     * 
     * 
     *      US: ecs.amazonaws.com 
     *      CA: ecs.amazonaws.ca 
     *      UK: ecs.amazonaws.co.uk 
     *      DE: ecs.amazonaws.de 
     *      FR: ecs.amazonaws.fr 
     *      JP: ecs.amazonaws.jp
     * 
     */
    private static final String ENDPOINT = "ecs.amazonaws.com";

    
    private static final String ITEM_ID = "B00J8DL78O";
    private static final String ASSOCIATE_TAG = "pricomp-20";
    public String query;
    public String requestUrl;
    
    public AmazonProductLookup(String query) {
    
    
    
        /*
         * Set up the signed requests helper 
         */
        SignedRequestsHelper helper;
        try {
            helper = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY);
        } catch (Exception e) {
            e.printStackTrace();
            return;
        }
        
        //String requestUrl = null;
        String title = null;

    
       // System.out.println("Map form");
        Map<String, String> params = new HashMap<String, String>();
        params.put("Service", "AWSECommerceService");
        params.put("Version", "2009-03-31");
        //params.put("Operation", "ItemLookUp");
        params.put("Operation", "ItemSearch");
        params.put("AssociateTag",ASSOCIATE_TAG);
        //params.put("IdType", "ASIN");
        //params.put("ItemId","B00YT13T3Q");
        //ResponseGroup=Offers,Variation  B00YT13T3Q
        params.put("Keywords",query);
        params.put("SearchIndex","Electronics");        
//Keywords=Rocket SearchIndex=Toys (172282 BrowseNode
        params.put("ResponseGroup","OfferFull");
        
        requestUrl = helper.sign(params);
        this.query=query;
        //System.out.println("Signed Request is \"" + requestUrl + "\"");
}
       
    public  List<Product> fetchProducts() {
        //String title = null;
        String asin = null;
        String url ;
         List <Product> sr=new ArrayList<Product>();
        try {
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            Document doc = db.parse(requestUrl);
  //          NodeList offers = doc.getElementsByTagName("Offers");
            NodeList items = doc.getElementsByTagName("Item");
           
    //        System.out.println(offers.getLength());
          for (int i = 0; i < items.getLength(); i++) {
              Node nodeItem=items.item(i);
               Element item = (Element)nodeItem;
               Node asinNode =item.getElementsByTagName("ASIN").item(0);
               Node urlNode =item.getElementsByTagName("MoreOffersUrl").item(0);
                url= urlNode.getTextContent();
                asin = asinNode.getTextContent();
                SignedRequestsHelper helper2;

                helper2 = SignedRequestsHelper.getInstance(ENDPOINT, AWS_ACCESS_KEY_ID, AWS_SECRET_KEY);

                Map<String, String> params = new HashMap<String, String>();
                params.put("Service", "AWSECommerceService");
        params.put("Version", "2009-03-31");
         params.put("AssociateTag",ASSOCIATE_TAG);
        params.put("Operation", "ItemLookup");
        params.put("ItemId", asin);
        params.put("ResponseGroup", "Small");
        String requestUrl2 = helper2.sign(params);
DocumentBuilderFactory dbf2 = DocumentBuilderFactory.newInstance();
            DocumentBuilder db2 = dbf2.newDocumentBuilder();
            Document doc2 = db2.parse(requestUrl2);
            Node titleNode = doc2.getElementsByTagName("Title").item(0);
            String title=titleNode.getTextContent();
       /* System.out.println("asin="+asin);
        System.out.println("url="+url);
        System.out.println("title="+title);*/
               //Document offersNode= (Document)nodeItem;
            NodeList offers = item.getElementsByTagName("Offer");
            for (int j = 0; j < offers.getLength(); j++){
             Node nodeOffer=offers.item(j);
               Element offer = (Element)nodeOffer;
               Node merchant=offer.getElementsByTagName("Name").item(0);
              // System.out.println("     merchant  "+merchant.getTextContent());
               Node price=offer.getElementsByTagName("FormattedPrice").item(0);
               //System.out.println("     price     "+price.getTextContent());
               //FormattedPrice
            Product result=new Product(title,merchant.getTextContent(),price.getTextContent(),url);
           sr.add(result);
            }
            
               //Element offers=(Element)offersNode;
             //  Node urlNode =offers.getElementsByTagName("MoreOffersUrl").item(0);
           //Element offer=(Element)nodeOffer;    
              
              System.out.println(i);
          }
          } catch (Exception e) {
           // throw new RuntimeException(e);
        }
        return sr;
    }

   

}
