//
//  RHWCDBManager.m
//  WCDB-example
//
//  Created by zero on 2017/8/23.
//  Copyright © 2017年 zero. All rights reserved.
//

#import "RHWCDBManager.h"
#import "ZZFileManager.h"

NSString *const defaultPath = @"/DB/WC.db";

static RHWCDBManager *instance = nil;

@interface RHWCDBManager ()

@property(nonatomic, strong)WCTDatabase *database;

@end

@implementation RHWCDBManager

+ (instancetype)share{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[RHWCDBManager alloc] init];
        [instance cerateDB];
    });
    return instance;
}

- (void)checkDatabaseResult:(CheckDBResult)result{
    if (!self.database) {
        [self cerateDB];
        result();
    }
}

- (void)killDB{
    [self checkDatabaseResult:^{
        [self.database close];
    }];
}

- (void)cerateDB{
    self.database = [[WCTDatabase alloc] initWithPath:[self defaultPath]];
}

- (NSString *)defaultPath{
    return [[[ZZFileManager share] filePathWithType:ZZFilePathDocument] stringByAppendingString:defaultPath];
}

- (BOOL)rh_createDBwithTable:(NSString *)table elementClass:(Class)cls{
    if ([self.database isTableExists:table]) {
        return YES;
    }else{
        return [self.database createTableAndIndexesOfName:table withClass:cls];;
    }
}

- (BOOL)rh_insertObject:(id)obj table:(NSString *)table{
    return [self.database insertObject:obj into:table];
}

- (BOOL)rh_insertObjects:(NSMutableArray *)objects table:(NSString *)table{
    return [self.database insertObjects:objects into:table];
}
- (BOOL)insertOrReplaceObject:(id)obj table:(NSString *)table{
    return [self.database insertOrReplaceObject:obj into:table];
}
- (BOOL)insertOrReplaceObjects:(NSMutableArray *)objects table:(NSString *)table{
    return [self.database insertOrReplaceObjects:objects into:table];
}

- (BOOL)rh_deleteObjectsFormTable:(NSString *)table where:(const WCTCondition &)condition{
    return  [self.database deleteObjectsFromTable:table where:condition];
}

- (BOOL)rh_deleteAllObjectsFormTable:(NSString *)table{
    return [self.database deleteAllObjectsFromTable:table];
}


- (BOOL)rh_updateAllRowsInTable:(NSString *)table onProperties:(const WCTPropertyList &)propertyList withObject:(WCTObject *)object{
    return [self.database updateAllRowsInTable:table onProperties:propertyList withObject:object];
}
- (BOOL)rh_updateAllRowsInTable:(NSString *)table onProperty:(const WCTProperty &)property withObject:(WCTObject *)object{
    return [self.database updateAllRowsInTable:table onProperty:property withObject:object];
}
- (BOOL)rh_updateRowsInTable:(NSString *)table onProperty:(const WCTProperty &)property withObject:(WCTObject *)object where:(const WCTCondition &)condition{
    return  [self.database updateRowsInTable:table
                                onProperties:property
                                  withObject:object
                                       where:condition];
}

- (NSArray *)rh_getObjectsOfClass:(id)obj fromTable:(NSString *)table orderBy:(const WCTOrderByList &)orderList{
    return [self.database getObjectsOfClass:obj
                                  fromTable:table
                                    orderBy:orderList];
}


@end
