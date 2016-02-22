/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


/**
 *
 * @author ayoub
 */
import java.io.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.*;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.*;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import javax.servlet.*;
import javax.servlet.http.*;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

public class UploadImage extends HttpServlet{
        @Override
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
if(null == session.getAttribute("idsupp")){
        response.sendRedirect("public/pages/supplier/login_soft.jsp");
    }	
            PrintWriter out = response.getWriter();
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		System.out.println("request: "+request);
		if (!isMultipart) {
			System.out.println("File Not Uploaded");
		} else {
		System.out.println("File  Uploaded");	
                    FileItemFactory factory = new DiskFileItemFactory();
			ServletFileUpload upload = new ServletFileUpload(factory);
			List items = null;
try{ Class.forName("org.apache.derby.jdbc.ClientDriver").newInstance();
         Connection cnx=DriverManager.getConnection("jdbc:derby://localhost:1527/pcdb","pcdbun","pcdbpw");
   	
			try {
			   
                            items = upload.parseRequest(request);
				System.out.println("items: "+items);
			} catch (Exception e) {
				e.printStackTrace();
                                //System.out.println(e);
			}
			Iterator itr = items.iterator();
			while (itr.hasNext()) {
				FileItem item = (FileItem) itr.next();
				if (item.isFormField()){
					String name = item.getFieldName();
					System.out.println("name: "+name);
					String value = item.getString();
					System.out.println("value: "+value);
				} else {
					try {
					/*
                                            *note to self:
                                            *this isn't my code
                                            *i need to understand how he randomly name the files
                                            **
                                            */	
                                            String itemName = item.getName();
						Random generator = new Random();
						int r = Math.abs(generator.nextInt());

						String reg = "[.*]";
						String replacingtext = "";
						System.out.println("Text before replacing is:-" + itemName);
						Pattern pattern = Pattern.compile(reg);
						Matcher matcher = pattern.matcher(itemName);
						StringBuffer buffer = new StringBuffer();

						while (matcher.find()) {
							matcher.appendReplacement(buffer, replacingtext);
						}
						int IndexOf = itemName.indexOf("."); 
						String domainName = itemName.substring(IndexOf);
						System.out.println("domainName: "+domainName);

						String finalimage = buffer.toString()+"_"+r+domainName;
						System.out.println("Final Image==="+finalimage);

						File savedFile = new File("/home/ayoub/NetBeansProjects/pricomp/web/images/"+finalimage);
						item.write(savedFile);
                                                
                                            try ( //print elements from excel file
                                                    FileInputStream file = new FileInputStream(new File("/home/ayoub/NetBeansProjects/pricomp/web/images/"+finalimage))
                                            //Get the workbook instance for XLS file
                                            ) {                                             
                                                XSSFWorkbook workbook;
                                                    workbook = new XSSFWorkbook (file);
 
                                                //Get first sheet from the workbook
                                                XSSFSheet sheet = workbook.getSheetAt(0);

                                                //Get iterator to all the rows in current sheet
                                                Iterator<Row> rowIterator = sheet.iterator();
                                                Row firstRow = rowIterator.next();
       //          int idprod=4;
                                                //get the number of lines in table first
                                                String sql="SELECT COUNT(*) AS number FROM PRODUCTS" ;


                                                        //out.println();
                                                       Statement stat=cnx.createStatement();

                                                ResultSet rs=stat.executeQuery(sql);
                                                    rs.next();
                                                   int idprod=Integer.parseInt(rs.getString("number"));
//System.out.println(idprod);

                                                while(rowIterator.hasNext()) {
                                                    idprod++;
                                                    Row row = rowIterator.next();
                                                    
                                                    //For each row, iterate through each columns
                                                    Iterator<Cell> cellIterator = row.cellIterator();
                                                     
                                              
                                                    Cell cell = cellIterator.next();
                                                    String name=cell.getStringCellValue();
                                                    cell = cellIterator.next();
                                                    float price=(float) cell.getNumericCellValue();
   
                                                        
                                                    String insertTableSQL = "INSERT INTO products VALUES (?,?,?,?)";
                                                    //String sql="insert into SUPPLIERS  values("+request.getParameter("name")+","+request.getParameter("adresse")+","+request.getParameter("email")+","+request.getParameter("password")+","+tel+")";
                                                    PreparedStatement pst = cnx.prepareStatement(insertTableSQL);
                                                    //int num=Integer.parseInt(request.getParameter("numero"));
                                                    
                                                    
                                                      int idsupp=Integer.parseInt(session.getAttribute("idsupp").toString());
                                                    //pst.setInt(1,idprod);
                                                     //pst.setString(1, );
                                                        pst.setInt(1,idprod);
                                                        pst.setString(2,name);
                                                        pst.setFloat(3,price);
                                                        pst.setInt(4,idsupp);
                                                   int rset = pst.executeUpdate();
                                                    
                                                    //System.out.println("");
   
                                                }        
                                            }
					
       /*
           Statement stat=cnx.createStatement();
        
  String sqll="insert into suppliers (adressesupp,nomsupp) values('11','hatim')";
          int rss=stat.executeUpdate(sqll);*/
//name=&adresse=&telephone=&password=&email=&description=
        //String telephone=request.getParameter("telephone");
        //int tel=Integer.parseInt(telephone);
                                       
          // int rs=stat.executeUpdate("insert into suppliers (nomsupp,adressesup,emailsupp) values ('z','g','g')");
       // int rs=stat.executeUpdate(sql);
      	
                                            response.sendRedirect("public/pages/supplier/homeSupplier.html");
						

						} catch (Exception e) {
						e.printStackTrace();
					}
				} 
          }
			}catch(Exception e){
          out.println(e);}

		}
	}
}