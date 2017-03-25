package me.paul.yiblog_ssm.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.Iterator;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

@Controller
public class FileController {
	
	@Autowired
	private CommonsMultipartResolver multipartResolver;
	
	private String uploadPath;
	
	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}
	
	private String imagePath;
	
	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	@RequestMapping(path = "/upload", method = RequestMethod.GET)
	public String upload() {
		return "upload";
	}

	@RequestMapping(path = "/submitUpload", method = RequestMethod.POST)
	public String submitUpload(HttpServletRequest request,
			HttpServletResponse response,@RequestParam("type") String type)
			throws IllegalStateException, IOException {
		String path = uploadPath + type + File.separator;
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			Iterator<String> iter = multipartRequest.getFileNames();
			while (iter.hasNext()) {
				MultipartFile file = multipartRequest.getFile(iter.next());
				String filepath = file.getOriginalFilename();
				if (file != null) {
					path = path + filepath;
					File localFile = new File(path);
					file.transferTo(localFile);
				}
			}
		}
		request.setAttribute("message", "上传成功");
		return "message";
	}
	
	@RequestMapping(path="/uploadImg",method=RequestMethod.POST)
	public void uploadImg(HttpServletRequest request,HttpServletResponse response) throws IllegalStateException, IOException{
		String path = uploadPath + "image" + File.separator;
		if (multipartResolver.isMultipart(request)) {
			MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
			Iterator<String> iter = multipartRequest.getFileNames();
			String filepath = null;
			while (iter.hasNext()) {
				MultipartFile file = multipartRequest.getFile(iter.next());
				filepath = file.getOriginalFilename();
				if (file != null) {
					path = path + filepath;
					File localFile = new File(path);
					file.transferTo(localFile);
				}
			}
			String imgUrl = request.getContextPath() + "/retriveImg?img=" + filepath; 
			response.getWriter().write(imgUrl);
		}
	}
	
	@RequestMapping(path = "/download", method = RequestMethod.GET)
	public String download(@RequestParam("filename") String filename,
			HttpServletRequest request, HttpServletResponse response) {
		response.setCharacterEncoding("utf-8");
		response.setContentType("multipart/form-data");
		response.setHeader("Content-Disposition", "attachment;fileName="+filename);
		
		try{
			String path = uploadPath + "/file/";
			File file = new File(path,filename);
			InputStream inputStream = new FileInputStream(file);
			
			OutputStream os = response.getOutputStream();
			
			byte[] b = new byte[2048];
			int length = 0;
			while((length = inputStream.read(b)) > 0){
				os.write(b, 0, length);
			}
			os.close();
			inputStream.close();
		}catch(IOException e){
			e.printStackTrace();
		}
		return null;
	}
	
	@RequestMapping(path="/CKFinderJava/userfiles/images/{imagename:[a-zA-Z0-9_\\.]+}",method=RequestMethod.GET)
	public void image(@PathVariable("imagename") String imagename,OutputStream output) throws IOException{
		imagename = imagePath + imagename;
		File image = new File(imagename);
		InputStream input = null;
		if(image.exists()){
			input = new FileInputStream(image);
			byte[] buf = new byte[4096];
			int len = 0;
			while((len = input.read(buf)) > 0){
				output.write(buf, 0, len);
			}
		}else{
			output.write("image not exists".getBytes());
		}
		if(input != null ) {input.close();}
	}
	
	@RequestMapping(path="/retriveImg",method=RequestMethod.GET)
	public void newImage(@RequestParam("img") String img,OutputStream output) throws IOException{
		img = imagePath + img;
		File image = new File(img);
		InputStream input = null;
		if(image.exists()){
			input = new FileInputStream(image);
			byte[] buf = new byte[4096];
			int len = 0;
			while((len = input.read(buf)) > 0){
				output.write(buf, 0, len);
			}
		}else{
			output.write("image not exists".getBytes());
		}
		if(input != null ) {input.close();}
	}
	
	@RequestMapping(path="/logo/{logoname:[a-zA-Z_\\.]+}",method=RequestMethod.GET)
	public void logo(@PathVariable("logoname")String logoname,OutputStream output) throws IOException{
		String path = uploadPath + "logo" + File.separator + logoname;
		File image = new File(path);
		InputStream input = null;
		if(image.exists()){
			input = new FileInputStream(image);
			byte[] buf = new byte[4096];
			int len = 0;
			while((len = input.read(buf)) > 0){
				output.write(buf, 0, len);
			}
		}else{
			output.write("logo not exists".getBytes());
		}
		if(input != null ) {input.close();}
	}
}
