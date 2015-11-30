//
//  ViewController.m
//  LaiSiShop
//
//  Created by taobaichi on 15/11/19.
//  Copyright © 2015年 taobaichi. All rights reserved.
//

#import "ViewController.h"


#import "FMDatabase.h"
#import "FMDatabaseQueue.h"


#import "NewDataViewController.h"


#import "GestureViewController.h"
#import "PCCircleViewConst.h"

@interface ViewController ()

@property (nonatomic, retain) NSString * dbPath;
@property (strong, nonatomic) IBOutlet UIButton *insertButton;
@property (strong, nonatomic) IBOutlet UIButton *selectButton;




@end

@implementation ViewController


- (IBAction)demoAction:(id)sender {
    
    UIStoryboard *newDataStoryboard = [UIStoryboard  storyboardWithName:@"NewdataStoryboard" bundle:nil];
    NewDataViewController *newDataVc = [newDataStoryboard instantiateInitialViewController];
    [self presentViewController:newDataVc animated:YES completion:nil];
    
    
    
}

- (NSString *) dbPath//应用程序的沙盒路径

{
    
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *document = [path objectAtIndex:0];
    
    return [document stringByAppendingPathComponent:@"StudentData.sqlite"];
    
}
#pragma mark ----插入数据
- (IBAction)insertDataAction:(id)sender {
    
  
    
    int value = arc4random();
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    if ([db open]) {
        NSString *sql = @"insert INTO User(id,name,password)VALUES (?,?,?)";
        NSString *name = [NSString stringWithFormat:@"easy+%d",value];
        NSString *password = [NSString stringWithFormat:@"12233"];
        BOOL res = [db executeUpdate:sql,@(value +100),name,password];
        
        if (res) {
            NSLog(@"插入数据成功");
        }else{
            NSLog(@"插入数据失败");
        }
        [db close];
    } else{
        NSLog(@"打开数据库失败");
    }
    
    
    
    
}


#pragma mark ----查找数据
- (IBAction)selectDataAction:(id)sender {
    FMDatabase *db = [FMDatabase databaseWithPath:self.dbPath];
    
    if ([db open]) {
        NSString *sql = @"SELECT * FROM User";
        FMResultSet *rs = [db executeQuery:sql];
        while ([rs next]) {
            int userId = [rs intForColumn:@"id"];
            NSString *name = [rs stringForColumn:@"name"];
            NSString *psw = [rs stringForColumn:@"password"];
            
            NSLog(@"--userId=%d,---name= %@,---password --=%@",userId,name,psw);
        }
        [db close];
        
        
    }
    
}

#pragma mark ----删除数据
- (IBAction)deleteDataAction:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
 
    
    
    [self.insertButton setTitle:NSLocalizedString(@"11", @"插入按钮") forState:UIControlStateNormal];
    
    
    [self.selectButton setTitle:NSLocalizedString(@"22", @"查找按钮") forState:UIControlStateNormal];

    
    
    
    
    NSLog(@"-----%@---",NSLocalizedString(@"11", @"插入按钮"));
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    [dateFormatter setDateFormat:@"'公元前/后:'G  '年份:'u'='yyyy'='yy '季度:'q'='qqq'='qqqq '月份:'M'='MMM'='MMMM '今天是今年第几周:'w '今天是本月第几周:'W  '今天是今天第几天:'D '今天是本月第几天:'d '星期:'c'='ccc'='cccc '上午/下午:'a '小时:'h'='H '分钟:'m '秒:'s '毫秒:'SSS  '这一天已过多少毫秒:'A  '时区名称:'zzzz'='vvvv '时区编号:'Z "];
    NSLog(@"-------%@", [dateFormatter stringFromDate:[NSDate date]]);
    
//    
    // 创建数据库表
    FMDatabase * db = [FMDatabase databaseWithPath:self.dbPath];
    
    if ([db open]) {
        NSString * sql = @"CREATE TABLE 'User' IF NOT EXISTS ('id' INTEGER PRIMARY KEY AUTOINCREMENT  NOT NULL , 'name' VARCHAR(30), 'password' VARCHAR(30))";
        BOOL res = [db executeUpdate:sql];
        if (!res) {
            NSLog(@"error when creating db table");
        } else {
            NSLog(@"succ to creating db table");
        }
        [db close];
    } else {
        NSLog(@"error when open db");
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
   [self loadMainViewAndController];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
  
}


#pragma mark ----判断加载视图和控制器
-(void)loadMainViewAndController
{
    
    

    
     if ([[PCCircleViewConst getGestureWithKey:gestureFinalSaveKey] length])
     {// 已经有密码
         NSLog(@"已经有密码了");
         GestureViewController *gestureVc = [[GestureViewController alloc] init];
         [gestureVc setType:GestureViewControllerTypeLogin];
         
          [self.navigationController pushViewController:gestureVc animated:YES];
         
         
         
     } else{
         // 去设置密码
           NSLog(@"去设置密码");
         GestureViewController *gestureVc = [[GestureViewController alloc] init];
         gestureVc.type = GestureViewControllerTypeSetting;
         [self.navigationController pushViewController:gestureVc animated:YES];
     }
   
    
    // 测试使用 soure Tree
    // 简单使用
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
