//
//  ViewController.m
//  SwellPro
//
//  Created by MM on 2018/1/2.
//  Copyright © 2018年 MM. All rights reserved.
//

#import "ViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>
#import "MMLocationConverter.h"
#import "MarkDetail.h"


@interface ViewController ()<CLLocationManagerDelegate,GMSMapViewDelegate>
{
    GMSMapView *mapView;
    CLLocationManager *locationManager;
    CLLocationCoordinate2D currentCoordinate;
}
//标记标记点
@property (nonatomic,assign) NSInteger count;
//标记数组
@property (nonatomic,strong) NSMutableArray *markArray;
@end

@implementation ViewController
- (NSMutableArray *)markArray
{
    if (_markArray == nil) {
        _markArray = [NSMutableArray array];
    }
    return _markArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createMapView];
    
//    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:39.957618
//                                                            longitude:116.428319
//                                                                 zoom:14];
//    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//    self.view = mapView;
//
//    GMSMarker *marker = [[GMSMarker alloc] init];
//    marker.position = CLLocationCoordinate2DMake(22.290664, 114.195304);
//    marker.title = @"香港";
//    marker.snippet = @"Hong Kong";
//    marker.map = mapView;
    /*
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //定位管理器
    locationManager=[[CLLocationManager alloc]init];
    //如果没有授权则请求用户授权
    if ([CLLocationManager authorizationStatus]==kCLAuthorizationStatusNotDetermined){
        [locationManager requestWhenInUseAuthorization];
    }else if([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedWhenInUse){
        //设置代理
        locationManager.delegate=self;
        //设置定位精度
        locationManager.desiredAccuracy=kCLLocationAccuracyBest;
        //定位频率,每隔多少米定位一次
        CLLocationDistance distance=10.0;//十米定位一次
        locationManager.distanceFilter=distance;
        //启动跟踪定位
        [locationManager startUpdatingLocation];
    }
    */
    
}
- (void)createMapView{
    /*
     地图初始化
     **/
    mapView = [[GMSMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    mapView.delegate = self;
    mapView.indoorEnabled = NO;//设置室内地图是否显示在哪里。默认值为YES
    mapView.settings.rotateGestures = NO;//控制是否启用了旋转手势(默认)或禁用。如果启用后，用户可以使用一个双手指旋转手势来旋转相机。这不限制对相机轴承的编程式控制。
    mapView.settings.tiltGestures = NO;//控制倾斜手势是否启用(默认)或禁用。如果启用,用户可以使用两指垂直向下或向上滑动来倾斜相机。这不限制相机的取景角的编程式控制。
    mapView.settings.myLocationButton = NO;//启用或禁用我的位置按钮。这是一个可以看到的按钮当用户点击时，地图会显示当前用户的地图位置。
    mapView.myLocationEnabled = YES;//控制是否启用了我的位置点和精度圆。默认为没有。
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate  = self;
    [locationManager requestWhenInUseAuthorization];
    [self.view addSubview:mapView];
    
}
#pragma mark - CLLocationManagerDelegate
//- (void)locationManager:(CLLocationManager *)manager
//     didUpdateLocations:(NSArray *)locations
//{
//    if ([sosdic[@"maptype"] intValue]==1) {
//    if (1) {//选择谷歌地图
//        CLLocation *curLocation = [locations lastObject];
//        //    通过location  或得到当前位置的经纬度
//        CLLocationCoordinate2D curCoordinate2D=curLocation.coordinate;
//        NSLog(@"latitude:%f,longitude:%f",curCoordinate2D.latitude,curCoordinate2D.longitude);
//        BOOL ischina = [[ZCChinaLocation shared] isInsideChina:(CLLocationCoordinate2D){curCoordinate2D.latitude,curCoordinate2D.longitude}];
//        if (!ischina) {
//            [self googleLocation:curCoordinate2D];
//        }else{
//            CLLocationCoordinate2D curCoordinate = [MMLocationConverter transformFromWGSToGCJ:curCoordinate2D];
//            [self googleLocation:curCoordinate];
//        }
//    }
//}2
//- (void)googleLocation:(CLLocationCoordinate2D)curCoordinate2D;
//{
//    dispatch_async(dispatch_get_main_queue(), ^{
//        [mapView clear];
//        GMSMarker *marker = [[GMSMarker alloc] init];
//        marker.position = CLLocationCoordinate2DMake(curCoordinate2D.latitude, curCoordinate2D.longitude);
//        marker.title = @"香港";
//        marker.snippet = @"Hong Kong";
//        marker.map = mapView;
//    });
//}

#pragma mark - CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    /**
     *    拿到授权发起定位请求
     
     */
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [locationManager startUpdatingLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    /**
     * 位置更新时调用
     */
    CLLocation *currentLocation_1 = locations.firstObject;
    //反向地理编码
//    [[GMSGeocoder geocoder]reverseGeocodeCoordinate:currentLocation_1.coordinate completionHandler:^(GMSReverseGeocodeResponse * response, NSError * error) {
//        if (response.results) {
            CLLocationCoordinate2D currentLocation_2;
//            GMSAddress *address = response.results[0];
//            if ([address.country isEqualToString:@"中国"]) {
//                currentLocation_2 = [MMLocationConverter transformFromWGSToGCJ:currentLocation_1.coordinate];
//            }else{
                currentLocation_2 = currentLocation_1.coordinate;
//            }
            currentCoordinate = currentLocation_2;
            //如果位置暂时没有变,那就不更新
            if (mapView.camera.target.latitude == currentLocation_2.latitude &&
                mapView.camera.target.longitude == currentLocation_2.longitude) {
                return ;
            }
            
            GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:currentLocation_2 zoom:16];
    
            [mapView animateToCameraPosition:camera];
    
//            GMSMarker *marker = [[GMSMarker alloc] init];
//            marker.position = CLLocationCoordinate2DMake(currentLocation_2.latitude, currentLocation_2.longitude);
//            marker.icon = [UIImage imageNamed:@"map_currentlocation"];
//            //    marker.title = @"香港";
//            //    marker.snippet = @"Hong Kong";
//            marker.map = mapView;
//        }
//    }];


}

//添加大头针
- (void)addAnnotionWith:(NSArray *)array{
    for (NSDictionary * dic in array){
        float lat = [[NSString stringWithString:dic[@"lat"]] floatValue];
        float lng = [[NSString stringWithString:dic[@"log"]] floatValue];
        GMSMarker *marker = [[GMSMarker alloc] init];
        marker.appearAnimation = kGMSMarkerAnimationPop;
        marker.position = CLLocationCoordinate2DMake(lat, lng);
        marker.icon = [UIImage imageNamed:@"map_location_blue"];
        //    marker.snippet = @"Australia";
        marker.map = mapView;
    }
}
#pragma  mark - Mapview Delegate
#pragma mark 点击地图时调用
- (void)mapView:(GMSMapView *)mapView didTapAtCoordinate:(CLLocationCoordinate2D)coordinate{
    
    [mapView clear];
    NSLog(@"lat:%f,log:%f",coordinate.latitude,coordinate.longitude);
    GMSMarker *marker = [[GMSMarker alloc] init];
    marker.position = CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude);
    marker.icon = [UIImage imageNamed:@"map_location_blue"];
//    marker.title = @"香港";
//    marker.snippet = @"Hong Kong";
    marker.map = mapView;
    MarkDetail *markTop = [[MarkDetail alloc] initWithFrame:CGRectMake(-50, -50, 100, 80)];
    [marker.iconView addSubview:markTop];
    
    
    //划线
    GMSMutablePath * gmspath=[GMSMutablePath path];
    [gmspath addCoordinate:CLLocationCoordinate2DMake(currentCoordinate.latitude, currentCoordinate.longitude)];
    [gmspath addCoordinate:CLLocationCoordinate2DMake(coordinate.latitude, coordinate.longitude)];
    GMSPolyline *polyline = [GMSPolyline polylineWithPath:gmspath];
    polyline.strokeColor = [UIColor colorWithRed:0/225 green:167/225 blue:243/225 alpha:1];
    polyline.map = mapView;
    
    
//    [self.markArray addObject:@{@"lat":[NSString stringWithFormat:@"%.6f",coordinate.latitude],@"log":[NSString stringWithFormat:@"%.6f",coordinate.longitude]}];
}
#pragma mark 镜头即将移动时调用
- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture{
    NSLog(@"willMove");
}
#pragma mark 镜头移动完成后调用
- (void)mapView:(GMSMapView *)mapView didChangeCameraPosition:(GMSCameraPosition *)position{
//    //反向地理编码
//    [[GMSGeocoder geocoder]reverseGeocodeCoordinate:position.target completionHandler:^(GMSReverseGeocodeResponse * response, NSError * error) {
//        if (response.results) {
//            GMSAddress *address = response.results[0];
//            NSLog(@"%@",address.thoroughfare);
//
//        }
//    }];
}
#pragma mark 大头针拖拽完成时调用
- (void)mapView:(GMSMapView *)mapView didEndDraggingMarker:(GMSMarker *)marker
{
    
}

@end
