//
//  SwitchLotteryView.m
//  CP
//
//  Created by Apple on 2018/1/22.
//  Copyright © 2018年 Apple. All rights reserved.
//

#import "SwitchLotteryView.h"

@implementation SwitchLotteryViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        
        [self addSubview];
        [self layout];
    }
    return self;
}
- (void)addSubview{
    [self titleLabel];
}
- (void)layout{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
//        .insets(UIEdgeInsetsMake(0, NormalMargin/2, 0, NormalMargin/2));
    }];
}
- (void)setIsSel:(BOOL)isSel{
    _isSel = isSel;
    
    self.titleLabel.textColor = isSel ? [UIColor whiteColor] : TextGrayColor;
    self.titleLabel.backgroundColor = isSel ? LightMainColor : [UIColor whiteColor];
    self.titleLabel.layer.borderColor = isSel ? [UIColor clearColor].CGColor : SepColor.CGColor;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        UILabel *title = [[UILabel alloc]init];
        title.font = CPFont(13);
        title.layer.borderWidth = 0.5;
        title.clipsToBounds = YES;
        title.layer.cornerRadius = SRadius;
        title.textAlignment = NSTextAlignmentCenter;
        title.adjustsFontSizeToFitWidth = YES;
        title.baselineAdjustment = UIBaselineAdjustmentAlignCenters;
        [self.contentView addSubview:title];
        _titleLabel = title;
    }
    return _titleLabel;
}


@end


@interface SwitchLotteryView()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end
@implementation SwitchLotteryView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self addSubview];
        [self layout];
        self.isShow = NO;
        self.userInteractionEnabled = NO;
        self.bgView.userInteractionEnabled = NO;
    }
    return self;
}
- (void)setSelectedIndex:(NSInteger)selectedIndex{
    if(selectedIndex <= self.lotteryModels.count - 1){
        _selectedIndex = selectedIndex;
//        if(self.didSel)self.didSel(self, selectedIndex);
    }
}
- (void)addSubview{
    [self bgView];
    [self collectionView];
}
- (void)layout{
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        CGFloat n = (self.lotteryModels.count + 2) / 3;
        CGFloat h = n * PtOn47(36) + PtOn47(18) * (n+1);
        
        make.left.right.equalTo(self);
        make.height.mas_equalTo(h);
        make.top.equalTo(self).offset(-h);
    }];
}
- (void)setLotteryModels:(NSArray<LotteryModel *> *)lotteryModels{
    _lotteryModels = lotteryModels;
    
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        
        CGFloat n = (self.lotteryModels.count + 2) / 3;
        CGFloat h = n * PtOn47(36) + PtOn47(18) * (n+1);
        
        make.left.right.equalTo(self);
        make.height.mas_equalTo(h);
        make.top.equalTo(self).offset(-h);
    }];
    
    
    [self.collectionView reloadData];
}

- (void)show{
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(0);
    }];
    [UIView animateWithDuration:0.34 animations:^{
        [self layoutIfNeeded];
        self.bgView.alpha = 1;
    }completion:^(BOOL finished) {
        self.isShow = YES;
        self.userInteractionEnabled = YES;
        self.bgView.userInteractionEnabled = YES;
    }];
    
}
- (void)hide{
    
    
    if(self.didHide)self.didHide();
    
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        
        CGFloat n = (self.lotteryModels.count + 2) / 3;
        CGFloat h = n * PtOn47(36) + PtOn47(18) * (n+1);
        make.top.equalTo(self).offset(-h);
    }];
    
    [UIView animateWithDuration:0.34 animations:^{
        [self layoutIfNeeded];
        self.bgView.alpha = 0;
    }completion:^(BOOL finished) {
        self.isShow = NO;
        self.userInteractionEnabled = NO;
        self.bgView.userInteractionEnabled = NO;
    }];
}



- (void)tap{
    [self hide];
}
- (UIView *)bgView{
    if(!_bgView){
        UIView *bg = [[UIView alloc]init];
        bg.backgroundColor = CPRGBA(0, 0, 0, 0.4);
        [bg addTapGesture:self sel:@selector(tap)];
        bg.alpha = 0;
        [self addSubview:bg];
        _bgView = bg;
    }
    return _bgView;
}
static NSString *SwitchLotteryViewCellID = @"SwitchLotteryViewCell";
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = PtOn47(18);
        flowLayout.minimumInteritemSpacing = PtOn47(18);
        
        
        UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        collectionView.dataSource = self;
        collectionView.delegate = self;
        collectionView.contentInset = UIEdgeInsetsMake(PtOn47(18), PtOn47(18), PtOn47(18), PtOn47(18));
        collectionView.backgroundColor = [UIColor whiteColor];
        [collectionView registerClass:[SwitchLotteryViewCell class] forCellWithReuseIdentifier:SwitchLotteryViewCellID];
        [self addSubview:collectionView];
        _collectionView = collectionView;
    }
    return _collectionView;
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lotteryModels.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat w = (collectionView.width - PtOn47(18)*4) /3;
    return CGSizeMake(w, PtOn47(36));
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    SwitchLotteryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:SwitchLotteryViewCellID forIndexPath:indexPath];
    
    cell.titleLabel.text = self.lotteryModels[indexPath.row].title;
    cell.isSel = self.selectedIndex == indexPath.row;
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    self.selectedIndex = indexPath.row;
    [collectionView reloadData];
    if(self.didSel)self.didSel(self, self.selectedIndex);
    [self hide];
}

@end
