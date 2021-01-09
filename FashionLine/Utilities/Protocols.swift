//
//  Protocols.swift
//  FashionLine
//
//  Created by Furkan Y. on 22.12.2020.
//  Copyright © 2020 Furkan Y. All rights reserved.
//

import Foundation

protocol FeedHeaderCellDelegate{
    func handleProfilePicTapped(for cell: FeedHeaderCell)
}
protocol SubCustomCellDelegate{
    func handleCellTapped(for cell: SubCustomCell)
}
protocol CombinesSuggestionsHeaderTDelegate{
    func handleHeaderCellTapped(for cell: FeedCell)
}
protocol CombineDetailCellDelegate{
    func handleCellTapped(for cell: CombineDetailCell)
}
protocol CombinesOfDayDelegate {
    func handleCellTapped(for cell: CombinesSubCustomCell)
}
