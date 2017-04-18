//
//  UserHeaderCell.m
//  JRZN
//
//  Created by 曾国锐 on 16/6/3.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import "UserHeaderCell.h"

@implementation UserHeaderCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setUp];
    }
    return  self;
}

- (void)setUp{

    self.bgHeaderImageView = [UIImageView new];
    
    self.headerImageView = [UIImageView new];
    
    self.nickNameLabel = [UILabel new];
    
    self.signatureLabel = [UILabel new];
    
    NSArray *views = @[self.bgHeaderImageView, self.headerImageView, self.nickNameLabel, self.signatureLabel];
    
    [self.contentView sd_addSubviews:views];
    
    
    self.bgHeaderImageView.image = [UIImage imageNamed:@"person center_bg.png"];
    self.bgHeaderImageView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick)];
    [self.bgHeaderImageView addGestureRecognizer:tap];
    
    
    self.headerImageView.sd_cornerRadius = @40;
    self.headerImageView.layer.borderWidth = 1.0f;
    self.headerImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    if ([UserModel shareUserModelManager].userName.length > 0) {
        self.nickNameLabel.text = [UserModel shareUserModelManager].userName;
    }else{
        self.nickNameLabel.text = @"默认昵称";
    }
    
    self.nickNameLabel.textColor = [UIColor whiteColor];
    self.nickNameLabel.font = kMainFont;
    self.nickNameLabel.textAlignment = NSTextAlignmentCenter;
    
    self.signatureLabel.numberOfLines = 0;
    if ([UserModel shareUserModelManager].userSignature.length > 0) {
        self.signatureLabel.text = [UserModel shareUserModelManager].userSignature;
    }else{
        self.signatureLabel.text = @"个性签名";
    }
    
    self.signatureLabel.textColor = [UIColor colorWithWhite:0.836 alpha:1.000];
    self.signatureLabel.font = kDetailFont;
    self.signatureLabel.textAlignment = NSTextAlignmentCenter;
    self.signatureLabel.numberOfLines = 0;
    
    
    UIView *contentView = self.contentView;
    
    self.bgHeaderImageView.sd_layout
    .leftSpaceToView(contentView, 0)
    .rightSpaceToView(contentView, 0)
    .topSpaceToView(contentView, 0)
    .heightIs(264);
    
    self.headerImageView.sd_layout
    .centerXIs(WIDTH/2)
    .centerYIs(50+64)
    .heightIs(80)
    .widthIs(80);
    
    self.nickNameLabel.sd_layout
    .leftSpaceToView(contentView, 15)
    .rightSpaceToView(contentView, 15)
    .topSpaceToView(self.headerImageView, 10)
    .heightIs(20);
    
    self.signatureLabel.sd_layout
    .leftSpaceToView(contentView, 15)
    .rightSpaceToView(contentView, 15)
    .topSpaceToView(self.nickNameLabel, 10)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.bgHeaderImageView bottomMargin:0];
}

- (void)setModel:(UserModel *)model{

    if (model.headerImage) {
        self.headerImageView.image = model.headerImage;
    }else{
        self.headerImageView.image = HEADER_IMG;
    }
    
    if (model.userName.length) {
        self.nickNameLabel.text = model.userName;
    }else{
        self.nickNameLabel.text = @"默认昵称";
    }
    
    if (model.userSignature.length) {
        self.signatureLabel.text = model.userSignature;
    }else{
        self.signatureLabel.text = @"个性签名";
    }
}

- (void)tapClick{

    if ([self.delegate respondsToSelector:@selector(didSelectedHeader)]) {
        [self.delegate didSelectedHeader];
    }
}

@end
