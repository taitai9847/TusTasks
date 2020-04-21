//
//  ViewController.swift
//  TusTasks
//
//  Created by 石川　太洋 on 2020/04/05.
//  Copyright © 2020 石川　太洋. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    @IBOutlet weak var addTaskButton: UIButton!
    
    @IBOutlet weak var taskList: UITableView!
    
    var contentValue: String?
    
    var taskItems: Results<Tasks>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTaskButton.layer.cornerRadius = 35
        taskList.dataSource = self
        taskList.delegate = self
        
        //カスタムセルを使う宣言
        taskList.register(R.nib.tasksCell)
        
        //realからtaskItemsを呼び出す
        let realm = try! Realm()
        taskItems = realm.objects(Tasks.self)
        
        taskList.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presentingViewController?.endAppearanceTransition()
        taskList.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let vc = segue.destination as? SavedTaskViewController else { return }
        if let sentTasks = contentValue {
            vc.savedContent = sentTasks
        }
    }
    
    @IBAction func addTaskButton(_ sender: Any) {
        self.performSegue(withIdentifier: R.segue.viewController.toAddTaskVC, sender: nil)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: TasksCell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.taskCell, for: indexPath) else { return UITableViewCell() }
        let object = taskItems?[indexPath.row].content
        cell.textLabel?.text = object
        return cell
    }
    
    //セルが選択された時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tasks = taskItems[indexPath.row].content
        self.contentValue = tasks
        performSegue(withIdentifier: "toSavedTaskVC", sender: nil)
        taskList.deselectRow(at: indexPath, animated: true)
    }
    
    // タスクを消去する挙動
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                deleteTasks(at: (taskItems.count - indexPath.row) - 1)
                taskList.reloadData()
        }
    }
    
    //"削除"の文字にし、背景を赤にする
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let removeAction = UIContextualAction(style: .normal,
                                              title: "削除",
                                              handler: { (action: UIContextualAction, view: UIView, success :(Bool) -> Void) in
                                                self.deleteTasks(at: indexPath.row)
                                                self.taskList.reloadData()
        })
        removeAction.backgroundColor = UIColor(red: 255/255, green: 102/255, blue: 102/255, alpha: 1)
        return UISwipeActionsConfiguration(actions: [removeAction])
    }
    
    func deleteTasks(at index: Int) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(taskItems[index])
        }
    }
    
}



