//
//  APODResponseModel.swift
//  APOD
//
//  Created by Yuvrajsinh Jadeja on 04/04/23.
//

import Foundation

struct APODResponseModel: APODData, Codable {
    var copyright: String?
    var date: String?
    var explanation: String?
    var hdurl: URL?
    var media_type: String?
    var service_version: String?
    var title: String?
    var url: URL?
}
