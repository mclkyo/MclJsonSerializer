//
//  JsonSerializer.h
//  shopproject
//
//  Created by yilecity on 14/12/25.
//  Copyright (c) 2014年 yilecity. All rights reserved.
//

#import "CLJsonObjectValueSet.h"

@interface CLJsonSerializer : NSObject

-(NSString*)GetJson:(id)theObject;
-(NSString*)GetJsonWithIgnoreProerty:(id)theObject IgnoreProperty:(NSArray*)ignoreProperty;

@end
