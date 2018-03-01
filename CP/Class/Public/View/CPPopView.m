
//
//  CPPopView.m
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "CPPopView.h"
#define PopUpViewArrowHeight PtOn47(10)
#define PopUpViewArrowWidth PtOn47(20)
#define PopUpViewMargin 0
#define PopUpViewWidth PtOn47(130)

#define LRMargin  PtOn47(10)


@implementation CPPopViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addSubview];
        [self layout];
        
    }
    return self;
}
- (void)addSubview{
    [self titleLabel];
}
- (void)layout{
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.contentView);
        make.width.mas_equalTo(PtOn47(40));
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).insets(UIEdgeInsetsMake(0, PtOn47(40), 0, PtOn47(10)));
    }];
}
- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(15);
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        title.textColor = TextDarkGrayColor;
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}

- (UIImageView *)iconView{
    if (!_iconView) {
        UIImageView *icon = [[UIImageView alloc]init];
        icon.clipsToBounds = YES;
        //        icon.layer.cornerRadius = 0.f;
        icon.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:icon];
        _iconView = icon;
    }
    return _iconView;
}
@end
//==================================================================================================================
@interface CPPopMainView()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation CPPopMainView



- (void)layout{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(PtOn47(10), PtOn47(5), PtOn47(5), PtOn47(5)));
    }];
    
    
    
}

- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    [self.tableView reloadData];
}


- (void)drawRect:(CGRect)rect{

    [[UIColor whiteColor]set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    path.lineWidth = 10.f;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;


    CGFloat selfW = rect.size.width;
    CGFloat ptX = 0;
    ptX = [Utility getMidWithMax:self.width   min:0 ratio:self.ArrowXPercent];
    if(ptX > self.width - (PopUpViewMargin + PopUpViewArrowWidth /2 )){
        ptX = self.width - (PopUpViewMargin + PopUpViewArrowWidth /2) - LRMargin;
    }
    if(ptX < PopUpViewMargin + PopUpViewArrowWidth / 2){
        ptX = PopUpViewMargin + PopUpViewArrowWidth /2 ;
    }
//    if(self.clickPosition.x < selfW/2){
//        ptX = MAX(PopUpViewArrowHeight, self.clickPosition.x);
//    }else if (self.clickPosition.x > self.onViewRect.size.width - selfW/2){
//        ptX = MIN(self.clickPosition.x , self.onViewRect.size.width-PopUpViewArrowHeight);
//    }else{
//        ptX = selfW / 2;
//    }
    UIBezierPath *round;
    if(self.arrowDirection == CPPopViewArrowDirectionTop){
//    if(self.onViewRect.size.height/2 > self.clickPosition.y){
        //        [path moveToPoint   :CGPointMake(0, PopUpViewArrowHeight)];
        //        [path addLineToPoint:CGPointMake(ptX-PopUpViewArrowHeight, PopUpViewArrowHeight)];
        //        [path addLineToPoint:CGPointMake(ptX, 0)];
        //        [path addLineToPoint:CGPointMake(ptX+PopUpViewArrowHeight,  PopUpViewArrowHeight)];
        //        [path addLineToPoint:CGPointMake(rect.size.width, PopUpViewArrowHeight)];
        //        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height)];
        //        [path addLineToPoint:CGPointMake(0,  rect.size.height)];

        [path moveToPoint   :CGPointMake(ptX-PopUpViewArrowWidth/2, PopUpViewArrowHeight)];
        [path addLineToPoint:CGPointMake(ptX, 0)];
        [path addLineToPoint:CGPointMake(ptX+PopUpViewArrowWidth/2,  PopUpViewArrowHeight)];


        round = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, PopUpViewArrowHeight, selfW, rect.size.height-PopUpViewArrowHeight) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];

    }else{

        //        [path moveToPoint   :CGPointMake(0, 0)];
        //        [path addLineToPoint:CGPointMake(rect.size.width, 0)];
        //        [path addLineToPoint:CGPointMake(rect.size.width, rect.size.height-PopUpViewArrowHeight)];
        //        [path addLineToPoint:CGPointMake(ptX+PopUpViewArrowHeight,  rect.size.height-PopUpViewArrowHeight)];
        //        [path addLineToPoint:CGPointMake(ptX, rect.size.height)];
        //        [path addLineToPoint:CGPointMake(ptX-PopUpViewArrowHeight, rect.size.height-PopUpViewArrowHeight)];
        //        [path addLineToPoint:CGPointMake(0,  rect.size.height-PopUpViewArrowHeight)];


        [path moveToPoint   :CGPointMake(ptX+PopUpViewArrowWidth/2,  rect.size.height-PopUpViewArrowHeight)];
        [path addLineToPoint:CGPointMake(ptX, rect.size.height)];
        [path addLineToPoint:CGPointMake(ptX-PopUpViewArrowWidth/2, rect.size.height-PopUpViewArrowHeight)];

        round = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, selfW, rect.size.height-PopUpViewArrowHeight) byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(5, 5)];
    }
    [round fill];

    [path closePath];
    //    [path stroke];
    [path fill];
}


- (void)setArrowDirection:(CPPopViewArrowDirection)arrowDirection{
    _arrowDirection = arrowDirection;
    
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).insets(UIEdgeInsetsMake(arrowDirection == CPPopViewArrowDirectionTop ? PopUpViewArrowHeight + PopUpViewMargin : PopUpViewMargin,
                                                         arrowDirection == CPPopViewArrowDirectionLeft ? PopUpViewArrowHeight + PopUpViewMargin : PopUpViewMargin,
                                                         arrowDirection == CPPopViewArrowDirectionBottom ? PopUpViewArrowHeight + PopUpViewMargin : PopUpViewMargin,
                                                         arrowDirection == CPPopViewArrowDirectionRight ? PopUpViewArrowHeight + PopUpViewMargin : PopUpViewMargin));
    }];

}


static NSString *CPPopViewCellID = @"CPPopViewCell";
- (UITableView *)tableView{
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.bounces = NO;
        tableView.separatorColor = SepColor;
        tableView.layer.cornerRadius = 5;
        tableView.clipsToBounds = YES;
//        tableView.backgroundColor = [UIColor redColor];
        if (@available(iOS 11, *)) {
            tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        
        [tableView registerClass:[CPPopViewCell class] forCellReuseIdentifier:CPPopViewCellID];
        [self addSubview:tableView];
        _tableView = tableView;
    }
    return _tableView;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return PtOn47(44);
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CPPopViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CPPopViewCellID forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    cell.iconView.image = [UIImage imageNamed:self.images[indexPath.row]];
    cell.backgroundColor = [UIColor clearColor];
    cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if(self.selectAtIndex)self.selectAtIndex(indexPath.row);
}

@end

//==================================================================================================================
@interface CPPopView()
@property(nonatomic, strong) UIView *verLine;
@end
@implementation CPPopView

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        UIWindow *window=((AppDelegate*)[[UIApplication sharedApplication] delegate]).window;
        self.frame =window.bounds;
        [window addSubview:self];
        
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self);
        }];
        
    }
    return self;
}
- (void)setTitles:(NSArray *)titles{
    _titles = titles;
    self.mainView.titles = titles;
}
- (void)setImages:(NSArray<NSString *> *)images{
    _images = images;
    self.mainView.images = images;
}
- (UIView *)verLine{
    if(!_verLine){
        _verLine = [[UIView alloc]init];
        _verLine.backgroundColor = [UIColor blueColor];
        [self addSubview:_verLine];
    }
    return _verLine;
}

- (CPPopMainView *)mainView{
    if(!_mainView){
        CPPopMainView *pop = [[CPPopMainView alloc]init];
        pop.backgroundColor = [UIColor clearColor];
        [self addSubview:pop];
        _mainView = pop;
    }
    return _mainView;
}
- (UIView *)bgView{
    if(!_bgView){
        UIView *bg = [[UIView alloc]init];
        bg.backgroundColor = CPRGBA(0, 0, 0, 0);
        [bg addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)]];
        [self addSubview:bg];
        _bgView = bg;
    }
    return _bgView;
}
- (void)tap{
    [self hide];
}
- (void)show{
    [self a];
    
    
    self.mainView.transform = CGAffineTransformMakeScale(0.7, 0.7);
    [UIView animateWithDuration:0.1 animations:^{
        self.bgView.backgroundColor = CPRGBA(0, 0, 0, 0.1);
        self.mainView.transform = CGAffineTransformMakeScale(1.05, 1.05);
    } completion:^(BOOL finished) {
        // 完成后要将视图还原
        // CGAffineTransformIdentity
        [UIView animateWithDuration:0.1 animations:^{
            self.mainView.transform = CGAffineTransformIdentity;
            self.bgView.backgroundColor = CPRGBA(0, 0, 0, 0.2);
        }];
    }];
    
}
- (void)hide{
    [UIView animateWithDuration:0.2 animations:^{
        self.bgView.backgroundColor = CPRGBA(0, 0, 0, 0);
        
        self.mainView.transform = CGAffineTransformMakeScale(0.6, 0.6);
        self.mainView.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)setClickPosition:(CGPoint)clickPosition{
    _clickPosition = clickPosition;
    
    
}
- (void)a{
    
    
    
    
    
    
//    NSLog(@"\nx = %f\ny = %f\n\n",self.clickPosition.x,self.clickPosition.y);
    
    
//    [self.verLine mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self).multipliedBy(_clickPosition.x / self.width * 2);
//        make.width.mas_equalTo(2);
//        make.top.height.equalTo(self);
//    }];
    
    
    
    CGFloat height = MIN(10,self.titles.count) * RowH + PopUpViewArrowHeight + PopUpViewMargin * 2;
//    height = 200;
    
    
    if(self.height - self.clickPosition.y < height + 50){
        self.mainView.arrowDirection = CPPopViewArrowDirectionBottom;
    }else{
        self.mainView.arrowDirection = CPPopViewArrowDirectionTop;
    }
    
    CGFloat xPercent = 0;
    CGFloat ptX1 = LRMargin + PopUpViewMargin + PopUpViewArrowWidth / 2;
    CGFloat ptX2 = LRMargin + PopUpViewWidth / 2;
    CGFloat ptX3 =  self.width - ptX2;
    CGFloat ptX4 =  self.width - ptX1;
    
    if(_clickPosition.x < ptX1){
        xPercent = 0;
//        NSLog(@"\n最左\n");
    }else if(_clickPosition.x < ptX2){
        xPercent = [Utility getRatioWithMax:ptX2 min:ptX1 mid:_clickPosition.x]/2;
//        NSLog(@"\n左边\n");
    }else if(_clickPosition.x > ptX4){
        xPercent = 1;
//        NSLog(@"\n最右\n");
    }else if(_clickPosition.x > ptX3){
        xPercent = [Utility getRatioWithMax:ptX4 min:ptX3 mid:_clickPosition.x]/2 +0.5;
        
//        NSLog(@"\n右边\n");
    }else{
        xPercent = 0.5;
//        NSLog(@"\n中间\n");
    }
    self.mainView.ArrowXPercent = xPercent;
    
    NSLog(@"\nxPercent = %f\n\n\n",xPercent);
    
    if(xPercent < 0.5){
        
        if(self.mainView.arrowDirection == CPPopViewArrowDirectionBottom){
            [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(LRMargin);
                make.width.mas_equalTo(PopUpViewWidth);
                make.height.mas_equalTo(height);
                make.top.equalTo(self).offset(_clickPosition.y - height);

                
            }];
        }else{
            [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self).offset(LRMargin);
                make.width.mas_equalTo(PopUpViewWidth);
                make.height.mas_equalTo(height);
                make.top.equalTo(self).offset(_clickPosition.y);
                
            }];
        }
    }else if(xPercent > 0.5){
        if(self.mainView.arrowDirection == CPPopViewArrowDirectionBottom){
            [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-LRMargin);
                make.width.mas_equalTo(PopUpViewWidth);
                make.height.mas_equalTo(height);
                make.top.equalTo(self).offset(_clickPosition.y - height);
            }];
        }else {
            [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.equalTo(self).offset(-LRMargin);
                make.width.mas_equalTo(PopUpViewWidth);
                make.height.mas_equalTo(height);
                make.top.equalTo(self).offset(_clickPosition.y);
            }];
        }
    }else{
        
        if(self.mainView.arrowDirection == CPPopViewArrowDirectionBottom){
            [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).multipliedBy(_clickPosition.x / self.width * 2);
                make.width.mas_equalTo(PopUpViewWidth);
                make.height.mas_equalTo(height);
                make.top.equalTo(self).offset(_clickPosition.y - height);
            }];
        }else{
            
            [self.mainView mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerX.equalTo(self).multipliedBy(_clickPosition.x / self.width * 2);
                make.width.mas_equalTo(PopUpViewWidth);
                make.height.mas_equalTo(height);
                make.top.equalTo(self).offset(_clickPosition.y);
            }];
        }
        
    }
}

+ (void)showWithPosition:(CGPoint)pt images:(NSArray <NSString *>*)images titles:(NSArray <NSString *>*)titles clickAtIndex:(BOOL(^)(NSInteger index))selectAtIndex{
    CPPopView *pop = [[CPPopView alloc]init];
    pop.clickPosition = pt;
    pop.titles = titles;
    pop.images = images;
    pop.selectAtIndex = selectAtIndex;
    [pop show];
}
- (void)setSelectAtIndex:(BOOL (^)(NSInteger))selectAtIndex{
    _selectAtIndex = selectAtIndex;
    self.mainView.selectAtIndex = ^BOOL(NSInteger index) {
        if(self.selectAtIndex)
            if(self.selectAtIndex(index))
                [self hide];
        return YES;
        
    };
}


@end
