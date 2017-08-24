//
//  ViewController.m
//  WCDB-example
//
//  Created by zero on 2017/8/23.
//  Copyright © 2017年 zero. All rights reserved.
//

#import "ViewController.h"
#import "RHTestModel.h"
#import "RHWCDBManager.h"
@interface ViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIButton *creatBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UIButton *delBtn;
@property (weak, nonatomic) IBOutlet UIButton *updBtn;
@property (weak, nonatomic) IBOutlet UIButton *retBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ageTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *hobbyTextField;
@property (weak, nonatomic) IBOutlet UITextField *keyIdTextField;

@property(nonatomic,strong) UITableView *tableview; //
@property(nonatomic,strong) NSMutableArray *datasource; //

@property(nonatomic,strong) RHWCDBManager *manager; //

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.manager = [RHWCDBManager share];
    [self.view addSubview:self.tableview];
    self.nameTextField.delegate = self;
    self.ageTextField.delegate = self;
    self.addressTextField.delegate = self;
    self.hobbyTextField.delegate = self;
    self.keyIdTextField.delegate = self;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillLayoutSubviews{
    CGFloat orightY = CGRectGetMaxY(self.hobbyTextField.frame);
    self.tableview.frame = CGRectMake(0, orightY, self.view.frame.size.width, self.view.frame.size.height - orightY);
}

- (IBAction)ceratTable:(id)sender {
    NSString *path = [NSHomeDirectory() stringByAppendingString:@"/DB/WC.db"];
   BOOL result = [self.manager rh_createDBwithTable:NSStringFromClass(RHTestModel.class) elementClass:RHTestModel.class];
    if (result) {
        NSLog(@"建表成功");
    }else{
        NSLog(@"建表失败");
    }
}
- (IBAction)addObject:(id)sender {
    RHTestModel *model = [[RHTestModel alloc]init];
    model.localID = [self.keyIdTextField.text intValue];
    model.name =self.nameTextField.text;
    model.age = [self.ageTextField.text intValue];
    model.address = self.addressTextField.text;
    model.hobis = self.hobbyTextField.text;
    BOOL result = [self.manager rh_insertObject:model table:NSStringFromClass(RHTestModel.class)];
    
    if (result) {
        NSLog(@"添加成功");
        [self getData];
    }else{
        NSLog(@"添加失败");
    }
}
- (IBAction)deleteObject:(id)sender {
    RHTestModel *model = [[RHTestModel alloc]init];
    model.localID = [self.keyIdTextField.text intValue];
    model.name =self.nameTextField.text;
    model.age = [self.ageTextField.text intValue];
    model.address = self.addressTextField.text;
    model.hobis = self.hobbyTextField.text;
    BOOL result = [self.manager rh_deleteObjectsFormTable:NSStringFromClass(RHTestModel.class)where:RHTestModel.localID == model.localID];
    if (result) {
        NSLog(@"删除成功");
        [self getData];
    }else{
        NSLog(@"删除失败");
    }
    
}
- (IBAction)updateObject:(id)sender {
    RHTestModel *model = [[RHTestModel alloc]init];
    model.localID = [self.keyIdTextField.text intValue];
    model.name =self.nameTextField.text;
    model.age = [self.ageTextField.text intValue];
    model.address = self.addressTextField.text;
    model.hobis = self.hobbyTextField.text;
    BOOL result = [self.manager rh_updateRowsInTable:NSStringFromClass(RHTestModel.class) onProperty:RHTestModel.age withObject:model where:RHTestModel.localID == model.localID];
    if (result) {
        NSLog(@"更新成功");
        [self getData];
    }else{
        NSLog(@"更新失败");
    }
}
- (IBAction)retrieveObject:(id)sender {
    [self getData];
}

- (void)getData{
    NSArray<RHTestModel *> *result = [self.manager rh_getObjectsOfClass:RHTestModel.class fromTable:NSStringFromClass(RHTestModel.class) orderBy:RHTestModel.localID.order()];
    if (result.count > 0) {
        [self.datasource removeAllObjects];
        [self.datasource addObjectsFromArray:result];
    }
    [self.tableview reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.datasource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    RHTestModel *model = self.datasource[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"我是%@，今年%d岁",model.name,model.age];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"住在%@，喜欢%@",model.address,model.hobis];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RHTestModel *model = self.datasource[indexPath.row];
    self.keyIdTextField.text = [NSString stringWithFormat:@"%d",model.localID];
    self.nameTextField.text = model.name;
    self.ageTextField.text = [NSString stringWithFormat:@"%d",model.age];
    self.addressTextField.text = model.address;
    self.hobbyTextField.text= model.hobis;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    return YES;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}


- (UITableView *)tableview{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
    }
    return _tableview;
}

- (NSMutableArray *)datasource{
    if (!_datasource) {
        _datasource = [[NSMutableArray alloc]init];
    }
    return _datasource;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
