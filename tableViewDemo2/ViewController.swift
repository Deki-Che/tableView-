//
//  ViewController.swift
//  tableViewDemo2
//
//  Created by Deki on 15/11/4.
//  Copyright © 2015年 Deki. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    var provinces = ["山东", "黑龙江", "辽宁" ,"北京"]
    var city = ["山东":["济南", "青岛", "威海","济南", "青岛", "威海","济南", "青岛", "威海"], "黑龙江":["哈尔滨", "大庆", "木兰","哈尔滨", "大庆", "木兰","哈尔滨", "大庆", "木兰"], "辽宁":["沈阳", "抚顺", "锦州"], "北京":["海淀区", "朝阳区","海淀区", "朝阳区","海淀区", "朝阳区"]]
    
    @IBOutlet weak var tableView1: UITableView!
    var markTag = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.tableView1.delegate = self
        self.tableView1.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func editBtnClicked(sender: UIBarButtonItem) {
        markTag = 1
        tableView1.setEditing(!tableView1.editing, animated: true)
        if tableView1.editing {
            sender.title = "Done"
        } else {
            sender.title = "Edit"
        }
    }
    @IBAction func insertBtnClicked(sender: UIBarButtonItem) {
        markTag = 2
        tableView1.setEditing(!tableView1.editing, animated: true)
        if tableView1.editing {
            sender.title = "Done"
        } else {
            sender.title = "Insert"
        }

    }
    
    // 移动单元格
    func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        // 移动数据
        let proName = provinces[sourceIndexPath.section]
        let curCity = city[proName]?[sourceIndexPath.row]
        city[proName]?.removeAtIndex(sourceIndexPath.row)
        city[proName]?.insert(curCity!, atIndex: destinationIndexPath.row)
        //移动单元格
        tableView.moveRowAtIndexPath(sourceIndexPath, toIndexPath: destinationIndexPath)
    }
    
    
    // 编辑单元格
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if markTag == 1 {
            return .Delete
        } else {
            return .Insert
        }

    }
    
    func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "确认删除？"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        //删除 1删除数组元素 2删除tableview单元格
        let proName = provinces[indexPath.section]
        if markTag == 1 {
            city[proName]?.removeAtIndex(indexPath.row)
            tableView1.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        } else {
            let cityName = city[proName]?[indexPath.row]
            city[proName]?.insert(cityName!, atIndex: indexPath.row+1)
            tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
        }
        
    }
    // 返回每个section中row的个数
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let provinceName = provinces[section]
        return city[provinceName]!.count
    }
    // 返回cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell1") as UITableViewCell!
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "celll1")
        }
        let province = provinces[indexPath.section]
        cell.textLabel?.text = city[province]![indexPath.row]
        cell.accessoryType = .DisclosureIndicator
        return cell!
    }
    
    // 返回section个数
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return provinces.count
    }
    // 显示section标题
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return provinces[section]
    }
    
    // 添加索引index
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return ["Shan", "Hei", "Liao" ,"BJ"]
    }
    // 选中单元行
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let proName = provinces[indexPath.section]
        let cityName = city[proName]![indexPath.row]
        print(" 选中了\(proName)省,\(cityName)市  ")
    }


}

