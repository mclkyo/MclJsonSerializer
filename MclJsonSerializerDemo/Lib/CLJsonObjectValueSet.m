//
//  JsonObjectValueSet.m
//  shopproject
//
//  Created by yilecity on 14/12/25.
//  Copyright (c) 2014年 yilecity. All rights reserved.
//

#import "CLJsonObjectValueSet.h"


@implementation CLJsonObjectValueSet

-(void)AddValue:(NSMutableDictionary *)dict PropertyName:(NSString *)PropertyName PropertyValue:(NSString *)PropertyValue{
    if(PropertyValue!=nil)
        [dict setObject:PropertyValue forKey:PropertyName];
}

@end

@implementation CLStringJsonObjectValueSet

-(BOOL)isNullOrEmpty:(NSString*)input
{
    if(input==(id) [NSNull null] || [input length]==0 || [input isEqual:@""] || input == nil)
    {
        //String is null or bad response
        return YES;
    }
    else {
        return NO;
    }
}

-(void)AddValue:(NSMutableDictionary *)dict PropertyName:(NSString *)PropertyName PropertyValue:(NSString *)PropertyValue{
    if([self isNullOrEmpty:PropertyValue]){
        [dict setObject:@"" forKey:PropertyName];
    }
    else{
        [dict setObject:PropertyValue forKey:PropertyName];
    }
    
}

@end


@implementation CLBoolJsonObjectValueSet

-(void)AddValue:(NSMutableDictionary *)dict PropertyName:(NSString *)PropertyName PropertyValue:(NSString *)PropertyValue{
    BOOL v = [[NSString stringWithFormat:@"%@",PropertyValue] boolValue];
    if(v == YES){
        [dict setObject:@"true" forKey:PropertyName];
    }
    else{
        [dict setObject:@"false" forKey:PropertyName];
    }
}

@end


@implementation CLNSObjectValueSet

-(id)initWithGetObjectBlock:(GetObjectDictBlock)block{
    self = [super init];
    self.block = block;
    return self;
}

-(void)AddValue:(NSMutableDictionary *)dict PropertyName:(NSString *)PropertyName PropertyValue:(NSString *)PropertyValue{
    [dict setObject:self.block(PropertyValue) forKey:PropertyName];
}

@end


@implementation CLArrayJsonObjectValueSet

-(id)initWithGetObjectBlock:(GetObjectDictBlock)block{
    self = [super init];
    self.block = block;
    return self;
}


-(void)AddValue:(NSMutableDictionary *)dict PropertyName:(NSString *)PropertyName PropertyValue:(NSString *)PropertyValue{
    NSMutableArray *json = [[NSMutableArray alloc]init];
    NSArray *arr = (NSArray*)PropertyValue;
    for (int i=0; i<arr.count; i++) {
        [json addObject:self.block(arr[i])];
    }
    [dict setObject:json forKey:PropertyName];
    
}

@end



@implementation CLNSDateObjectValueSet

-(void)AddValue:(NSMutableDictionary *)dict PropertyName:(NSString *)PropertyName PropertyValue:(NSString *)PropertyValue{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    id value = [[NSString alloc]initWithFormat:@"%@",[formatter stringFromDate:(NSDate*)PropertyValue]];
    
    [dict setObject:value forKey:PropertyName];
}




@end






