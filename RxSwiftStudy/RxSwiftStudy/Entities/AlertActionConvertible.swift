//
//  AlertActionConvertible.swift
//  RxSwiftStudy
//
//  Created by 이준혁 on 2022/11/08.
//

import UIKit

protocol AlertActionConvertible {
    var title: String { get }
    var style: UIAlertAction.Style { get }
}
