//
//  ViewController.m
//  MclJsonSerializerDemo
//
//  Created by yilecity on 15/9/16.
//  Copyright (c) 2015年 yilecity. All rights reserved.
//

#import "ViewController.h"
#import "CLJsonSerializer.h"
#import "NSObject+IgnoreProperty.h"

@interface ViewController ()

@end

@implementation User

-(NSArray*)GetCLJsonIgnoreProperty{
    return @[@"image",@"Name"];
}

@end

@implementation Blog

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    
    NSMutableArray *lstType = [[NSMutableArray alloc]init];
    [lstType addObject:@"科技"];
    [lstType addObject:@"IT"];
    
    User *user1 = [[User alloc]init];
    user1.Id = 1;
    user1.Name = @"mcl";
    user1.image = [UIImage imageNamed:@"light_wood.jpg"];
    
    Blog *blog1 = [[Blog alloc]init];
    blog1.Id = 1;
    blog1.Title = @"文章标题1";
    blog1.IsRecommend = YES;
    blog1.user = user1;
    blog1.lstType = lstType;
    blog1.PostTime = [NSDate date];
    
    CLJsonSerializer *serializer = [[CLJsonSerializer alloc]init];
    
    NSDictionary *Mydict = @{@"Key":@"Value123"};
    NSString *dictJson = [serializer GetJson:Mydict];
    NSLog(@"dict json=%@",dictJson);
    
    
    
    NSString *json = [serializer GetJson:user1];
    NSLog(@"user json=%@",json);
    
    
    
    json = [serializer GetJson:blog1];
    NSLog(@"user json=%@",json);
    
    json = [serializer GetJson:lstType];
    NSLog(@"lstType=%@",json);
    
    NSMutableArray *lstBlog = [[NSMutableArray alloc]init];
    [lstBlog addObject:blog1];
    [lstBlog addObject:blog1];
    json = [serializer GetJson:lstBlog];
    NSLog(@"lstBlog=%@",json);
    
    json = [serializer GetJsonWithIgnoreProerty:lstBlog IgnoreProperty:@[@"user"]];
    NSLog(@"lstBlog=%@",json);
    
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:blog1 forKey:@"Blog"];
    [dict setObject:user1 forKey:@"User"];
    json = [serializer GetJson:dict];
    NSLog(@"dict=%@",json);

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
