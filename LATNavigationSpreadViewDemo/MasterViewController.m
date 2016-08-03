//
//  MasterViewController.m
//  LATNavigationSpreadViewDemo
//
//  Created by Later on 16/8/3.
//  Copyright © 2016年 罗树新. All rights reserved.
//

#import "MasterViewController.h"
#import "DetailViewController.h"
#import "UINavigationBar+LATNavigationSpreadViewCategory.h"

@interface MasterViewController ()
@property (strong, nonatomic) UIView *navigationSpreadView;
@property (strong, nonatomic) UIButton *titleButton;
@property NSMutableArray *objects;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
    self.navigationItem.rightBarButtonItem = addButton;
    self.detailViewController = (DetailViewController *)[[self.splitViewController.viewControllers lastObject] topViewController];
}

- (void)viewWillAppear:(BOOL)animated {
    self.clearsSelectionOnViewWillAppear = self.splitViewController.isCollapsed;
    [super viewWillAppear:animated];
    self.titleButton.frame = CGRectMake(0, 0, 60, 30);
    self.navigationItem.titleView = self.titleButton;
    
    
    
    self.navigationController.navigationBar.spreadView = self.navigationSpreadView;
    self.navigationController.navigationBar.spreadView.frame = CGRectMake(0, -84, CGRectGetWidth(self.view.frame), 64);
}
- (void)tap {
    if (self.navigationController.navigationBar.isSpreadViewShow) {
        [self.navigationController.navigationBar hideSpreadView];
    } else {
        [self.navigationController.navigationBar showSpreadView];
    }
    self.titleButton.selected = !self.navigationController.navigationBar.isSpreadViewShow;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender {
    if (!self.objects) {
        self.objects = [[NSMutableArray alloc] init];
    }
    [self.objects insertObject:[NSDate date] atIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSDate *object = self.objects[indexPath.row];
        DetailViewController *controller = (DetailViewController *)[[segue destinationViewController] topViewController];
        [controller setDetailItem:object];
        controller.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
        controller.navigationItem.leftItemsSupplementBackButton = YES;
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    NSDate *object = self.objects[indexPath.row];
    cell.textLabel.text = [object description];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.objects removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}
- (UIView *)navigationSpreadView {
    if (!_navigationSpreadView) {
        _navigationSpreadView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 100)];
        _navigationSpreadView.backgroundColor = [UIColor colorWithWhite:0.9 alpha:1];
    }
    return _navigationSpreadView;
}
- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_titleButton setTitle:@"展开" forState:UIControlStateNormal];
        [_titleButton setTitle:@"收起" forState:UIControlStateSelected];
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_titleButton setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        [_titleButton addTarget:self action:@selector(tap) forControlEvents:UIControlEventTouchUpInside];
    }
    return _titleButton;
}
@end
