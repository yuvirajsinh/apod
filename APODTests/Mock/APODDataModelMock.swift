//
//  APODDataModelMock.swift
//  APODTests
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation
@testable import APOD

extension APODResponseModel {
    static var mockData: APODResponseModel {
        APODResponseModel(
            date: "2023-04-03",
            explanation: "What causes this unusual curving structure near the center of our Galaxy? The long parallel rays slanting across the top of the featured radio image are known collectively as the Galactic Center Radio Arc and point out from the Galactic plane.  The Radio Arc is connected to the Galactic Center by strange curving filaments known as the Arches.  The bright radio structure at the bottom right surrounds a black hole at the Galactic Center and is known as Sagittarius A*.  One origin hypothesis holds that the Radio Arc and the Arches have their geometry because they contain hot plasma flowing along lines of a constant magnetic field.  Images from NASA\'s Chandra X-ray Observatory appear to show this plasma colliding with a nearby cloud of cold gas.",
            title: "The Galactic Center Radio Arc"
        )
    }
}
