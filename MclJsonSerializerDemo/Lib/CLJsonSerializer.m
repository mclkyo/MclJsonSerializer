//
//  JsonSerializer.m
//  shopproject
//
//  Created by yilecity on 14/12/25.
//  Copyright (c) 2014年 yilecity. All rights reserved.
//

#import "CLJsonSerializer.h"
#import "NSObject+IgnoreProperty.h"
#import <objc/runtime.h>

NSString *const OCTypeInt = @"i";
NSString *const OCTypeFloat = @"f";
NSString *const OCTypeDouble = @"d";
NSString *const OCTypeLong = @"q";
NSString *const OCTypeLongLong = @"q";
NSString *const OCTypeChar = @"c";
NSString *const OCTypeBOOL = @"c";
NSString *const OCTypePointer = @"*";


@implementation CLJsonSerializer

-(NSString*)GetJson:(id)theObject{
    
    NSObject *JsonObject = nil;
    
    if ([theObject isKindOfClass:[NSArray class]]){
        NSArray *arr = (NSArray*)theObject;
        NSMutableArray *list = [[NSMutableArray alloc]init];
        for (int i=0; i<arr.count; i++) {

            [list addObject:[self serializeObject:arr[i] IgnoreProperty:[self GetIgnorePropertyList:arr[i]]]];
            
        }
        JsonObject = list;
        
    }
    else if ([theObject isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary*)theObject;
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc]init];
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [newDict setObject:[self serializeObject:obj IgnoreProperty:[self GetIgnorePropertyList:theObject]] forKey:key];
        }];
        JsonObject = newDict;
    }
    else{
        NSMutableDictionary *jsonDict = [self serializeObject:theObject IgnoreProperty:[self GetIgnorePropertyList:theObject]];
        JsonObject = jsonDict;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:JsonObject options:0 error:&error];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
}


-(NSString*)GetJsonWithIgnoreProerty:(id)theObject IgnoreProperty:(NSArray *)ignoreProperty{
    
    NSMutableArray *lstIgnoreProperty = [NSMutableArray arrayWithArray:ignoreProperty];
    
    NSObject *JsonObject = nil;
    if ([theObject isKindOfClass:[NSArray class]]){
        NSArray *arr = (NSArray*)theObject;
        NSMutableArray *list = [[NSMutableArray alloc]init];
        for (int i=0; i<arr.count; i++) {
            
            [list addObject:[self serializeObject:arr[i] IgnoreProperty:lstIgnoreProperty]];
            
        }
        JsonObject = list;
    }
    else if ([theObject isKindOfClass:[NSDictionary class]]){
        NSDictionary *dict = (NSDictionary*)theObject;
        NSMutableDictionary *newDict = [[NSMutableDictionary alloc]init];
        [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            [newDict setObject:[self serializeObject:obj IgnoreProperty:lstIgnoreProperty] forKey:key];
        }];
        JsonObject = newDict;
    }
    else{
        NSMutableDictionary *jsonDict = [self serializeObject:theObject IgnoreProperty:lstIgnoreProperty];
        JsonObject = jsonDict;
    }
    
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:JsonObject options:0 error:&error];
    return [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}



-(NSArray*)GetIgnorePropertyList:(id)theObject{
    if([theObject respondsToSelector:@selector(GetCLJsonIgnoreProperty)]){
        return [theObject GetCLJsonIgnoreProperty];
    }
    else{
        return nil;
    }
}

-(BOOL)checkIsSerializeProperty:(NSArray*)lstIgnoreProeprty PropertyName:(NSString*)propertyName{
    if(lstIgnoreProeprty == nil || lstIgnoreProeprty.count==0)
        return YES;
    
    __block BOOL isSerialize = YES;
    
    [lstIgnoreProeprty enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
       
        if([obj isEqualToString:propertyName] ==YES){
            isSerialize = NO;
            *stop = YES;
        }
    }];
    
    return isSerialize;
    
}



-(NSMutableDictionary*)serializeObject:(id)theObject IgnoreProperty:(NSArray *)ignoreProperty{
    NSMutableDictionary *jsonDict = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    unsigned int outCount;
    
    if([theObject isKindOfClass:[NSString class]]){
        return theObject;
    }
    
    
    Ivar *ivars = class_copyIvarList([theObject class], &outCount);
    for (int i = 0; i<outCount; i++) {
        Ivar ivar = ivars[i];
        NSString *code = [NSString stringWithUTF8String:ivar_getTypeEncoding(ivar)];
        NSString *name = [NSString stringWithUTF8String:ivar_getName(ivar)];
        NSString *propertyName = name;
        if ([name hasPrefix:@"_"]) {
            propertyName = [name stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:@""];
        }
        
        if([self checkIsSerializeProperty:ignoreProperty PropertyName:propertyName] == NO){
            continue;
        }
        
        id value = [theObject valueForKey:name];
        
        CLJsonObjectValueSet *ValueSet = nil;
        
        if([code hasPrefix:@"@"]){
            code = [code substringFromIndex:2];
            code = [code substringToIndex:code.length - 1];
            
            if([code hasPrefix:@"UI"]){
                continue;
            }
            
            if([code compare:@"NSString"]==NSOrderedSame){
                ValueSet = [[CLStringJsonObjectValueSet alloc]init];
            }
            
            if([code compare:@"NSDate"] == NSOrderedSame){
                ValueSet = [[CLNSDateObjectValueSet alloc]init];
            }
            
            __weak CLJsonSerializer *my = self;
            if([code compare:@"NSMutableArray"]==NSOrderedSame || [code compare:@"NSArray"]==NSOrderedSame){
                ValueSet = [[CLArrayJsonObjectValueSet alloc]initWithGetObjectBlock:^NSMutableDictionary *(id setObject) {
                    return [my serializeObject:setObject IgnoreProperty:[self GetIgnorePropertyList:setObject]];
                }];
            }
            
            if(ValueSet==nil){
                ValueSet = [[CLNSObjectValueSet alloc]initWithGetObjectBlock:^NSMutableDictionary *(id setObject) {
                    return [my serializeObject:setObject IgnoreProperty:[self GetIgnorePropertyList:setObject]];
                }];
            }
        }
        
        if([code isEqualToString:OCTypeBOOL]){
            ValueSet = [[CLBoolJsonObjectValueSet alloc]init];
        }
        
        if(ValueSet==nil){
            ValueSet = [[CLJsonObjectValueSet alloc]init];
        }
        
        [ValueSet AddValue:jsonDict PropertyName:propertyName PropertyValue:value];
        
    }
    
    free(ivars);
    
    return jsonDict;
}


@end
