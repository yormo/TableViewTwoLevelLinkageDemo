//
//  LGJCategoryVC.m
//  TableViewTwoLevelLinkageDemo
//
//  Created by 劉光軍 on 16/5/30.
//  Copyright © 2016年 [SinaWeibo:劉光軍_Shine    简书:劉光軍_   ]. All rights reserved.
//一级分类界面

#import "LGJCategoryVC.h"
#import "LGJProductsVC.h"

@interface LGJCategoryVC ()<UITableViewDelegate, UITableViewDataSource, ProductsDelegate>

@property (nonatomic, strong) UITableView *categoryTableView;
@property (nonatomic, strong) NSArray *categoryArr;
@property (nonatomic, strong)  LGJProductsVC *productsVC;
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;

@end

@implementation LGJCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.title = @"TestDemo";
    [self configData];
    [self createTableView];
    [self createProductsVC];
    
}

- (void)configData {
    
    if (!_categoryArr) {
        
        NSArray *numArr = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一",@"十二",@"十三",@"十四",@"十五",@"十六",@"十七",@"十八",@"十九",@"二十"];
        NSMutableArray *tmpArr = [NSMutableArray array];
        for (int i = 0; i < 20; i++) {
            NSString *tmpStr = [NSString stringWithFormat:@"第%@类", numArr[i]];
            [tmpArr addObject:tmpStr];
        }
        _categoryArr = tmpArr;
    }
}

- (void)createTableView {
    self.categoryTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.25, self.view.frame.size.height) style:UITableViewStylePlain];
    self.categoryTableView.delegate = self;
    self.categoryTableView.dataSource = self;
    self.categoryTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.categoryTableView];
}

- (void)createProductsVC {
    _productsVC = [[LGJProductsVC alloc] init];
    _productsVC.delegate = self;
    [self addChildViewController:_productsVC];
    [self.view addSubview:_productsVC.view];
}

//MARK:-tableView的代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _categoryArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 31;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ident = @"ident";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ident];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ident];
    }
    
    cell.textLabel.text = [_categoryArr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:13];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_productsVC) {
        [_productsVC scrollToSelectedIndexPath:indexPath];
    }
    self.currentSelectIndexPath = indexPath;
}

#pragma mark - ProductsDelegate
- (void)selectLeftTableViewWithSection:(NSInteger)section {
    if (self.currentSelectIndexPath) {
        return;
    }
    
    [self.categoryTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}
- (void)scrollViewDidEndScrollingAnimation {
    if (self.currentSelectIndexPath) {
        self.currentSelectIndexPath = nil;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
