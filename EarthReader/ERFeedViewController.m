//
//  ERFeedViewController.m
//  EarthReader
//
//  Created by 김태호 on 2013. 12. 28..
//  Copyright (c) 2013년 Earth Reader. All rights reserved.
//

#import "ERFeedViewController.h"
#import "EREntryViewController.h"
#import "ERStage.h"
#import "ERCrawler.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface ERFeedViewController ()
{
    NSDictionary *_sub;
    NSMutableArray *_data;
}
@end

@implementation ERFeedViewController

- (id)initWithObject:(NSDictionary *)subscription
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        _sub = subscription;
        _data = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = _sub[@"title"];
    [self loadData];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(requestFeedRefresh)];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData {
    [SVProgressHUD show];
    [[ERAPIManager sharedManager] GET:_sub[@"entries_url"]
                           parameters:nil
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  [self parseResponse:responseObject];
                                  [SVProgressHUD dismiss];
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  [SVProgressHUD showErrorWithStatus:@"Error"];
                              }];
}

- (void)parseResponse:(NSDictionary *)response {
    [_data removeAllObjects];
    [_data addObjectsFromArray:response[@"entries"]];
    [self.tableView reloadData];
}

- (void)requestFeedRefresh {
    [SVProgressHUD show];
    [[ERAPIManager sharedManager] PUT:_sub[@"entries_url"]
                           parameters:nil
                              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                  [SVProgressHUD dismiss];
                              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                  [SVProgressHUD dismiss];
                              }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"EntryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *entry = _data[indexPath.row];
    cell.textLabel.text = entry[@"title"];
    cell.detailTextLabel.text = entry[@"updated"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *entry = _data[indexPath.row];
    EREntryViewController *vc = [[EREntryViewController alloc] initWithObject:entry];
    [self.navigationController pushViewController:vc animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

@end
