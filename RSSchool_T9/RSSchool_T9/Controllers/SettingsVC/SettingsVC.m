//
// 📰 🐸 
// Project: RSSchool_T9
// 
// Author: Evgeniy Petlitskiy
// On: 3.08.21
// 
// Copyright © 2021 RSSchool. All rights reserved.

#import "SettingsVC.h"
#import "StrokeColorSettingsVC.h"

@interface SettingsVC ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) StrokeColorSettingsVC *strokeColorSettingVC;

@end

@implementation SettingsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
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

//MARK: - UITableViewDataSource

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    if (indexPath.row == 0) {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DrawStoriesCell"];
        cell.textLabel.text = @"Draw stories";
        
        UISwitch *drawSwitch = [[UISwitch alloc] init];
        drawSwitch.on = YES;
        
        cell.accessoryView = drawSwitch;
        
        return cell;
        
    } else {
        
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"StrokeColorCell"];
        cell.textLabel.text = @"Stroke color";
        cell.textLabel.font = [UIFont fontWithName:@"SFProDisplay-Regular" size:12];
        
        cell.detailTextLabel.text = @"#e87aa4";
        cell.detailTextLabel.textColor = UIColor.redColor;
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
}

//MARK: UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 53;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 1) {
        self.strokeColorSettingVC = [[StrokeColorSettingsVC alloc] init];
        [self.navigationController pushViewController:self.strokeColorSettingVC animated:YES];
    }
}



@end
