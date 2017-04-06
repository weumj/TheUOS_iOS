//
//  AnnounceParser.swift
//  TheUOS
//
//  Created by MJ on 2017. 3. 26..
//  Copyright © 2017년 uoscs09. All rights reserved.
//

import Kanna
import RxSwift
import RxAlamofire
import Regex

class AnnounceParser {
    
    static func test() -> Observable<Announce> {
        return RxAlamofire.requestString(.get, "http://m.uos.ac.kr/mkor/notBoard/list.do?list_id=FA1")
            .map{HTML(html: $1, encoding: .utf8)}
            .do( onNext: {$0?.title}) // 하지 않으면 정상적으로 파싱이 되지 않음
            .map{$0?.css("#board_list ul")}
            .flatMap{Observable.from(optional: $0)}
            .flatMap{Observable.from($0)}
            .map{toAnnounceFrom(element:$0)}
            .observeOn(MainScheduler.instance)
    }
    
    static func toAnnounceFrom(element: XMLElement) -> Announce {
        let title = element.at_css(".list_title")?.text ?? ""
        
        let date = element.at_css(".date")?.text ?? ""
        
        let onClick = element.at_css(".list_warp")?["onclick"]
        
        let params = ("(\'\\d*\')".r?.findAll(in: onClick ?? ""))!
            .map{$0.matched.replacingOccurrences(of: "'", with: "")}
        
        var pageURL: String
        
        switch params.count {
        case 2:
            pageURL = "http://www.uos.ac.kr/korNotice/view.do?sort=\(params[0])&seq=\(params[1])&list_id="
            break
        case 3:
            pageURL = "http://m.uos.ac.kr/mkor/schBoard/view.do?sort=\(params[0])&seq=\(params[1])&board_id=\(params[2])"
            break
        default:
            pageURL = ""
            break
        }
        
        pageURL = pageURL + "FA1" // deb
        
        return Announce(title: title, date: date, pageURL: pageURL)
    }
}
