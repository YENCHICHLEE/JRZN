//
//  FilterModel.h
//  JRZN
//
//  Created by 曾国锐 on 16/6/13.
//  Copyright © 2016年 曾国锐. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FilterModel : NSObject

/**
 *  分类名称
 */
@property (nonatomic, copy) NSString *categoryName;

/**
 *  分类详情列表
 */
@property (nonatomic, strong) NSMutableArray *categoryDetailListArray;
/**
 *  按钮tag
 */
@property (nonatomic, assign) NSInteger categoryButtonTag;
/**
 *  选中按钮
 */
@property (nonatomic, assign) NSInteger selectButton;
@end
