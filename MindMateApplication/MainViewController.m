//
//  MainViewController.m
//  MindMateApplication
//
//  Created by Roger Luan on 24/01/17.
//  Copyright © 2017 Roger Oba. All rights reserved.
//

#import "MainViewController.h"
#import "FacebookManager.h"
#import "ProfileCell.h"
#import "LoginManager.h"
#import "LoginViewController.h"
#import <SVProgressHUD/SVProgressHUD.h>

static NSString * const kProfileCell = @"profileCell";
static NSString * const LoginViewControllerIdentifier = @"LoginViewControllerIdentifier";
static NSString * const ShowLoginSegueIdentifier = @"showLoginSegueIdentifier";

@interface MainViewController () <UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSDictionary *userInfo;

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [SVProgressHUD show];
    [self.tableView registerNib:[UINib nibWithNibName:@"ProfileCell" bundle:nil] forCellReuseIdentifier:kProfileCell];
    
//    UIRefreshControl *refreshControl = [UIRefreshControl new];
//    [refreshControl addTarget:self action:@selector(refreshData:) forControlEvents:UIControlEventValueChanged];
//    [self.tableView addSubview:refreshControl];
//    [self.view sendSubviewToBack:refreshControl];
    [self refreshData:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)refreshData:(UIRefreshControl *)refreshControl {
    [[FacebookManager sharedManager] fetchUserInfo:^(NSDictionary * _Nullable info, NSError * _Nullable error) {
        [SVProgressHUD dismiss];
        if (!error) {
            self.userInfo = info;
            [self.tableView reloadData];
            [self.tableView layoutIfNeeded];
            [refreshControl endRefreshing];
        } else {
            [refreshControl endRefreshing];
            [self presentViewController:[MMErrorManager alertFromError:error] animated:YES completion:nil];
        }
    }];
}

#pragma mark - UITableView DataSource Methods -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProfileCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfileCell forIndexPath:indexPath];
    cell.userData = self.userInfo;

    return cell;
}

#pragma mark - IBAction -

- (IBAction)didPressLogOutButton:(UIBarButtonItem *)sender {
    [[LoginManager sharedManager] logoutWithCompletionBlock:^(NSError * _Nullable error) {
        if (!error) {
            [self performSegueWithIdentifier:ShowLoginSegueIdentifier sender:self];
//            LoginViewController *loginVC = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:LoginViewControllerIdentifier];
//            [self.navigationController showViewController:loginVC sender:self];
        } else {
            [self presentViewController:[MMErrorManager alertFromError:error] animated:YES completion:nil];
        }
    }];
}

@end
