//
//  VideosForGroupViewController.m
//  Coac2012
//
//  Created by Borja Arias on 29/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "VideosForGroupViewController.h"
#import "Video.h"
#import "BaseCoacListViewController+Protected.h"
#import "VideoViewController.h"


@implementation VideosForGroupViewController




#pragma mark - Parent Class extentsion methods

- (void) updateArrayOfElements
{
    
}


- (void) tableView:(UITableView*)tableView configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    Video* video = self.elementsArray[[indexpath row]];
    UILabel* groupNameLabel = (UILabel*) [cell viewWithTag:GROUP_NAME_LABEL_TAG];
    groupNameLabel.text = video.desc;
    
}



#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Videos";
}



#pragma mark - Table view data source

- (void)tableView:(UITableView *)theTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoViewController *videoViewController = [[VideoViewController alloc] init];
    videoViewController.video = self.elementsArray[indexPath.row];
    [self.navigationController pushViewController:videoViewController animated:YES];
    [videoViewController release];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}



#pragma mark - custom cells

- (NSString*) normalCellNibName
{
    return @"LinkCell";
}

- (NSString*) selectedCellNibName
{
    return @"LinkCellSelected";
}


@end
