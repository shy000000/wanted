package com.apache.controller;

import com.apache.MD5Util;
import com.apache.Page;
import com.apache.model.CluesEntity;
import com.apache.model.UsersEntity;
import com.apache.model.WantedmanEntity;
import com.apache.repository.CluesRepository;
import com.apache.repository.UsersRepository;
import com.apache.repository.WantedmanRepository;
import com.sun.corba.se.impl.orbutil.closure.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by shy on 2016/1/4.
 */
@Controller
public class BackController {
    @Autowired
    private CluesRepository cluesRepository;
    @Autowired
    private UsersRepository usersRepository;
    @Autowired
    private WantedmanRepository wantedmanRepository;

    /**
     * 过滤用get方式访问/back/loggedin的方法
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = "/back/loggedin",method = RequestMethod.GET)
    public String loggdeinByGet(ModelMap modelMap,HttpServletRequest request){
        HttpSession session = request.getSession();
        if(session.getAttribute("user") == null){
            return "back/loggedin";
        }else{
            Object username = session.getAttribute("user");
            modelMap.addAttribute("key",username.toString());
            //判断是否为管理员
            if("admin".equals(username)){
                modelMap.addAttribute("semaphore","3");
            }else{
                modelMap.addAttribute("semaphore","2");
            }
            return "back/backman";
        }
    }
    /**
     * 登陆
     * 查询通缉犯和线索列表并显示
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = "/back/loggedin", method = RequestMethod.POST)
    public String loggdein(ModelMap modelMap,HttpServletRequest request){
        final String ADMIN = "admin";

        String username = request.getParameter("username");
        String passwordTemp = request.getParameter("password");
        String password = passwordTemp;
        if(!username.equals(ADMIN)) {
            password = MD5Util.MD5(passwordTemp);
        }

        UsersEntity usersEntityRes = new UsersEntity();
        try{
            usersEntityRes = usersRepository.findByUsername(username);
        }catch (Exception e){
            System.out.println(e);
        }
        /**
         * 判断是否有此人
         */
        if(null == usersEntityRes){
            modelMap.addAttribute("semaphore","0");//无此人，登录失败
            modelMap.addAttribute("key",username);
            return "back/loggedin";//返回登陆界面
        }else{
            //判断密码是否正确
            if(password.equals(usersEntityRes.getPassword())){
                //正确
                HttpSession session = request.getSession();
                //判断是否为管理员
                if(username.equals(ADMIN)){
                    //是管理员
                    modelMap.addAttribute("semaphore","3");//管理员登陆信号
                    modelMap.addAttribute("key",username);//返回用户名
                    //设置session
                    session.setAttribute("user",username);
                    return "back/backman";
                }else{
                    //非管理员
                    modelMap.addAttribute("semaphore","2");//普通用户登陆信号
                    modelMap.addAttribute("key",username);
                    //session
                    session.setAttribute("user",username);
                    return "back/backman";
                }

            }else{
                //不正确
                modelMap.addAttribute("semaphore","1");//密码错误,登录失败
                modelMap.addAttribute("key",username);//返回用户名

                //返回登陆界面
                return "back/loggedin";
            }
        }
    }
    /**
     * 注销
     * @param request
     * @return
     */
    @RequestMapping(value = "/back/loggedout",method = RequestMethod.GET)
    public String loggedout(HttpServletRequest request){
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        return "back/loggedin";
    }

    /**
     * 注销通缉犯
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/outwanted" ,method = RequestMethod.POST)
    public String outWanted(HttpServletRequest request,ModelMap modelMap){
        String deleteId = request.getParameter("id");
        WantedmanEntity deleteWantedman = new WantedmanEntity();

        try{
            deleteWantedman = wantedmanRepository.findById(deleteId);
        }catch (Exception e){
            System.out.println(e);
        }
        if(null != deleteWantedman){
            wantedmanRepository.delete(deleteWantedman);
            modelMap.addAttribute("delete","success");
        }else{
            modelMap.addAttribute("delete","fail");
        }
        return "back/outWantedRes";

    }

    /**
     * 查询所有线索
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/clue",method = RequestMethod.GET)
    public String getAllclues(HttpServletRequest request,ModelMap modelMap){
        String pageNow = request.getParameter("pageNow");
        List<CluesEntity> cluesEntities = new ArrayList<CluesEntity>();
        List<CluesEntity> cluesEntitiesRes = new ArrayList<CluesEntity>();
        try{
            cluesEntities = cluesRepository.findAll();
        }catch (Exception e){
            System.out.println(e);
        }
        if(cluesEntities.size()==0){
            modelMap.addAttribute("clue","0");
        }else{
            Integer totalCount = cluesEntities.size();
            Page page = null;

            Integer startPos = 0;
            Integer pageSize = 5;
            Integer endPos = 5;
            if(endPos > totalCount) endPos=totalCount;
            if(pageNow != null) {

                page = new Page(totalCount, Integer.parseInt(pageNow));
                startPos = page.getStartPos();
                pageSize = page.getPageSize();
                endPos = startPos+pageSize;
                if(endPos > totalCount) endPos=totalCount;
                if(endPos == startPos){
                    page.setPageNow(Integer.parseInt(pageNow) - 1);
                    startPos = page.getStartPos();
                    pageSize = page.getPageSize();
                    endPos = startPos+pageSize;
                    if(endPos > totalCount) endPos=totalCount;
                }
                for(int i = startPos;i<endPos;i++){
                    cluesEntitiesRes.add(cluesEntities.get(i));
                }
            }else{
                page = new Page(totalCount, 1);
                for(int i = 0;i<endPos;i++){
                    cluesEntitiesRes.add(cluesEntities.get(i));
                }
            }
            modelMap.addAttribute("page",page);
            modelMap.addAttribute("clue",cluesEntitiesRes);
        }
        return "back/clue";
    }

    /**
     * 查看线索详情
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/showClue",method = RequestMethod.GET)
    public String showClue(HttpServletRequest request,ModelMap modelMap){
        String clueId = request.getParameter("clueid");
        CluesEntity cluesEntity = cluesRepository.findOne(Integer.parseInt(clueId));
        modelMap.addAttribute("clue",cluesEntity);
        String pageNow = request.getParameter("pageNow");
        modelMap.addAttribute("pageNow",pageNow);
        return "back/cluedetail";
    }

    /**
     * 删除线索
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/deleteClue",method = RequestMethod.GET)
    public String deleteClue(HttpServletRequest request,ModelMap modelMap){
        String clueId = request.getParameter("clueid");
        cluesRepository.delete(Integer.parseInt(clueId));
        String pageNow = request.getParameter("pageNow");
        modelMap.addAttribute("pageNow",pageNow);
        return "back/deleteClueRes";
    }

    /**
     * 通缉犯列表
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/wanted" ,method = RequestMethod.GET)
    public String wanted(HttpServletRequest request,ModelMap modelMap){
//查询所有通缉犯
        String pageNow = request.getParameter("pageNow");
        List<WantedmanEntity> wantedmanEntityList = new ArrayList<WantedmanEntity>();
        List<WantedmanEntity> wantedmanEntityListRes = new ArrayList<WantedmanEntity>();
        try{
            wantedmanEntityList = wantedmanRepository.findAll();
        }catch (Exception e){
            System.out.println(e);
        }
        if(wantedmanEntityList.size()==0){
            modelMap.addAttribute("wantedman","0");
        }else{
            Integer totalCount = wantedmanEntityList.size();
            Page page = null;

            Integer startPos = 0;
            Integer pageSize = 5;
            Integer endPos = 5;
            if(endPos > totalCount) endPos=totalCount;
            if(pageNow != null) {

                page = new Page(totalCount, Integer.parseInt(pageNow));
                startPos = page.getStartPos();
                pageSize = page.getPageSize();
                endPos = startPos+pageSize;
                if(endPos > totalCount) endPos=totalCount;
                if(endPos == startPos){
                    page.setPageNow(Integer.parseInt(pageNow) - 1);
                    startPos = page.getStartPos();
                    pageSize = page.getPageSize();
                    endPos = startPos+pageSize;
                    if(endPos > totalCount) endPos=totalCount;
                }
                for(int i = startPos;i<endPos;i++){
                    wantedmanEntityListRes.add(wantedmanEntityList.get(i));
                }
            }else{
                page = new Page(totalCount, 1);
                for(int i = 0;i<endPos;i++){
                    wantedmanEntityListRes.add(wantedmanEntityList.get(i));
                }
            }
            modelMap.addAttribute("page",page);
            modelMap.addAttribute("wantedman",wantedmanEntityListRes);
        }
        return"back/wanted";
    }
    /**
     * 通缉犯详情查询
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/showWanted",method = RequestMethod.GET)
    public String showWanted(HttpServletRequest request,ModelMap modelMap){
        String wantedmanId = request.getParameter("wantedid");
        WantedmanEntity wantedmanEntity = wantedmanRepository.findById(wantedmanId);
        String path = wantedmanEntity.getPhoto();
        if(!path.equals("无")){
            String[] array=path.split("\\.");

            String photoPath = "../../images"+"/photo/wanted/"+wantedmanId+"."+array[1];
            wantedmanEntity.setPhoto(photoPath);
        }
        modelMap.addAttribute("wantedman",wantedmanEntity);
        String pageNow = request.getParameter("pageNow");
        modelMap.addAttribute("pageNow",pageNow);

        return "back/wanteddetail";
    }

    /**
     * 删除通缉犯
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/deleteWanted",method = RequestMethod.GET)
    public String deleteWanted(HttpServletRequest request,ModelMap modelMap){
        //删除通缉犯
        String deleteId = request.getParameter("wantedid");
        WantedmanEntity wantedmanEntity = wantedmanRepository.findById(deleteId);
        wantedmanRepository.delete(wantedmanEntity);
        String pageNow = request.getParameter("pageNow");
        modelMap.addAttribute("pageNow",pageNow);
        return "back/deleteWantedRes";
    }

    /**
     * 添加通缉犯跳转
     * @return
     */
    @RequestMapping(value = "/back/addWanted",method = RequestMethod.GET)
    public String addWanted(){
        return "back/addWanted";
    }

    /**
     * 添加通缉犯
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/addWantedPost",method = RequestMethod.POST)
    public String addWantedPost(HttpServletRequest request , ModelMap modelMap){
//        MultipartHttpServletRequest request1 = (MultipartHttpServletRequest)request;
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        Double high = Double.parseDouble(request.getParameter("high"));
        Double weight = Double.parseDouble(request.getParameter("weight"));
        String phone = request.getParameter("phone");
        String feature = request.getParameter("feature");
        Integer rank = 1;
        String photo = null;
        //身份证号码过滤
        if(id.length() != 18){
            modelMap.addAttribute("id",id);
            modelMap.addAttribute("name",name);
            modelMap.addAttribute("gender",gender);
            modelMap.addAttribute("high",high);
            modelMap.addAttribute("weight",weight);
            modelMap.addAttribute("phone",phone);
            modelMap.addAttribute("feature",feature);
            modelMap.addAttribute("idnot","0");
            return "back/addWanted";
        }
        //性别过滤
        if(!gender.equals("男")){
            if(!gender.equals("女")){
                modelMap.addAttribute("id",id);
                modelMap.addAttribute("name",name);
                modelMap.addAttribute("gender",gender);
                modelMap.addAttribute("high",high);
                modelMap.addAttribute("weight",weight);
                modelMap.addAttribute("phone",phone);
                modelMap.addAttribute("feature",feature);
                modelMap.addAttribute("gendernot","0");
                return "back/addWanted";
            }
        }

        WantedmanEntity wantedmanEntity = new WantedmanEntity();
        try {
            wantedmanEntity = wantedmanRepository.findById(id);
        }catch (Exception e){
            System.out.println(e);
        }

        if(null == wantedmanEntity){
            WantedmanEntity add = new WantedmanEntity();
            add.setId(id);
            add.setName(name);
            add.setGender(gender);
            add.setHigh(high);
            add.setWeight(weight);
            add.setPhone(phone);
            add.setFeature(feature);
            add.setRank(rank);

            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest)request;
            //  获得第1张图片（根据前台的name名称得到上传的文件）
            MultipartFile imgFile1  =  multipartRequest.getFile("photo");
            //定义一个数组，用于保存可上传的文件类型
            List fileTypes = new ArrayList();
            fileTypes.add("jpg");
            fileTypes.add("jpeg");
            fileTypes.add("bmp");
            fileTypes.add("gif");
            fileTypes.add("png");
            //保存第一张图片
            if(!(imgFile1.getOriginalFilename() ==null || "".equals(imgFile1.getOriginalFilename()))) {
                String path = "wanted";
                File file1 = this.getFile(imgFile1,path,id,fileTypes);
                photo = file1.getPath();
                add.setPhoto(photo);
                wantedmanRepository.saveAndFlush(add);
                modelMap.addAttribute("haswanted","0");
                return "back/addWantedRes";
            }else {
                photo = "无";
                add.setPhoto(photo);
                wantedmanRepository.saveAndFlush(add);
                modelMap.addAttribute("haswanted","2");
                return "back/addWantedRes";
            }


        }else{
            modelMap.addAttribute("haswanted", "1");
            return "back/addWanted";
        }


    }

    /**
     * 更新通缉犯跳转
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/updateWanted",method = RequestMethod.GET)
    public String updateWanted(HttpServletRequest request,ModelMap modelMap){
        String wantedid = request.getParameter("wantedid");
        WantedmanEntity wantedmanEntity = wantedmanRepository.findById(wantedid);
        String pageNow = request.getParameter("pageNow");
        modelMap.addAttribute("pageNow",pageNow);
        modelMap.addAttribute("id",wantedmanEntity.getId());
        modelMap.addAttribute("name",wantedmanEntity.getName());
        modelMap.addAttribute("gender",wantedmanEntity.getGender());
        modelMap.addAttribute("high",wantedmanEntity.getHigh());
        modelMap.addAttribute("weight",wantedmanEntity.getWeight());
        modelMap.addAttribute("feature",wantedmanEntity.getFeature());
        modelMap.addAttribute("phone",wantedmanEntity.getPhone());
        modelMap.addAttribute("rank",wantedmanEntity.getRank());
        modelMap.addAttribute("photo",wantedmanEntity.getPhoto());
        return "back/updateWanted";

    }

    @RequestMapping(value = "/back/updateWantedPost", method = RequestMethod.POST)
    public String updateWantedPost(HttpServletRequest request,ModelMap modelMap){
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String gender = request.getParameter("gender");
        Double high = Double.parseDouble(request.getParameter("high"));
        Double weight = Double.parseDouble(request.getParameter("weight"));
        String phone = request.getParameter("phone");
        String feature = request.getParameter("feature");
        String photo = request.getParameter("photo");
        Integer rank = 1;
        String pageNow = request.getParameter("pageNow");
        modelMap.addAttribute("pageNow",pageNow);
        //身份证号码过滤
        if(id.length() != 18){
            modelMap.addAttribute("id",id);
            modelMap.addAttribute("name",name);
            modelMap.addAttribute("gender",gender);
            modelMap.addAttribute("high",high);
            modelMap.addAttribute("weight",weight);
            modelMap.addAttribute("phone",phone);
            modelMap.addAttribute("feature",feature);
            modelMap.addAttribute("idnot","0");
            return "back/updateWanted";
        }
        //性别过滤
        if(!gender.equals("男")){
            if(!gender.equals("女")){
                modelMap.addAttribute("id",id);
                modelMap.addAttribute("name",name);
                modelMap.addAttribute("gender",gender);
                modelMap.addAttribute("high",high);
                modelMap.addAttribute("weight",weight);
                modelMap.addAttribute("phone",phone);
                modelMap.addAttribute("feature",feature);
                modelMap.addAttribute("gendernot","0");
                return "back/updateWanted";
            }
        }


        WantedmanEntity wantedmanEntity = new WantedmanEntity();


        wantedmanEntity = wantedmanRepository.findById(id);
        wantedmanEntity.setName(name);
        wantedmanEntity.setGender(gender);
        wantedmanEntity.setHigh(high);
        wantedmanEntity.setWeight(weight);
        wantedmanEntity.setPhone(phone);
        wantedmanEntity.setFeature(feature);

        wantedmanRepository.saveAndFlush(wantedmanEntity);

        return "back/updateWantedRes";
    }





    /**
     * 用户管理
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/userManage",method = RequestMethod.GET)
    public String userManage(HttpServletRequest request,ModelMap modelMap){

        HttpSession session = request.getSession();
        String user = session.getAttribute("user").toString();
        if(!user.equals("admin")){
            modelMap.addAttribute("key",user);
            return "back/backman";
        }


        String pageNow = request.getParameter("pageNow");
        List<UsersEntity> usersEntities = new ArrayList<UsersEntity>();
        List<UsersEntity> UsersEntityRes = new ArrayList<UsersEntity>();
        try{
            usersEntities = usersRepository.findAll();
        }catch (Exception e){
            System.out.println(e);
        }
        if(usersEntities.size()==0){
            modelMap.addAttribute("users","0");
        }else{
            Integer totalCount = usersEntities.size();
            Page page = null;

            Integer startPos = 0;
            Integer pageSize = 5;
            Integer endPos = 5;
            if(endPos > totalCount) endPos=totalCount;
            if(pageNow != null && !"1".equals(pageNow)) {

                page = new Page(totalCount, Integer.parseInt(pageNow));
                startPos = page.getStartPos();
                pageSize = page.getPageSize();
                endPos = startPos+pageSize;
                if(endPos > totalCount) endPos=totalCount;
                if(endPos == startPos){
                    page.setPageNow(Integer.parseInt(pageNow) - 1);
                    startPos = page.getStartPos();
                    pageSize = page.getPageSize();
                    endPos = startPos+pageSize;
                    if(endPos > totalCount) endPos=totalCount;
                }
                for(int i = startPos;i<endPos;i++){
                    UsersEntityRes.add(usersEntities.get(i));
                }
            }else{
                page = new Page(totalCount, 1);
                for(int i = 0;i<endPos;i++){
                    UsersEntityRes.add(usersEntities.get(i));
                }
            }
            modelMap.addAttribute("page",page);
            modelMap.addAttribute("users",UsersEntityRes);
        }

        return "back/usermanage";
    }

    /**
     * 删除用户
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/deleteUser" ,method = RequestMethod.GET)
    public String deleteUser(HttpServletRequest request,ModelMap modelMap){

        HttpSession session = request.getSession();
        String user = session.getAttribute("user").toString();
        if(!user.equals("admin")){
            modelMap.addAttribute("key",user);

            return "back/backman";
        }

        String deleteUserId = request.getParameter("userid");
        String pageNow = request.getParameter("pageNow");
        modelMap.addAttribute("pageNow",pageNow);
        UsersEntity usersEntity = usersRepository.findOne(Integer.parseInt(deleteUserId));
        usersRepository.delete(usersEntity);
        return "back/deleteUserRes";
    }

    /**
     * 修改用户信息跳转
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/updateUser",method = RequestMethod.GET)
    public String updateUser(HttpServletRequest request,ModelMap modelMap){

        HttpSession session = request.getSession();
        String user = session.getAttribute("user").toString();
        if(!user.equals("admin")){
            modelMap.addAttribute("key",user);

            return "back/backman";
        }


        String userId = request.getParameter("userid");
        UsersEntity usersEntity = usersRepository.findOne(Integer.parseInt(userId));
        modelMap.addAttribute("username",usersEntity.getUsername());
        modelMap.addAttribute("password",usersEntity.getPassword());
        modelMap.addAttribute("userid",userId);
        String pageNow = request.getParameter("pageNow");
        modelMap.addAttribute("pageNow",pageNow);
        return "back/updateUser";
    }

    /**
     * 修改用户信息
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/updateUserPost",method = RequestMethod.POST)
    public String updateUserPost(HttpServletRequest request,ModelMap modelMap){
        HttpSession session = request.getSession();
        String user = session.getAttribute("user").toString();
        if(!user.equals("admin")){
            modelMap.addAttribute("key",user);

            return "back/backman";
        }

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UsersEntity test = new UsersEntity();
        try{
            test = usersRepository.findByUsername("username");
        }catch(Exception e){
            System.out.println(e);
        }

        if(null == test){
            String userid = request.getParameter("userid");
            String pageNow = request.getParameter("pageNow");
            modelMap.addAttribute("pageNow",pageNow);
            UsersEntity usersEntity = usersRepository.findOne(Integer.parseInt(userid));
            usersEntity.setUsername(username);
            String temp = MD5Util.MD5(password);
            usersEntity.setPassword(temp);
            usersRepository.saveAndFlush(usersEntity);
            return "back/updateUserRes";
        }else{
            modelMap.addAttribute("hasname","1");
            return "back/updateUser";
        }

    }

    /**
     * 添加新用户跳转
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/addUser",method = RequestMethod.GET)
    public String addUser(HttpServletRequest request,ModelMap modelMap){

        HttpSession session = request.getSession();
        String user = session.getAttribute("user").toString();
        if(!user.equals("admin")){
            modelMap.addAttribute("key",user);

            return "back/backman";
        }

        return"back/addUser";
    }

    /**
     * 添加新用户
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/back/addUserPost",method = RequestMethod.POST)
    public String addUserPost(HttpServletRequest request,ModelMap modelMap){

        HttpSession session = request.getSession();
        String user = session.getAttribute("user").toString();
        if(!user.equals("admin")){
            modelMap.addAttribute("key",user);

            return "back/backman";
        }


        String username = request.getParameter("username");
        String password = request.getParameter("password");
        UsersEntity usersEntity = new UsersEntity();
        try{
            usersEntity = usersRepository.findByUsername(username);
        }catch (Exception e){
            System.out.println(e);
        }
        if(null == usersEntity){
            UsersEntity add = new UsersEntity();
            String temp = MD5Util.MD5(password);
            add.setUsername(username);
            add.setPassword(temp);
            usersRepository.saveAndFlush(add);
            modelMap.addAttribute("hasname","0");
            return "back/addUserRes";
        }else {
            modelMap.addAttribute("hasname","1");
            return "back/addUser";
        }
    }

    /**
     * 文件上传辅助方法
     * @param imgFile 从页面中读取到的文件
     * @param brandName 身份证号
     * @param fileTypes 允许的文件拓展名集合
     * @return
     */
    private File getFile(MultipartFile imgFile,String brandName,String fileName,List fileTypes) {
        String fileName1 = imgFile.getOriginalFilename();
        //获取上传文件类型的扩展名,先得到.的位置，再截取从.的下一个位置到文件的最后，最后得到扩展名
        String ext = fileName1.substring(fileName1.lastIndexOf(".")+1,fileName1.length());
        //对扩展名进行小写转换
        ext = ext.toLowerCase();
        fileName = fileName +"."+ext;
        File file = null;
        if(fileTypes.contains(ext)) {
            //如果扩展名属于允许上传的类型，则创建文件
            file = this.creatFolder( brandName, fileName);
            try {
                imgFile.transferTo(file);                   //保存上传的文件
            }catch (IllegalStateException e){
                e.printStackTrace();
            }catch (IOException e){
                e.printStackTrace();
            }
        }
        return file;
    }

    private File creatFolder(String brandName,String fileName) {
        File file = null;
        brandName = brandName.replaceAll("/", "");             //去掉"/"
        brandName = brandName.replaceAll(" ", "");             //替换半角空格
        brandName = brandName.replaceAll(" ", "");             //替换全角空格

        File firstFolder = new File("e:/" + "web/wanted/src/main/webapp/WEB-INF/images/photo");
        File firstFolder1 = new File("E:/web/wanted/target/springMVC/WEB-INF/images/photo");

        File secondFolder1 = new File(firstFolder1,brandName);
        File secondFolder = new File(firstFolder,brandName);
        if(secondFolder.exists()) {                        //如果二级文件夹也存在，则创建件
            file = new File(secondFolder,fileName);
        }else {                                           //如果二级文件夹不存在，则创建二级文件夹
            secondFolder.mkdir();
            file = new File(secondFolder,fileName);        //创建完二级文件夹后，再合建文件
        }
        if(secondFolder1.exists()) {                        //如果二级文件夹也存在，则创建件
            file = new File(secondFolder1,fileName);
        }else {                                           //如果二级文件夹不存在，则创建二级文件夹
            secondFolder1.mkdir();
            file = new File(secondFolder1,fileName);        //创建完二级文件夹后，再合建文件
        }

        return file;
    }
}
