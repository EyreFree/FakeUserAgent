//
//  FakeUserAgent.swift
//  FakeUserAgent
//
//  Created by EyreFree on 2023/5/12.
//
//  Copyright (c) 2017-2021 EyreFree <eyrefree@eyrefree.org>
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public struct BrowserOptions: OptionSet {
    public let rawValue: UInt
    public init(rawValue: Self.RawValue) {
        self.rawValue = rawValue
    }
    
    public static let chrome = BrowserOptions(rawValue: 1 << 0)
    public static let opera = BrowserOptions(rawValue: 1 << 1)
    public static let firefox = BrowserOptions(rawValue: 1 << 2)
    public static let safari = BrowserOptions(rawValue: 1 << 3)
    public static let edge = BrowserOptions(rawValue: 1 << 4)
    public static let internetExplorer = BrowserOptions(rawValue: 1 << 5)
    
    public static let all: BrowserOptions = [.chrome, .opera, .firefox, .safari, .edge, .internetExplorer]
}

public class BrowsersModel: Codable {
    public var chrome: [String] = []
    public var opera: [String] = []
    public var firefox: [String] = []
    public var safari: [String] = []
    public var edge: [String] = []
    public var internetExplorer: [String] = []
    
    public enum CodingKeys: String, CodingKey {
        case chrome
        case opera
        case firefox
        case safari
        case edge
        case internetExplorer
    }
}

public class FakeUserAgent {
    
    public static let shared = FakeUserAgent()
    
    public let userAgents: BrowsersModel = {
        if let jsonPath = Bundle(for: FakeUserAgent.self).path(forResource: "browsers", ofType: "json"),
           let data: Data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)) {
            let decoder = JSONDecoder()
            if let result = try? decoder.decode(BrowsersModel.self, from: data) {
                return result
            }
        }
        return BrowsersModel()
    }()
    
    public func pickOne(browser: BrowserOptions = .all, filter: ((String) -> Bool)? = nil, completion: ((String?) -> Void)?) {
        pickALot(count: 1, browser: browser, filter: filter) { results in
            completion?(results.first)
        }
    }
    
    public func pickALot(count: Int, browser: BrowserOptions = .all, filter: ((String) -> Bool)? = nil, completion: (([String]) -> Void)?) {
        var loop: [(/*result: */[String], /*userAgents: */[String], /*browser: */BrowserOptions)] = [
            ([String](), userAgents.chrome, BrowserOptions.chrome),
            ([String](), userAgents.opera, BrowserOptions.opera),
            ([String](), userAgents.firefox, BrowserOptions.firefox),
            ([String](), userAgents.safari, BrowserOptions.safari),
            ([String](), userAgents.edge, BrowserOptions.edge),
            ([String](), userAgents.internetExplorer, BrowserOptions.internetExplorer),
        ]
        
        let dispatchGroup = DispatchGroup()
        for (index, (_, loopUserAgents, loopBrowser)) in loop.enumerated() {
            dispatchGroup.enter()
            DispatchQueue.global(qos: .utility).async {
                if browser.contains(loopBrowser) {
                    if let filter = filter {
                        loop[index].0 = loopUserAgents.filter({ filter($0) })
                    } else {
                        loop[index].0 = loopUserAgents
                    }
                }
                dispatchGroup.leave()
            }
        }
        dispatchGroup.notify(queue: .main) {
            let result: [String] = loop.reduce(into: [], { $0 += $1.0 })
            if result.count <= count {
                completion?(result)
            } else {
                let randomElements: [String] = Array(result.shuffled().prefix(count))
                completion?(randomElements)
            }
        }
    }
}
