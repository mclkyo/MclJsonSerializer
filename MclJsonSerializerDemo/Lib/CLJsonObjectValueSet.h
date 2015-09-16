//
//  JsonObjectValueSet.h
//  shopproject
//
//  Created by yilecity on 14/12/25.
//  Copyright (c) 2014年 yilecity. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NSMutableDictionary* (^GetObjectDictBlock)(id setObject);

@interface CLJsonObjectValueSet : NSObject

-(void)AddValue:(NSMutableDictionary*)dict PropertyName:(NSString*)PropertyName PropertyValue:(NSString*)PropertyValue;

@end



@interface CLStringJsonObjectValueSet : CLJsonObjectValueSet

@end




@interface CLBoolJsonObjectValueSet : CLJsonObjectValueSet{
    
}

@end


@interface CLNSObjectValueSet : CLJsonObjectValueSet{

}
-(id)initWithGetObjectBlock:(GetObjectDictBlock)block;
@property(nonatomic,copy)GetObjectDictBlock block;
@end

@interface CLArrayJsonObjectValueSet : CLJsonObjectValueSet

-(id)initWithGetObjectBlock:(GetObjectDictBlock)block;
@property(nonatomic,copy)GetObjectDictBlock block;

@end
