//
//  ViewController.m
//  sJDScroll
//
//  Created by CaydenK on 2018/1/8.
//  Copyright © 2018年 Seven. All rights reserved.
//

#import "ViewController.h"

#define BANNER_SPACE_WIDTH          20      //间隙
#define BANNER_SPACE_SIDE           55      //第一个左边距

@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    int _index;
}

@property (nonatomic, strong) UIScrollView *myScroll;//banner
@property (nonatomic, strong) UIScrollView *bannerScroll;
@property (nonatomic, strong) UIScrollView *navScroll;//nav

@property (nonatomic, strong) NSMutableArray *headviewArr;//banner数组
@property (nonatomic, strong) NSMutableArray *tabArr;//列表数组
@property (nonatomic, strong) NSMutableArray *btnArr;//btn数组


@property (nonatomic, strong) NSMutableArray *dataArr;//数据数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.myScroll];
    [self.myScroll addSubview:self.bannerScroll];
//    [self.dataArr addObjectsFromArray: @[@{@"image":@"123",
//                                           @"title":@"title0"},
//                                         @{@"image":@"123",
//                                           @"title":@"title1"},
//                                         @{@"image":@"123",
//                                           @"title":@"title2"},
//                                         @{@"image":@"123",
//                                           @"title":@"title3"},
//                                         @{@"image":@"123",
//                                           @"title":@"title4"},
//                                         @{@"image":@"123",
//                                           @"title":@"title5"}]];
    
    [self.view addSubview:self.navScroll];
    [self createNav];
    if (@available(iOS 11.0, *)) {
        self.myScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        self.navScroll.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        
    }
    [self createHeader];
}
- (void)createNav
{
    CGFloat mywid =(WIDTH - kMinLeftspacing * 2) / self.dataArr.count;
    
    for (int i = 0; i < self.dataArr.count; i++)
    {
        UIButton *btn = [[UIButton alloc]init];
        btn.frame = CGRectMake(kMinLeftspacing + mywid * i, [UIApplication sharedApplication].statusBarFrame.size.height, mywid, 44);
        btn.titleLabel.font = [UIFont systemFontOfSize:15];
        [btn setTitle:[NSString stringWithFormat:@"%@",self.dataArr[i][@"title"]] forState:0];
        [btn addTarget:self action:@selector(btnclick:) forControlEvents:UIControlEventTouchUpInside];
        if (i == 0)
        {
            [btn setTitleColor:kUIColorFromRGB(0xffffff) forState:0];
        }else
        {
            [btn setTitleColor:kUIColorFromRGB(0xbfc6d4) forState:0];
        }
        btn.tag = 100 + i;
        [self.navScroll addSubview:btn];
        [self.btnArr addObject:btn];
    }
}
- (void)createHeader
{
    self.bannerScroll.frame = CGRectMake(0, 0, WIDTH * self.dataArr.count,  kSpaceH(162) + kSpaceH(18) * 2);
    for (int i = 0; i < self.dataArr.count; i++)
    {
        UITableView *tableview = [[UITableView alloc]init];
        tableview.showsVerticalScrollIndicator = NO;
        tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableview.delegate = self;
        tableview.dataSource = self;
        tableview.tag = 1000 + i;
        [tableview addObserver:self forKeyPath:@"conset" options:NSKeyValueObservingOptionNew context:nil];
        tableview.frame = CGRectMake(kMinLeftspacing * 2 + WIDTH * i, kSpaceH(162) + kSpaceH(18) * 2/*kSpaceH(162)  + kSpaceH(18) * 2*/, WIDTH - kMinLeftspacing * 4, HEIGHT/*(kSpaceH(162) + 64 + 18 * 2)*/);
        tableview.backgroundColor = [UIColor colorWithRed:arc4random()%244/255.0 green:arc4random()%244/255.0 blue:arc4random()%244/255.0 alpha:1];
        
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(BANNER_SPACE_WIDTH + (WIDTH - kMinLeftspacing * 4 + BANNER_SPACE_WIDTH) * i,  kSpaceH(18), WIDTH - kMinLeftspacing * 3, kSpaceH(162))];
        imageview.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",self.dataArr[i][@"image"]]];
        [self.bannerScroll addSubview:imageview];
        [_myScroll addSubview:tableview];
        [self.headviewArr addObject:imageview];
        [self.tabArr addObject:tableview];
    }
    
}

- (void)btnclick:(UIButton *)btn
{
    int index = (int)btn.tag - 100;
    for (int i = 0; i < _btnArr.count; i++)
    {
        UIButton *btn = _btnArr[i];
        if (index != i)
        {
            [btn setTitleColor:kUIColorFromRGB(0xbfc6d4) forState:0];
        }else
        {
            [btn setTitleColor:kUIColorFromRGB(0xffffff) forState:0];
        }
    }
    [_myScroll setContentOffset:CGPointMake(index * WIDTH, 0) animated:YES];
    [self scrollviewWithIndex:index];
}

- (void)scrollviewWithIndex:(int)index
{
    [UIView animateWithDuration:0.1 animations:^{
        
        for (int i = 0; i < _btnArr.count; i++)
        {
            UIButton *btn = _btnArr[i];
            if (index != i)
            {
                [btn setTitleColor:kUIColorFromRGB(0xbfc6d4) forState:0];
            }else
            {
                [btn setTitleColor:kUIColorFromRGB(0xffffff) forState:0];
            }
        }
    }];
}

#pragma mark scroll代理

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat myx = scrollView.contentOffset.x;
    _index = (int)myx / WIDTH;
    CGRect frame = self.bannerScroll.frame;
    self.bannerScroll.frame = CGRectMake((self.myScroll.contentOffset.x ) * 28  / self.view.frame.size.width , frame.origin.y, frame.size.width, frame.size.height);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView == _myScroll)
    {
        [self scrollviewWithIndex:_index];
    }
    
    
}

#pragma mark tableview代理
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identifier = [NSString stringWithFormat:@"MyYearCardTableViewCell%d",_index];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = @"哈喽哈喽哈喽";
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%244/255.0 green:arc4random()%244/255.0 blue:arc4random()%244/255.0 alpha:1];
    cell.detailTextLabel.text = @"哈哈哈哈老考虑考虑考虑了快快乐乐看卡来空间的法拉是空间发神经发算了就法拉盛";
    cell.detailTextLabel.numberOfLines = 0;
    return cell;
}

#pragma mark 懒加载
- (UIScrollView *)navScroll
{
    if (_navScroll == nil)
    {
        _navScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
        _navScroll.showsHorizontalScrollIndicator = NO;
        _navScroll.showsVerticalScrollIndicator = NO;
        _navScroll.pagingEnabled = YES;
        _navScroll.delegate = self;
        _navScroll.backgroundColor = kUIColorFromRGB(0x5d667a);
    }
    return _navScroll;
}
- (UIScrollView *)myScroll
{
    if (_myScroll == nil)
    {
        _myScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT - 64)];
        _myScroll.showsHorizontalScrollIndicator = NO;
        _myScroll.showsVerticalScrollIndicator = NO;
        _myScroll.contentSize = CGSizeMake(WIDTH * self.dataArr.count, 0);
        _myScroll.pagingEnabled = YES;
        _myScroll.delegate = self;
        _myScroll.backgroundColor = [UIColor whiteColor];
    }
    return _myScroll;
}
- (UIScrollView *)bannerScroll{
    if (!_bannerScroll) {
        _bannerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WIDTH * self.dataArr.count,  kSpaceH(162) + kSpaceH(18) * 2)];
        _bannerScroll.showsHorizontalScrollIndicator = NO;
        _bannerScroll.showsVerticalScrollIndicator = NO;
        _bannerScroll.pagingEnabled = YES;
        _bannerScroll.delegate = self;
        _bannerScroll.backgroundColor = [UIColor orangeColor];
    }
    return _bannerScroll;
}
- (NSMutableArray *)headviewArr
{
    if (_headviewArr == nil)
    {
        _headviewArr = [[NSMutableArray alloc]init];
    }
    return _headviewArr;
}
- (NSMutableArray *)tabArr
{
    if (_tabArr == nil)
    {
        _tabArr = [[NSMutableArray alloc]init];
    }
    return _tabArr;
}
- (NSMutableArray *)dataArr
{
    if (!_dataArr)
    {
        _dataArr = [NSMutableArray new];
        [_dataArr addObjectsFromArray: @[@{@"image":@"123",
                                               @"title":@"title0"},
                                             @{@"image":@"123",
                                               @"title":@"title1"},
                                             @{@"image":@"123",
                                               @"title":@"title2"},
                                             @{@"image":@"123",
                                               @"title":@"title3"},
                                             @{@"image":@"123",
                                               @"title":@"title4"},
                                             @{@"image":@"123",
                                               @"title":@"title5"}]];;
    }
    return _dataArr;
}
- (NSMutableArray *)btnArr
{
    if (_btnArr == nil)
    {
        _btnArr = [[NSMutableArray alloc]init];
    }
    return _btnArr;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
