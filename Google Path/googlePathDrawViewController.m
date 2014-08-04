//
//  googlePathDrawViewController.m
//  Google Path
//
//  Created by apple on 04/08/14.
//  Copyright Jogendra.com All rights reserved.
//

#import "googlePathDrawViewController.h"

@interface googlePathDrawViewController (){
     UITextField *endLocationText;
    UITextField * startLocationText;
}

@end

@implementation googlePathDrawViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _coordinates = [NSMutableArray new];
    _routeController = [LRouteController new];
//Create map here..
     _mapView = [GMSMapView mapWithFrame:self.view.bounds camera:nil];
    //_mapView.myLocationEnabled = YES;
  //  _mapView.delegate = self;
     [self.view addSubview:_mapView];
    
//Calling Function Here..
    [self pathdrawingOnGoolgeMap];
   
}
 -(void)pathdrawingOnGoolgeMap  {
    _polyline.map = nil;
    _markerStart.map = nil;
    _markerFinish.map = nil;
    [_mapView clear];
    

    _coordinates = [NSMutableArray new];
//Set Here your start location
    CLLocation *startLocation = [[CLLocation alloc] initWithLatitude:26.904787 longitude:75.739823];
    [_coordinates addObject:startLocation];
     
//Set Here your End Location location
    CLLocation *endLocation = [[CLLocation alloc] initWithLatitude:26.894836 longitude:75.832691];
    [_coordinates addObject:endLocation];
    

    
    
    if ([_coordinates count] > 1)
    {
        [_routeController getPolylineWithLocations:_coordinates travelMode:TravelModeWalking andCompletitionBlock:^(GMSPolyline *polyline, NSError *error) {
            if (error)
            {
                NSLog(@"%@", error);
            }
            else if (!polyline)
            {
                NSLog(@"No route");
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Sorry !!" message:@"No Route found" delegate:Nil cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
                [alert show];
                [_coordinates removeAllObjects];
            }
            else
            {
                //Here Mark make
                 GMSMarker *mkr= [[GMSMarker alloc]init];
                [mkr setPosition:[[_coordinates objectAtIndex:0] coordinate]];
                [mkr setTitle:@"Start"];
                //   [mkr setSnippet:@"supar"];
                //  [mkr setDraggable:YES];
                [mkr setMap:_mapView];
                
                
                GMSMarker *mkr2= [[GMSMarker alloc]init];
                [mkr2 setPosition:[[_coordinates lastObject] coordinate]];
                [mkr2 setTitle:@"End"];
                // [mkr2 setDraggable:YES];
                // [mkr2 setSnippet:@"Dupar"];
                [mkr2 setMap:_mapView];
                
                //route line custimize
                 _polyline = polyline;
                 _polyline.strokeWidth = 5;
                _polyline.strokeColor = [UIColor blueColor];
                _polyline.map = _mapView;
            }
        }];
    }
    
     //It's camera zooming / Showing map between screen
    CLLocationCoordinate2D Startposition = CLLocationCoordinate2DMake(startLocation.coordinate.latitude, startLocation.coordinate.longitude);
     
    CLLocationCoordinate2D Endposition = CLLocationCoordinate2DMake(endLocation.coordinate.latitude, endLocation.coordinate.longitude);
     
      GMSCoordinateBounds *bounds =  [[GMSCoordinateBounds alloc]  initWithCoordinate:Startposition coordinate:Endposition];
     bounds = [bounds includingCoordinate:Startposition];
     bounds = [bounds includingCoordinate:Endposition];
     GMSCameraUpdate *update = [GMSCameraUpdate fitBounds:bounds withPadding:15];
     [_mapView animateWithCameraUpdate:update];
    
}
 - (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
