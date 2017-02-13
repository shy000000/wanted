package com.apache.repository;

import com.apache.model.CluesEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 * Created by shy on 2016/1/2.
 */
@Repository // 添加注解
public interface CluesRepository extends JpaRepository<CluesEntity,Integer>{
    //    findAll()：查找表中所有记录；
//
//    findOne(Integer id)：按id来查找某一条记录；
//
//    findByXXX(Object xxx)：在这里XXX是一个字段名，根据该字段的值开查找所有记录；
//
//    save()和delete()：添加一条记录以及删除一条记录。
}
