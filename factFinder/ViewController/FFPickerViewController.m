//
//  FFPickerViewController.m
//  factFinder
//
//  Created by Hong Junho on . 4. 11.2018.
//  Copyright © 2018년 Hong Junho. All rights reserved.
//

#import "FFPickerViewController.h"

// Utility
#import "UIColor+FFExtention.h"
#import "UIFont+FFExtention.h"

@interface FFPickerViewController ()

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIButton *cancelButton;
@property (strong, nonatomic) UIButton *selectButton;
@property (strong, nonatomic) UIView *contentContainer;

@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) NSArray *titles;

@property (nonatomic) NSInteger selectedRow;

@end

@implementation FFPickerViewController

- (instancetype)initWithTitles:(NSArray *)titles
{
    self = [super init];
    if (self) {
        self.modalPresentationStyle = UIModalPresentationOverFullScreen;
        
        _titles = titles;
        _selectedRow = 0;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithWhite:.0f alpha:.5f];
    
    _contentContainer = [[UIView alloc] init];
    _contentContainer.backgroundColor = [UIColor whiteColor];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"리스트 선택";
    _titleLabel.textColor = [UIColor ff_c8Color];
    _titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:14.0f];
    
    _cancelButton = [[UIButton alloc] init];
    _cancelButton.backgroundColor = [UIColor ff_c1Color];
    _cancelButton.clipsToBounds = YES;
    _cancelButton.layer.cornerRadius = 5.0f;
    _cancelButton.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:14.0f];
    [_cancelButton setTitle:@"취소" forState:UIControlStateNormal];
    [_cancelButton setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchUpInside];
    
    _selectButton = [[UIButton alloc] init];
    _selectButton.backgroundColor = [UIColor ff_c1Color];
    _selectButton.clipsToBounds = YES;
    _selectButton.layer.cornerRadius = 5.0f;
    _selectButton.titleLabel.font = [UIFont appleSDGothicNeoMediumWithSize:14.0f];
    [_selectButton setTitle:@"선택" forState:UIControlStateNormal];
    [_selectButton setTitleColor:[UIColor ff_c5Color] forState:UIControlStateNormal];
    [_selectButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    
    _pickerView = [[UIPickerView alloc] init];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    
    [_contentContainer addSubview:_pickerView];
    [_contentContainer addSubview:_cancelButton];
    [_contentContainer addSubview:_titleLabel];
    [_contentContainer addSubview:_selectButton];
    [self.view addSubview:_contentContainer];
    
    [self makeConstraints];
}

#pragma mark - Layout

- (void)makeConstraints
{
    [super makeConstraints];
    
    [_contentContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(@.0f);
        make.height.equalTo(@276.0f);
    }];
    
    [_cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.equalTo(@10.0f);
        make.width.equalTo(@80.0f);
        make.height.equalTo(@40.0f);
    }];
    
    [_selectButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(@10.0f);
        make.right.equalTo(@(-10.0f));
        make.width.equalTo(@80.0f);
        make.height.equalTo(@40.0f);
    }];
    
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_cancelButton);
        make.centerX.equalTo(@.0f);
    }];
    
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.and.bottom.equalTo(@.0f);
        make.height.equalTo(@216.0f);
    }];
}

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _titles.count;
}

#pragma mark - Picker view delegate

- (NSString *)pickerView:(UIPickerView *)pickerView
             titleForRow:(NSInteger)row
            forComponent:(NSInteger)component
{
    return _titles[row];
}

- (void)pickerView:(UIPickerView *)pickerView
      didSelectRow:(NSInteger)row
       inComponent:(NSInteger)component
{
    _selectedRow = row;
}

#pragma mark - Action

- (void)cancel:(UIButton *)cancelButton
{
    if (_cancelHandler) {
        _cancelHandler();
    }
}

- (void)done:(UIButton *)selectButton
{
    if (_selectHandler) {
        _selectHandler(_selectedRow);
    }
}

#pragma mark - Setter

- (void)setTitle:(NSString *)title
{
    [super setTitle:title];
    _titleLabel.text = title;
}

@end
