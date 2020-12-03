//
//  CastleViewController.swift
//  CastleTest
//
//  Created by Diego Manuel Molina Canedo on 3/12/20.
//

import UIKit

extension Assembler {
    func assembleCastleViewController() -> CastleViewController {
        let castleVC = CastleViewController()
        castleVC.viewModel = CastleViewModel()
        return castleVC
    }
}


class CastleViewController: BaseViewController {
    var viewModel: CastleViewModel?
}
