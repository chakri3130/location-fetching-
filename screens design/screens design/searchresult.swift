//
//  searchresult.swift
//  screens design
//
//  Created by chakravarthy on 19/11/17.
//  Copyright © 2017 chakravarthy. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import CoreLocation
class searchresult: UIViewController,UISearchBarDelegate,CLLocationManagerDelegate {
    
    let locationmanager = CLLocationManager()
    @IBAction func searchresult1(_ sender: Any) {
        let searchcontroller = UISearchController(searchResultsController: nil)
        searchcontroller.searchBar.delegate = self
        present(searchcontroller, animated: true, completion: nil)

    }
    @IBAction func routemap(_ sender: Any)
    {
        
        let latitude123:CLLocationDegrees = updatelatitude as! CLLocationDegrees
        let longitude123:CLLocationDegrees = updatelangitude as! CLLocationDegrees
        let regiondistance:CLLocationDistance = 1000
        let coordinates = CLLocationCoordinate2DMake(latitude123, longitude123)
        let region = MKCoordinateRegionMakeWithDistance(coordinates, regiondistance, regiondistance)
        let options = [MKLaunchOptionsMapCenterKey:NSValue(mkCoordinate:region.center),MKLaunchOptionsMapSpanKey:NSValue(mkCoordinateSpan:region.span)]
        let placemark = MKPlacemark(coordinate: coordinates)
        let mapitem = MKMapItem(placemark: placemark)
        mapitem.name = "my way"
        mapitem.openInMaps(launchOptions: options)
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        UIApplication.shared.beginIgnoringInteractionEvents()
        let activityindicator = UIActivityIndicatorView()
        activityindicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        activityindicator.center = self.view.center
        activityindicator.hidesWhenStopped = true
        activityindicator.stopAnimating()
        self.view.addSubview(activityindicator)

        //create the search result
        let searchresult = MKLocalSearchRequest()
        searchresult.naturalLanguageQuery = searchBar.text
        let activitysearch = MKLocalSearch(request: searchresult)
        activitysearch.start { (response, error) in
            activityindicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil
            {
                print("Error")
            }
            else
            {
             let annotations = self.mapview.annotations
                self.mapview.removeAnnotations(annotations)

                //getting data
                let lattitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                self.updatelangitude = longitude
                self.updatelatitude  = lattitude

                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(lattitude!, longitude!)
                self.mapview.addAnnotation(annotation)

                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(lattitude!, longitude!)
                let span = MKCoordinateSpanMake(lattitude!, longitude!)
                let  region = MKCoordinateRegionMake(coordinate, span)
                self.mapview.setRegion(region, animated: true)



            }
        }
    }
    @IBOutlet weak var mapview: MKMapView!
    
    var updatelangitude :Any = ""
    var updatelatitude :Any = ""
    override func viewDidLoad() {
        super .viewDidLoad()
        locationmanager.delegate = self
        locationmanager.desiredAccuracy = kCLLocationAccuracyBest
        locationmanager.requestAlwaysAuthorization()
        locationmanager.startUpdatingLocation()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        let span:MKCoordinateSpan = MKCoordinateSpanMake(location.coordinate.latitude, location.coordinate.latitude)
        let mylocation:CLLocationCoordinate2D   = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        
        let region:MKCoordinateRegion = MKCoordinateRegionMake(mylocation, span)
        mapview.setRegion(region, animated: true)
        self.mapview.showsUserLocation = true
        
    }
}
