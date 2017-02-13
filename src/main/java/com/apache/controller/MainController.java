package com.apache.controller;

/**
 * Created by shy on 2016/1/2.
 */

import com.apache.Page;
import com.apache.model.CluesEntity;
import com.apache.model.WantedmanEntity;
import com.apache.repository.CluesRepository;
import com.apache.repository.UsersRepository;
import com.apache.repository.WantedmanRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
public class MainController {
    @Autowired
    private CluesRepository cluesRepository;
    @Autowired
    private UsersRepository usersRepository;
    @Autowired
    private WantedmanRepository wantedmanRepository;

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String index() {
        return "index";
    }

    /**
     * 举报
     * @param cluesEntity
     * @return
     */
    @RequestMapping(value = "/report", method = RequestMethod.POST)
    public String report(@ModelAttribute("clue") CluesEntity cluesEntity){

        cluesRepository.saveAndFlush(cluesEntity);

        return "index";
    }
    @RequestMapping(value = "/report", method = RequestMethod.GET)
    public String reportByGet(){
        return "index";
    }

    /**
     * 精确查找跳转
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/researchById")
    public String jumpToResearchById(ModelMap modelMap){
        modelMap.addAttribute("wantedman",null);
        return "researchById";
    }

    /**
     * 姓名查找跳转
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/researchByName")
    public String jumpToResearchByName(ModelMap modelMap){
        modelMap.addAttribute("wantedman",null);
        return "researchByName";
    }

    /**
     * 范围查找跳转
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/researchByRange")
    public String jumpToResearchByRange(ModelMap modelMap){
        modelMap.addAttribute("wantedman",null);
        return "researchByRange";
    }

    /**
     * 精确查找
     * @param id
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/reById",method = RequestMethod.POST)
    public String reById(@ModelAttribute("id") WantedmanEntity id,ModelMap modelMap){
        WantedmanEntity wantedmanEntityRes = new WantedmanEntity();
        //搜索，返回结果集
        try {
            wantedmanEntityRes = wantedmanRepository.findById(id.getName());
        }catch (Exception e){
            System.out.println(e);
        }
        if(null == wantedmanEntityRes){
            modelMap.addAttribute("wantedman","0");
            modelMap.addAttribute("key",id.getName());
        }else {
            String path = wantedmanEntityRes.getPhoto();
            if(!path.equals("无")){
                String[] array=path.split("\\.");

                String photoPath = "../images"+"/photo/wanted/"+id.getName()+"."+array[1];
                wantedmanEntityRes.setPhoto(photoPath);
            }
            modelMap.addAttribute("wantedman",wantedmanEntityRes);
            modelMap.addAttribute("key",id.getName());
        }

        return "researchById";
    }

    @RequestMapping(value = "/reById",method = RequestMethod.GET)
    public String reByIdByGet(){

        return "researchById";
    }

    /**
     * 姓名查找分页
     * @param name
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = "/reByName",method = RequestMethod.GET)
    public String reByName(@ModelAttribute("name") WantedmanEntity name,ModelMap modelMap,HttpServletRequest request){
        String pageNow = request.getParameter("pageNow");
        String pageName = request.getParameter("name");
        List<WantedmanEntity> wantedmanEntityList = new ArrayList<WantedmanEntity>();
        List<WantedmanEntity> wantedmanEntityListRes = new ArrayList<WantedmanEntity>();

        try{
            wantedmanEntityList = wantedmanRepository.findByNameLike("%"+name.getName()+"%");
        }catch (Exception e){
            System.out.println(e);
        }
        if(wantedmanEntityList.size()==0){
            modelMap.addAttribute("wantedman","0");
            modelMap.addAttribute("key",name.getName());
        }else{
            Integer totalCount = wantedmanEntityList.size();
            Page page = null;
            modelMap.addAttribute("key",name.getName());
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
                for(int i = startPos;i<endPos;i++){
                    wantedmanEntityListRes.add(wantedmanEntityList.get(i));
                }

            }else{
                for(int i = startPos;i<endPos;i++){
                    wantedmanEntityListRes.add(wantedmanEntityList.get(i));
                }
                page = new Page(totalCount, 1);
            }
            modelMap.addAttribute("page",page);
            modelMap.addAttribute("wantedman",wantedmanEntityListRes);
        }
        return "researchByName";
    }


    /**
     * 范围查找分页
     * @param modelMap
     * @param request
     * @return
     */
    @RequestMapping(value = "/reByRange",method = RequestMethod.GET)
    public String reByRange(ModelMap modelMap,HttpServletRequest request){
        List<WantedmanEntity> wantedmanEntityList = new ArrayList<WantedmanEntity>();
        List<WantedmanEntity> wantedmanEntityListRes = new ArrayList<WantedmanEntity>();
        String pageNow = request.getParameter("pageNow");
        String maxHeight = request.getParameter("maxheight");
        if(maxHeight == ""){maxHeight = "1000";}
        String minHeight = request.getParameter("minheight");
        if(minHeight == ""){minHeight = "0";}
        String maxWeight = request.getParameter("maxweight");
        if(maxWeight == ""){maxWeight = "1000";}
        String minWeight = request.getParameter("minweight");
        if(minWeight == ""){minWeight = "0";}

        Double maxh,minh,maxw,minw;
        maxh = Double.parseDouble(maxHeight);
        minh = Double.parseDouble(minHeight);
        maxw = Double.parseDouble(maxWeight);
        minw = Double.parseDouble(minWeight);
        try{
            wantedmanEntityList = wantedmanRepository.findByHighLessThanAndHighGreaterThanAndWeightLessThanAndWeightGreaterThan(maxh,minh,maxw,minw);
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
                for(int i = startPos;i<endPos;i++){
                    wantedmanEntityListRes.add(wantedmanEntityList.get(i));
                }

            }else{
                for(int i = startPos;i<endPos;i++){
                    wantedmanEntityListRes.add(wantedmanEntityList.get(i));
                }
                page = new Page(totalCount, 1);
            }
            modelMap.addAttribute("page",page);
            modelMap.addAttribute("wantedman",wantedmanEntityListRes);

        }
        modelMap.addAttribute("key1",request.getParameter("maxheight"));
        modelMap.addAttribute("key2",request.getParameter("minheight"));
        modelMap.addAttribute("key3",request.getParameter("maxweight"));
        modelMap.addAttribute("key4",request.getParameter("minweight"));
        return "researchByRange";
    }

    /**
     * 跳转到登陆界面
     * @return
     */
    @RequestMapping(value = "/loggedin")
    public String loggedin(){
        return "back/loggedin";
    }


    @RequestMapping(value = "/showWanted",method = RequestMethod.GET)
    public String showWanted(HttpServletRequest request,ModelMap modelMap){
        modelMap.clear();
        String returnNum = request.getParameter("return");
        String wantedmanId = request.getParameter("wantedid");
        WantedmanEntity wantedmanEntity = wantedmanRepository.findById(wantedmanId);
        String path = wantedmanEntity.getPhoto();
        if(!path.equals("无")){
            String[] array=path.split("\\.");

            String photoPath = "../../images"+"/photo/wanted/"+wantedmanId+"."+array[1];
            wantedmanEntity.setPhoto(photoPath);
        }
        modelMap.addAttribute("wantedman",wantedmanEntity);

        if("1".equals(returnNum)){
            modelMap.addAttribute("wantedname",wantedmanEntity.getName());
            return "wanteddetail";
        }else{
            modelMap.addAttribute("key1",request.getParameter("maxheight"));
            modelMap.addAttribute("key2",request.getParameter("minheight"));
            modelMap.addAttribute("key3",request.getParameter("maxweight"));
            modelMap.addAttribute("key4",request.getParameter("minweight"));
            return "wanteddetail2";
        }



    }

}