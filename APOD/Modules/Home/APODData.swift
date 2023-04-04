//
//  APODData.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation

protocol APODData {
    var copyright: String? { get set }
    var date: String? { get set }
    var explanation: String? { get set }
    var hdurl: URL? { get set }
    var media_type: String? { get set }
    var service_version: String? { get set }
    var title: String? { get set }
    var url: URL? { get set }
}
