//
//  googlePathDrawViewController.h
//  Google Path
//
//  Created by apple on 04/08/14.
//  Copyright Jogendra.com All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import "LRouteController.h"

@interface googlePathDrawViewController : UIViewController<UITextFieldDelegate>{
    NSMutableArray *_coordinates;
    __weak GMSMapView *_mapView;
    LRouteController *_routeController;
    GMSPolyline *_polyline;
    GMSMarker *_markerStart;
    GMSMarker *_markerFinish;

}

@end
