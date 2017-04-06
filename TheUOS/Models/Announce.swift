//
//  Announce.swift
//  TheUOS
//
//  Created by MJ on 2017. 3. 26..
//  Copyright © 2017년 uoscs09. All rights reserved.
//

struct Announce {
    enum Category: String{
        case GENERAL = "FA1"  // 일반공지
        case AFFAIRS = "FA2" // 학사공지
        case SCHOLARSHIP = "SCHOLARSHIP" // 장학공지
        case EMPLOY = "FA34" // 채용공지
    }
    
    let title: String
    let date: String
    let pageURL: String
    
    init(title: String, date: String, pageURL: String){
        self.title = title
        self.date = date
        self.pageURL = pageURL
    }
}
