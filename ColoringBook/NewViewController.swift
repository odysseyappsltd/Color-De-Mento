//
//  NewViewController.swift
//  ColoringBook
//
//  Created by Admin on 2017-09-25.
//  Copyright © 2017 Odyssey. All rights reserved.
//

import UIKit
import FSPagerView

class NewViewController: UIViewController , UIScrollViewDelegate , FSPagerViewDataSource,FSPagerViewDelegate , UITableViewDelegate , UITableViewDataSource{
    
    
    // MARK: - Outlets Upper View
    @IBOutlet var upperViewHolder: UIView!
    let scrollView = FSPagerView()
    @IBOutlet var upDownButton: UIButton!
    
    // MARK: - Outlets Down View
    @IBOutlet var downViewHolder: UIView!

    let tableView = UITableView()
    
   
    
    
    
   
    // MARK: - Frame Copies Outlets
    var upperViewHolderFrameCopy = CGRect()
    var downViewHolderFrameCopy = CGRect()
    
    // MARK: - Data Sources Outlets
    var startingImages = [#imageLiteral(resourceName: "Birds1.png"),#imageLiteral(resourceName: "Birds2.png"),#imageLiteral(resourceName: "Culture1.png"),#imageLiteral(resourceName: "Culture2.png")]
    
    
    
    // MARK: - Action Methods in Upper View
    
    @IBAction func upDownButtonAction(_ sender: UIButton, forEvent event: UIEvent)
    {
       
        
            if self.downViewHolder.center.y > self.view.frame.height
            {
                // If downViewHolder at down .
                
                
                    UIView.animate(withDuration: 0.5 , animations: {
                        self.upperViewHolder.frame = CGRect(x: 0, y: 150 - self.upperViewHolderFrameCopy.height , width: self.upperViewHolderFrameCopy.width, height: self.upperViewHolderFrameCopy.height)
                        self.downViewHolder.frame = CGRect(x: 0, y: 150 , width: self.downViewHolderFrameCopy.width, height: self.downViewHolderFrameCopy.height)
                    } , completion :{(_:Bool) in
                        UIView.animate(withDuration: 0.25) {
                            self.upDownButton.rotate(angle: 180)
                        }
                    })
                
                
                
            }
            else
            {
                // If downViewHolder at top .
                
                
                UIView.animate(withDuration: 0.5 , animations: {
                    self.upperViewHolder.frame = CGRect(x: 0, y: 0 , width: self.upperViewHolderFrameCopy.width, height: self.upperViewHolderFrameCopy.height)
                    self.downViewHolder.frame = CGRect(x: 0, y: self.downViewHolderFrameCopy.minY , width: self.downViewHolderFrameCopy.width, height: self.downViewHolderFrameCopy.height)
                    
                } , completion :{(_:Bool) in
                    UIView.animate(withDuration: 0.25) {
                        self.upDownButton.rotate(angle: 180)
                    }})
            }
        
        
       
        
    }
    
    
    @IBAction func colorItButtonAction(_ sender: UIButton, forEvent event: UIEvent)
    {
      
        /*
        
            if self.downViewHolder.center.y < self.view.frame.height
            {
                // If downViewHolder at down .
                
                print("here")
                UIView.animate(withDuration: 0.5 , animations: {
                    self.upperViewHolder.frame = CGRect(x: 0, y: 0 , width: self.upperViewHolderFrameCopy.width, height: self.upperViewHolderFrameCopy.height)
                    self.downViewHolder.frame = CGRect(x: 0, y: self.downViewHolderFrameCopy.minY , width: self.downViewHolderFrameCopy.width, height: self.downViewHolderFrameCopy.height)
                    
                } , completion :{(_:Bool) in
                    UIView.animate(withDuration: 0.25, animations:{
                        self.upDownButton.rotate(angle: 180)
                    } ,completion : {(_:Bool)in self.performSegue(withIdentifier: "toColor", sender: self) })
                
                })
            
            }
            else
            {
                performSegue(withIdentifier: "toColor", sender: self)
            }
        */
    
        performSegue(withIdentifier: "toColor", sender: self)
        
        
    
    }
    
    // MARK: -  Action Methods in Down View
    
    @IBAction func button1Action(_ sender: UIButton, forEvent event: UIEvent)
    {
        
    }
    @IBAction func button2Action(_ sender: Any, forEvent event: UIEvent)
    {
        
    }
    @IBAction func button3Action(_ sender: UIButton, forEvent event: UIEvent)
    {
        
    }
    @IBAction func button4Action(_ sender: UIButton, forEvent event: UIEvent)
    {
        
    }
    
    
    
    
    
    // MARK: - Setting Up Upper View Holder
    
    func setupUpperViewHolder()
    {
        upperViewHolder.frame =  self.view.frame
        upperViewHolderFrameCopy = upperViewHolder.frame // Need for animation
        setupScrollView()
        
    }
    
    func setupScrollView()
    {
        let screenSize = UIScreen.main.bounds
        
        scrollView.frame.size = CGSize(width: screenSize.width, height: screenSize.width)
        //scrollView.backgroundColor = UIColor.black
        scrollView.center = upperViewHolder.center //CGPoint(x: screenSize.width/2 , y: screenSize.height/2)
        scrollView.dataSource = self
        scrollView.delegate = self
        scrollView.register(FSPagerViewCell.self, forCellWithReuseIdentifier: "cell")
        scrollView.interitemSpacing = 10
        scrollView.itemSize = CGSize(width: screenSize.width - 20 , height: screenSize.width - 20)
        
        upperViewHolder.addSubview(scrollView)
        
    }
    
    
    
    // MARK: - SettingUp Down View Holder
    
    
    
    func setupDownViewHolder()
    {
        downViewHolder.frame = CGRect(x: 0, y: self.view.frame.height, width: self.view.frame.width, height: self.view.frame.height - 150)
        downViewHolderFrameCopy = downViewHolder.frame // Need for animation
        
        // Now By Default Menu Table should be build 
        tableView.frame = CGRect(x: 0, y: 73, width: downViewHolderFrameCopy.width, height: downViewHolderFrameCopy.height - 73) // Button Height + Gray Label = 71 + 2 = 73
        tableView.dataSource = self
        tableView.delegate = self
        downViewHolder.addSubview(tableView)
        
    }
    
    // MARK: - View Controller's Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUpperViewHolder()
        
        //self.extendedLayoutIncludesOpaqueBars = true
        //print(upperViewHolder.frame)
        //print(upperViewHolder.center)
        //print(self.view.center)
        
        //downViewHolder.center = CGPoint(x: 0, y: 0)
        
    }
    
    var didViewAppeared = false
    override func viewDidAppear(_ animated: Bool) {
         // Cause It works perfect here . Storyboard load here .
        if !didViewAppeared
        {
            setupDownViewHolder()
            didViewAppeared = true
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        automaticallyAdjustsScrollViewInsets = false 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "toColor"
        {
            if let target = segue.destination as? ColorViewController
            {
                target.dataImage = startingImages[scrollView.currentIndex]
                
            }
        }
    }
    
    
    
    
    
    // MARK: - FSPager View Delegates 
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return startingImages.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        cell.imageView?.image = startingImages[index]
        //cell.textLabel?.text = "Hello Me"
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool
    {
        return false
    }
    
    
    
    func pagerView(_ pagerView: FSPagerView, didHighlightItemAt index: Int)
    {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, shouldSelectItemAt index: Int) -> Bool
    {
        return false
    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int)
    {
        
    }
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int)
    {
        
    }
    
    func pagerView(_ pagerView: FSPagerView, didEndDisplaying cell: FSPagerViewCell, forItemAt index: Int)
    {
        
    }
    func pagerViewWillBeginDragging(_ pagerView: FSPagerView)
    {
        
    }
    
    func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int)
        
    {
        
    }
    func pagerViewDidScroll(_ pagerView: FSPagerView)
    {
        
    }
    
    func pagerViewDidEndScrollAnimation(_ pagerView: FSPagerView)
        
    {
        
    }
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView)
        
    {
        
    }
    
    
    // MARK: - Table View Delegates and DataSources
    
    let menuRows = ["Birds","Animals","Fashion","Culture","Christmas","Comics"]
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuRows.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = Bundle.main.loadNibNamed("MenuViewCell", owner: self, options: nil)?.first as! MenuViewCell
        cell.title.text = menuRows[indexPath.row]
        cell.icon.image = UIImage(named: menuRows[indexPath.row]+".png")
        return cell
    }

}
