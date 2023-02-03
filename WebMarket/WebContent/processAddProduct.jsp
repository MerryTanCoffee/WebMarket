<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@page import="java.io.File"%>
<%@page import="dto.Product"%>
<%@page import="dao.ProductRepository"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
    	// 경로 D:\A_TeachingMaterial\08_Framework\01.JSP\workspace_jsp\.metadata\.plugins\org.eclipse.wst.server.core\tmp0\wtpwebapps\WebMarket\resources\images
        	request.setCharacterEncoding("UTF-8");

        	String filename = "";
        	String realFolder = request.getServletContext().getRealPath("/resources/images");
        	String encType = "utf-8";
        	
        	int maxSize = 5 * 1024 * 1024;	// 최대 업로드될 파일의 크기(5MB)
        	
        	File file = new File(realFolder);
        	if(!file.exists()){
        		file.mkdirs();
        	}
        	
        	DiskFileUpload upload = new DiskFileUpload();
        	upload.setSizeMax(10 * 1024 * 1024);
        	upload.setSizeThreshold(maxSize);
        	upload.setRepositoryPath(realFolder);
        	
        	List items = upload.parseRequest(request);
        	Iterator params = items.iterator();
        	
        	String productId = "";
        	String name = "";
        	String unitPrice = "";
        	String description = "";
        	String manufacturer = "";
        	String category = "";
        	String unitsInStock = "";
        	String condition = "";
        	String fileName = "";
        	
        	while(params.hasNext()){
        		FileItem item = (FileItem) params.next();
        		if(item.isFormField()){	// 일반 폼 데이터
        	String fieldName = item.getFieldName();	// 파라미터의 이름
        	
        	if(fieldName.equals("productId")){
        		productId = item.getString(encType);
        	}else if(fieldName.equals("name")){
        		name = item.getString(encType);
        	}else if(fieldName.equals("unitPrice")){
        		unitPrice = item.getString(encType);
        	}else if(fieldName.equals("description")){
        		description = item.getString(encType);
        	}else if(fieldName.equals("manufacturer")){
        		manufacturer = item.getString(encType);
        	}else if(fieldName.equals("category")){
        		category = item.getString(encType);
        	}else if(fieldName.equals("unitsInStock")){
        		unitsInStock = item.getString(encType);
        	}else if(fieldName.equals("condition")){
        		condition = item.getString(encType);
        	}
        		}else{					// 파일 데이터
        	String fileFieldName = item.getFieldName();
        	fileName = item.getName();	// 저장 파일의 이름
        	String contentType = item.getContentType();
        	String originalFileName = fileName;
        	long fileSize = item.getSize();
        	File originalFile = new File(originalFileName);
        	File saveFile = new File(realFolder + "/" + fileName);
        	item.write(saveFile);
        		}
        	}

        	int price;
        	if(unitPrice.isEmpty()){
        		price = 0;
        	}else{
        		price = Integer.valueOf(unitPrice);
        	}
        	
        	long stock;
        	if(unitsInStock.isEmpty()){
        		stock = 0;
        	}else{
        		stock = Long.valueOf(unitsInStock);
        	}
        	
        	ProductRepository dao = ProductRepository.getInstance();
        	Product newProduct = new Product();
        	newProduct.setProductId(productId);
        	newProduct.setPname(name);
        	newProduct.setUnitPrice(price);
        	newProduct.setDescription(description);
        	newProduct.setManufacturer(manufacturer);
        	newProduct.setCategory(category);
        	newProduct.setUnitsInStock(stock);
        	newProduct.setCondition(condition);
        	newProduct.setFilename(fileName);
        	
        	dao.addProduct(newProduct);
        	response.sendRedirect("products.jsp");
    %>













