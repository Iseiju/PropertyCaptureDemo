//
//  Dictionary+Extension.swift
//  PropertyCaptureDemo
//
//  Created by Kenneth James Uy on 6/26/26.
//

import Foundation

extension Dictionary {

	func toQueryItem() -> [URLQueryItem] {
		return self.compactMap { key, value in
			return URLQueryItem(name: "\(key)", value: "\(value)")
		}
	}
}
