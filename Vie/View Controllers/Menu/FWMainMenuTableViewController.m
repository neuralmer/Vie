//
// Created by Fabien Warniez on 2014-03-31.
// Copyright (c) 2014 Fabien Warniez. All rights reserved.
//

#import "FWMainMenuTableViewController.h"
#import "FWMainViewController.h"
#import "FWSmartTableViewCell.h"
#import "UIColor+FWAppColors.h"

static NSString * const kFWMainMenuViewControllerCellIdentifier = @"MenuCell";
static CGFloat const kFWMainMenuViewControllerCellHeight = 50.0f;

@interface FWMainMenuTableViewController () <UITableViewDataSource, UITableViewDelegate, FWSmartTableViewCellDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation FWMainMenuTableViewController

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[FWSmartTableViewCell class] forCellReuseIdentifier:kFWMainMenuViewControllerCellIdentifier];
    }
    return self;
}

- (void)loadView
{
    self.view = self.tableView;
}

- (void)viewDidLoad
{
    self.tableView.frame = self.view.bounds;
    self.title = NSLocalizedString(@"main_menu_title", nil);
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FWSmartTableViewCell *dequeuedCell = [tableView dequeueReusableCellWithIdentifier:kFWMainMenuViewControllerCellIdentifier forIndexPath:indexPath];

    if (indexPath.row == 2)
    {
        dequeuedCell.textLabel.text = NSLocalizedString(@"menu_item_save_game", nil);
        dequeuedCell.useCustomAccessoryView = YES;
        dequeuedCell.accessoryImage = [UIImage imageNamed:@"save"];
        dequeuedCell.accessoryImageFlipped = [UIImage imageNamed:@"checkmark"];
//        dequeuedCell.flashColor = [UIColor successfulBackgroundColor];
        dequeuedCell.delegate = self;
    }
    else
    {
        if (indexPath.row == 0)
        {
            dequeuedCell.textLabel.text = NSLocalizedString(@"menu_item_cell_color", nil);
        }
        else if (indexPath.row == 1)
        {
            dequeuedCell.textLabel.text = NSLocalizedString(@"menu_item_board_size", nil);
        }
        else if (indexPath.row == 3)
        {
            dequeuedCell.textLabel.text = NSLocalizedString(@"menu_item_load_game", nil);
        }
        else if (indexPath.row == 4)
        {
            dequeuedCell.textLabel.text = NSLocalizedString(@"menu_item_load_patterns", nil);
        }
        else
        {
            NSAssert(false, @"There are only 5 items in the menu");
        }

        dequeuedCell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"right_arrow"]];
    }

    return dequeuedCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kFWMainMenuViewControllerCellHeight;
}

#pragma mark - UITableViewDelegate

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.row != 2;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row == 0)
    {
        FWColorSchemePickerTableViewController *colorSchemePickerTableViewController = [[FWColorSchemePickerTableViewController alloc] init];
//        colorSchemePickerTableViewController.delegate = self.mainViewController;
        [self.navigationController pushViewController:colorSchemePickerTableViewController animated:YES];
    }
    else if (indexPath.row == 1)
    {
        FWBoardSizePickerTableViewController *boardSizePickerTableViewController = [[FWBoardSizePickerTableViewController alloc] init];
//        boardSizePickerTableViewController.delegate = self.mainViewController;
        [self.navigationController pushViewController:boardSizePickerTableViewController animated:YES];
    }
    else if (indexPath.row == 3)
    {
        FWSavedGamePickerTableViewController *savedGamePickerTableViewController = [[FWSavedGamePickerTableViewController alloc] init];
//        savedGamePickerTableViewController.delegate = self.mainViewController;
        [self.navigationController pushViewController:savedGamePickerTableViewController animated:YES];
    }
    else if (indexPath.row == 4)
    {
        FWCellPatternPickerTableViewController *cellPatternPickerTableViewController = [[FWCellPatternPickerTableViewController alloc] init];
//        cellPatternPickerTableViewController.delegate = self.mainViewController;
        [self.navigationController pushViewController:cellPatternPickerTableViewController animated:YES];
    }
}

- (void)accessoryButtonTapped:(FWSmartTableViewCell *)sender
{
//    FWSmartTableViewCell *saveGameCell = (FWSmartTableViewCell *) [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    [self.delegate saveCurrentGame];
}

@end