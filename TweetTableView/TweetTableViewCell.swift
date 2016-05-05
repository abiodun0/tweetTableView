//
//  TweetTableViewCell.swift
//  TweetTableView
//
//  Created by Abiodun Shuaib on 05/05/2016.
//  Copyright © 2016 Abiodun Shuaib. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    var tweet: Tweet? {
        didSet{
            updateUi()
        }
    }
    private func updateUi(){
        // reset any tweet information
        userInfo?.attributedText = nil
        userImage?.image = nil
        tweetDetails?.text = nil
        
        if let tweet = self.tweet {
            tweetDetails?.text = tweet.text
            if tweetDetails?.text != nil {
                for _ in tweet.media {
                    tweetDetails.text! += " 📹"
                }
            }
            userInfo?.text = "\(tweet.user)"
            if let profileImageUrl = tweet.user.profileImageURL{
                // blocks the main thread
                if let imageData = NSData(contentsOfURL: profileImageUrl){
                    userImage?.image = UIImage(data: imageData)
                }
            }
        }
    }
    
    @IBOutlet weak var userInfo: UILabel!
    
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var tweetDetails: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
