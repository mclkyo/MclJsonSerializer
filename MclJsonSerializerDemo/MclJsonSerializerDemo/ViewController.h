//
//  ViewController.h
//  MclJsonSerializerDemo
//
//  Created by yilecity on 15/9/16.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface User : NSObject

@property(nonatomic,assign)int Id;
@property(nonatomic,retain)NSString *Name;
@property(nonatomic,strong)UIImage *image;


@end

@interface Blog : NSObject
@property(nonatomic,assign)int Id;
@property(nonatomic,assign)BOOL IsRecommend;
@property(nonatomic,retain)NSString *Title;
@property(nonatomic,retain)User *user;
@property(nonatomic,retain)NSMutableArray *lstType;
@property(nonatomic,strong)NSDate *PostTime;

@end

@interface ViewController : UIViewController


@end

