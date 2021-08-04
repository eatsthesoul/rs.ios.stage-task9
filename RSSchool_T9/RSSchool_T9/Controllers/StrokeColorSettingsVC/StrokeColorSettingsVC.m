//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 4.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "StrokeColorSettingsVC.h"
#import "StrokeColors.h"
#import "UIColor+HexColor.h"

@interface StrokeColorSettingsVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *data;

@property(nonatomic, strong) NSIndexPath *selectedCellIndexPath;

@end

@implementation StrokeColorSettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.data = [StrokeColors data];
    
    self.navigationItem.title = @"Settings";
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUIElements];
    [self setupAppearance];
    
}

- (void)setupUIElements {
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleInsetGrouped];
    self.tableView.translatesAutoresizingMaskIntoConstraints = NO;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (void)setupAppearance {
    
    [self.view addSubview:self.tableView];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.tableView.leadingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leadingAnchor],
        [self.tableView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
        [self.tableView.trailingAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.trailingAnchor],
        [self.tableView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
    ]];
}

- (void)selectCellForIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *newSelectedCell = [self.tableView cellForRowAtIndexPath:indexPath];
    newSelectedCell.accessoryType = UITableViewCellAccessoryCheckmark;
    self.selectedCellIndexPath = indexPath;
}

//MARK: - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ColorCell"];
    cell.textLabel.text = self.data[indexPath.row];
    cell.textLabel.textColor = [UIColor colorFromHexString:self.data[indexPath.row]];
    
    return cell;
}

//MARK: UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UITableViewCell *oldSelectedCell = [tableView cellForRowAtIndexPath:self.selectedCellIndexPath];
    oldSelectedCell.accessoryType = UITableViewCellAccessoryNone;
    
    [self selectCellForIndexPath:indexPath];
}

@end
