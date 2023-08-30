package com.google.imna;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.google.common.CommonUtill;
import com.google.domain.AttachFileDTO;

import lombok.extern.log4j.Log4j;
import net.coobird.thumbnailator.Thumbnailator;

@Controller
@Log4j
public class UploadController {
	String uploadFolder = "D:/upload";

	@GetMapping("/uploadForm")
	public void uploadForm() {
		log.info("upload form");
	}
	
	@PostMapping("/uploadFormAction")
	public void uploadFormPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "D:/upload";
		                     
		for(MultipartFile multipartFile : uploadFile) {
			log.info("upload file name : " + multipartFile.getOriginalFilename());
			log.info("upload file size : " + multipartFile.getSize());
			log.info("upload file tagname : " + multipartFile.getName());
			log.info("upload file isEmpty : " + multipartFile.isEmpty());
			//log.info("upload file getBytes : " + multipartFile.getBytes());
			log.info("upload file transterTo(File file) : ");
			
			
			File saveFile = new File(uploadFolder, multipartFile.getOriginalFilename());
			try {
				multipartFile.transferTo(saveFile);
			} catch (IllegalStateException e) {				
			} catch (IOException e) {				
				e.printStackTrace();
			}
		}
	}
	@GetMapping("/uploadAjax")
	public void uploadAjax() {
		log.info("upload ajax");
	}
	
	@PostMapping(value = "/uploadAjaxAction", produces=MediaType.APPLICATION_JSON_UTF8_VALUE)
	@ResponseBody
	public ResponseEntity<List<AttachFileDTO>> uploadAjaxPost(MultipartFile[] uploadFile, Model model) {
		String uploadFolder = "D:/upload";
		                     //D:\\upload
		
		File uploadPath = new File(uploadFolder, CommonUtill.getFolder());
		
		if(uploadPath.exists() == false) {
			uploadPath.mkdirs();
		}
		String uploadFileName = "";
		
		List<AttachFileDTO> list = new ArrayList<>();
		
		for(MultipartFile multipartFile : uploadFile) {
			
			AttachFileDTO attachDTO = new AttachFileDTO();
			
			UUID uuid = UUID.randomUUID();
			uploadFileName = uuid.toString() + "_" +multipartFile.getOriginalFilename() ;
			
			
			File saveFile = new File(uploadPath, uploadFileName);
			
			attachDTO.setFileName(multipartFile.getOriginalFilename());
			attachDTO.setUuid(uuid.toString());
			attachDTO.setUploadpath(CommonUtill.getFolder());
			
			
			try {
				multipartFile.transferTo(saveFile); //파일저장
				
				//썸네일 만들기
				if(CommonUtill.checkImageType(saveFile)) {
					FileOutputStream thumbnail = new FileOutputStream(new File(uploadPath, "s_"+uploadFileName));
					Thumbnailator.createThumbnail(multipartFile.getInputStream(),thumbnail,100,100);
					thumbnail.close();
					
					attachDTO.setImage(true);
				}
				
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			list.add(attachDTO);
		}
		return new ResponseEntity<>(list,HttpStatus.OK);
	}
	
	@GetMapping("/display")
	@ResponseBody
	public ResponseEntity<byte[]> getFile(String fileName){
		File file = new File("D:/upload/" + fileName);
		ResponseEntity<byte[]> result = null;
		
		HttpHeaders header = new HttpHeaders();
		
		try {
			header.add("Content-Type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<byte[]>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return result;
	}
	@GetMapping(value= "/download", produces = MediaType.APPLICATION_OCTET_STREAM_VALUE)
	@ResponseBody
	public ResponseEntity<Resource> downloadFiles(String fileName){
		
		Resource resource = new FileSystemResource("d:/upload/" + fileName);
		
		String resourceName = resource.getFilename();
		
		HttpHeaders header = new HttpHeaders();
		
		try {
			header.add("Content-Disposition", "attachment; filename="
							+ new String(resourceName.getBytes("UTF-8"), "ISO-8859-1"));
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		return new ResponseEntity<Resource>(resource,header,HttpStatus.OK);
		
	}
	@PostMapping("/deleteFile")
	@ResponseBody
	public ResponseEntity<String> deleteFile(String fileRealName, String fileName, String type){
		try {
			File file = new File("D:/upload/" + URLDecoder.decode(fileRealName, "UTF-8"));
			
			file.delete();
			
			if("image".equals(type)) {
				
				file =  new File("D:/upload/" + URLDecoder.decode(fileName, "UTF-8"));
				file.delete();
			}
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return new ResponseEntity<String>("deleted",HttpStatus.OK);
	}

	
	
}