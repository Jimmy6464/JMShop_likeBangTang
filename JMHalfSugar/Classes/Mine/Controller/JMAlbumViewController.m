//
//  JMAlbumViewController.m
//  JMHalfSugar
//
//  Created by Jimmy on 16/6/30.
//  Copyright © 2016年 HDCircles. All rights reserved.
//

#import "JMAlbumViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>

#import "JMAlbumsCell.h"
@interface JMAlbumViewController ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
//当前collectionview用到的PHAssetCollection
@property (nonatomic, strong)PHFetchResult *currentPhotoData;
//相机管理类
@property (nonatomic, strong)PHCachingImageManager *imageManager;
//展示图片collectionview
@property (nonatomic, weak)UICollectionView *showCollectionView;
//加载图片的一些参数PHImageRequestOptions
@property (nonatomic, strong)PHImageRequestOptions *imageRequestOptions;

@end

@implementation JMAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self readImagesFromAlbum];
    [self initializedSubviews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)readImagesFromAlbum
{
    //get author
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusRestricted || status == PHAuthorizationStatusDenied || status == PHAuthorizationStatusNotDetermined) {
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            NSLog(@"done");
        }];
    }else if (status == PHAuthorizationStatusAuthorized){
        //list all albums
        PHFetchResult* smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
        self.imageManager = [PHCachingImageManager new];
        PHFetchOptions *options = [PHFetchOptions new];
        options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
        self.imageRequestOptions = [PHImageRequestOptions new];
        //load high quality photo
        self.imageRequestOptions.deliveryMode = PHImageRequestOptionsDeliveryModeHighQualityFormat;
        self.imageRequestOptions.version = PHImageRequestOptionsVersionOriginal;
        
        //
        for (NSInteger i = 0; i < smartAlbums.count; i++) {
            PHAssetCollection *assetCollection = smartAlbums[i];

            if ([assetCollection.localizedTitle isEqualToString:@"相机胶卷"] || [assetCollection.localizedTitle isEqualToString:@"Camera Roll"]) {
                self.currentPhotoData = [PHAsset fetchAssetsInAssetCollection:assetCollection options:options];
            }
        }
        
    }
}
- (void)initializedSubviews
{
    //NavigationBarItem
    UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancelClicked)];
    self.navigationItem.leftBarButtonItem = cancelItem;
    UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc]initWithTitle:@"确认" style:UIBarButtonItemStyleDone target:self action:nil];
    self.navigationItem.rightBarButtonItem = confirmItem;
    
    //
    UICollectionViewFlowLayout *flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumInteritemSpacing = 2;
    flowLayout.minimumLineSpacing = 4;
    
    UICollectionView *showCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, JMDeviceWidth, JMDeviceHeight-64) collectionViewLayout:flowLayout];
    showCollectionView.backgroundColor = [UIColor whiteColor];
    [showCollectionView registerClass:[JMAlbumsCell class] forCellWithReuseIdentifier:@"JMAlbumsCell"];
    showCollectionView.delegate = self;
    showCollectionView.dataSource = self;
    [self.view addSubview:showCollectionView];
    _showCollectionView = showCollectionView;
}
#pragma mark - navigationBarItem
- (void)cancelClicked
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (self.currentPhotoData != nil && self.currentPhotoData.count > 0) {
        return 1+self.currentPhotoData.count;
    }else {
        return 1;
    }
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JMAlbumsCell *cell = [JMAlbumsCell cellWithCollectionView:collectionView atIndexPath:indexPath andImage:nil];
    if (indexPath.item != 0) {
        PHAsset *assets = self.currentPhotoData[indexPath.item - 1];
        [self.imageManager requestImageForAsset:assets targetSize:CGSizeMake(103, 103) contentMode:PHImageContentModeAspectFill options:self.imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            cell.image = result;
        }];
    }else {
        cell.image = nil;
    }
    return cell;
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(206/2, 206/2);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(4, 2, 0, 2);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item == 0) {
        
        [self dismissViewControllerAnimated:YES completion:^{
            [JMNotificationCenter postNotificationName:JMOpenTheCamera object:nil];
        }];
        return;
    }
    PHAsset *assets = self.currentPhotoData[indexPath.item - 1];
    [self.imageManager requestImageForAsset:assets targetSize:CGSizeMake(103, 103) contentMode:PHImageContentModeAspectFill options:self.imageRequestOptions resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
        [JMNotificationCenter postNotificationName:JMChangeAvatar object:nil userInfo:@{@"image":result}];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self dismissViewControllerAnimated:YES completion:nil];
        });
    }];
}
@end
