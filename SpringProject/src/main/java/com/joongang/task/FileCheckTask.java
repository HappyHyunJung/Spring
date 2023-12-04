package com.joongang.task;

import java.io.File;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.time.DayOfWeek;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.joongang.domain.BoardAttachVO;
import com.joongang.mapper.BoardAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j2;

@Log4j2
@Component  // @Component is a class level annotation
public class FileCheckTask {
	@Setter (onMethod_ = @Autowired)
	private BoardAttachMapper attachMapper;
	
	@Scheduled(cron = "20 13 14 ? * SUN")  // (cron = "0 0 0 ? * SUN")  일요일마다 upload  폴더 파일 삭제하는 코드
	//@Scheduled(fixedRate = 5000)
	public void checkFiles() throws Exception {
		log.info("checkFiles");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String uploadpath = sdf.format(cal.getTime());  // 동작하는 시간을 받아옴
		
		for(int i = 0; i < DayOfWeek.SUNDAY.getValue(); i++) {  // 이전에 동작했던 7일동안의 파일을 의미한다
			cal.add(Calendar.DATE, -1);  // 날짜에서 1일을 뺀다  
			uploadpath = sdf.format(cal.getTime()).replace('-', '\\'); // 저장된 파일이 (2023\\월\\일) 폴더에 저장돼서 '\\'로 바꾼다
			log.info("cal...uploadpath : " + uploadpath);
			List<BoardAttachVO> fileList = attachMapper.getOldFiles(uploadpath);  // 
			
			//files on the tbl_attach - (데이터베이스)tbl_attach 파일 목록을 가져온다 (fileListPaths에 저장된다)
			
			List<Path> fileListPaths = new ArrayList<Path>();
			for (BoardAttachVO vo : fileList) {
				fileListPaths.add(Paths.get("c:\\upload", vo.getUploadpath(), vo.getUuid() + "_" + vo.getFilename()));
				if(vo.isFiletype()) {  // 첨부파일이 이미지파일이라면
					fileListPaths.add(Paths.get("c:\\upload", vo.getUploadpath(), "s_" + vo.getUuid() + "_" + vo.getFilename()));
				}
			}
			log.info("-------------------------------");
			log.info("database files ..... ");
			for (Path path : fileListPaths) {
				log.info(path.toString());
			}
			
			// files on the directory
			log.info("---------------------------------");
			File dir = Paths.get("c:\\upload", uploadpath).toFile();
			if(dir.listFiles() == null) {
				continue;
			}
			for(File file : dir.listFiles()) {
				// 데이터베이스 tbl_attach 테이블이 비어있거나  tbl_attach에 디렉터리 파일을 포함하지 않는다면
				if(fileListPaths.isEmpty() || !fileListPaths.contains(file.toPath())) {
					log.info("this file will be deleted...");
					log.info(file.getAbsolutePath());
					file.delete();
				}
			}
		}
	}
}
