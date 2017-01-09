//
//  NewsCell
//  CsenCinofilia
//
//  Created by Luciano Calderano on 26/10/16.
//  Copyright © 2016 Kanito. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    class func dequeue (_ tableView: UITableView, indexPath: IndexPath) -> NewsCell {
        return tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
    }
    
    var dicData:Dictionary<String, Any> {
        set {
            self.showData(newValue.dictionary("Frontarticle"))
        }
        get {
            return [:]
        }
    }

    @IBOutlet private var titolo: MYLabel!
    @IBOutlet private var autore: MYLabel!
    @IBOutlet private var imageview: UIImageView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.defaultCell()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.defaultCell()
    }
    
    private func defaultCell () {
        imageview?.image = UIImage.init(named: "K")
        imageview?.alpha = 0.5
    }
    
    func showData(_ dic: Dictionary<String, Any>) -> Void {
        titolo.text = dic.string("title")
        autore.text = dic.string("autore") + " " +
                      dic.string("online_datetime")
        imageview?.imageFromUrl(dic.string("image"))
    }
}
