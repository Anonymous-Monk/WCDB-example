//
//  RHWCDBManager.h
//  WCDB-example
//
//  Created by zero on 2017/8/23.
//  Copyright © 2017年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

typedef void(^CheckDBResult)();


@interface RHWCDBManager : NSObject

+ (instancetype)share;

- (void)killDB;

/**
 创建表

 @param table 表名称
 @param cls 表类
 @return BOOL值，true创建成功
 */


- (BOOL)rh_createDBwithTable:(NSString *)table elementClass:(Class)cls;

/**
 向表中插入对象

 @param obj 对象
 @param table 表名称
 @return BOOL值，true添加成功
 */
- (BOOL)rh_insertObject:(id)obj table:(NSString *)table;

/**
 向表中插入多条数据

 @param objects 对象
 @param table 表明
 @return BOOL值，true添加成功
 */
- (BOOL)rh_insertObjects:(NSMutableArray *)objects table:(NSString *)table;
//插入单个或多个对象。当对象的主键在数据库内已经存在时，更新数据；否则插入对象。
- (BOOL)insertOrReplaceObject:(id)obj table:(NSString *)table;
- (BOOL)insertOrReplaceObjects:(NSMutableArray *)objects table:(NSString *)table;


/**
 从表中删除数据

 @param table 表名称
 @param condition (可接where、orderBy、limit、offset)
 @return BOOL值，true删除成功
 */
- (BOOL)rh_deleteObjectsFormTable:(NSString *)table where:(const WCTCondition &)condition;

/**
 删除表中所有数据

 @param table 表明
 @return BOOL值，true删除成功
 */
- (BOOL)rh_deleteAllObjectsFormTable:(NSString *)table;


/**
 更新表中的一条数据

 @param table 表名称
 @param property 修改的属性
 @param object 修改的对象
 @param condition 条件
 @return BOOL值，true修改成功
 */
//// 后可组合接 where、orderBy、limit、offset以通过object更新某一列的部分数据
- (BOOL)rh_updateRowsInTable:(NSString *)table onProperty:(const WCTProperty &)property withObject:(WCTObject *)object where:(const WCTCondition &)condition;
// 通过object更新数据库中所有指定列的数
- (BOOL)rh_updateAllRowsInTable:(NSString *)table onProperties:(const WCTPropertyList &)propertyList withObject:(WCTObject *)object;
// 通过object更新数据库某一列的数据
- (BOOL)rh_updateAllRowsInTable:(NSString *)table onProperty:(const WCTProperty &)property withObject:(WCTObject *)object;
/**
 查询某个表

 @param obj 类名
 @param table 表名称
 @param orderList orderList
 @return 获取的数据数组
 */
- (NSArray *)rh_getObjectsOfClass:(id)obj fromTable:(NSString *)table orderBy:(const WCTOrderByList &)orderList;
@end
