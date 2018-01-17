//
//  AJNavigationViewController.swift
//  AJPlusOCR
//
//  Created by Black on 2018/1/15.
//  Copyright © 2018年 Black. All rights reserved.
//

import UIKit

class AJNavigationViewController: UINavigationController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let navBar = UINavigationBar.appearance()
        navBar.setBackgroundImage(UIImage.ld_image(color: NAV_BG_COLOR), for: .default)
        navBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 18),NSAttributedStringKey.foregroundColor:UIColor.white]
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
