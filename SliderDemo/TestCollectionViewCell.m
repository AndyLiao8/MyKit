//
//  TestCollectionViewCell.m
//  SliderDemo
//
//  Created by apple on 15/11/10.
//  Copyright © 2015年 diveinedu. All rights reserved.
//

#import "TestCollectionViewCell.h"

@implementation TestCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        NSLog(@"%f",frame.size.width);
        _imageView = [[UIImageView alloc] initWithFrame:frame];
        _imageView.backgroundColor = [UIColor grayColor];
        [self addSubview:_imageView];
    }
    return self;
}
@end
