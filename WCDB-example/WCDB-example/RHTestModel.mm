//
//  RHTestModel.m
//  WCDB-example
//
//  Created by zero on 2017/8/23.
//  Copyright © 2017年 zero. All rights reserved.
//

#import "RHTestModel.h"

@implementation RHTestModel

WCDB_IMPLEMENTATION(RHTestModel)
WCDB_SYNTHESIZE(RHTestModel, localID)
WCDB_SYNTHESIZE(RHTestModel, name)
WCDB_SYNTHESIZE(RHTestModel, age)
WCDB_SYNTHESIZE(RHTestModel, createTime)
WCDB_SYNTHESIZE(RHTestModel, address)
WCDB_SYNTHESIZE(RHTestModel, hobis)

WCDB_PRIMARY(RHTestModel, localID)

WCDB_INDEX(RHTestModel, "_index", createTime)

@end
