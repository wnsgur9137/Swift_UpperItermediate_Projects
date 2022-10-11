//
//  AlertActionConvertible.swift
//  SearchDaumBlog
//
//  Created by 이준혁 on 2022/10/12.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
