package com.apache.repository;

import com.apache.model.WantedmanEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by shy on 2016/1/2.
 */

@Repository // 添加注解
public interface WantedmanRepository extends JpaRepository<WantedmanEntity,Integer>{
//    findAll()：查找表中所有记录；
//
//    findOne(Integer id)：按id来查找某一条记录；
//
//    findByXXX(Object xxx)：在这里XXX是一个字段名，根据该字段的值开查找所有记录；
//
//    save()和delete()：添加一条记录以及删除一条记录。
    WantedmanEntity findById(String string);

    List<WantedmanEntity> findByNameLike(String name);
    List<WantedmanEntity> findByHighLessThanAndHighGreaterThanAndWeightLessThanAndWeightGreaterThan(Double maxh,Double minh,Double maxw,Double minw);
//    void deleteById(String id);
}
