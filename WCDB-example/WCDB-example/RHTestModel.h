//
//  RHTestModel.h
//  WCDB-example
//
//  Created by zero on 2017/8/23.
//  Copyright © 2017年 zero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WCDB.h>

@interface RHTestModel : NSObject<WCTTableCoding>
@property int localID;
@property(retain) NSString *name; //
@property(assign) int age; //
@property(retain) NSDate *createTime;
@property(retain) NSString *address; //
@property(retain) NSString *hobis; //

WCDB_PROPERTY(localID)
WCDB_PROPERTY(name)
WCDB_PROPERTY(age)
WCDB_PROPERTY(createTime)
WCDB_PROPERTY(address)
WCDB_PROPERTY(hobis)

@end
