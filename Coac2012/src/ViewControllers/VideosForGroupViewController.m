//
//  VideosForGroupViewController.m
//  Coac2012
//
//  Created by Borja Arias on 29/01/2012.
//  Copyright (c) 2012 Borja Arias Drake. All rights reserved.
//

#import "VideosForGroupViewController.h"
#import "Video.h"

@implementation VideosForGroupViewController




#pragma mark - Parent Class extentsion methods

- (void) updateArrayOfElements
{
    
}


- (void) configureCell:(UITableViewCell*)cell indexPath:(NSIndexPath*)indexpath
{
    Video* video = [elementsArray objectAtIndex:[indexpath row]];
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
    
    [super tableView:theTableView didSelectRowAtIndexPath:indexPath];
    Video* video = [elementsArray objectAtIndex:[indexPath row]];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:video.url]];
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
