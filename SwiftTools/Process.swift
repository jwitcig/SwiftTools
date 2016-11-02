//
//  Process.swift
//  SwiftTools
//
//  Created by Jonah Witcig on 10/25/16.
//  Copyright © 2016 JwitApps. All rights reserved.
//

public enum ProcessFormType: Int {
    case name, message, image, final
}

public protocol ProcessHandler {
    var process: Process { get set }
    
    func move(to item: ProcessItem)
    func updated(form: ProcessItem)
}

public protocol ProcessItem: class {
    var type: ProcessFormType { get }
    
    var process: Process? { get set }
    
    var index: Int { get }
    
    var complete: Bool { get }
    
    var parentController: UIViewController? { get set }
    
    func clearForm()
    
    func dismissKeyboard()
}

public extension ProcessItem {
    var index: Int {
        return type.rawValue
    }
    
    var complete: Bool { return true }
    
    func checkCompletion() {
        if complete {
            process?.formChanged(self)
        }
    }
}

public extension Sequence where Iterator.Element == ProcessItem {
    var sortedByIndex: [ProcessItem] {
        return self.sorted { $0.0.index < $0.1.index }
    }
}

open class Process {
    open let items: [ProcessItem]
    
    open var current: ProcessItem {
        didSet {
            formSwitched(current)
        }
    }
    
    let formChanged: (ProcessItem)->()  // content of the form changed
    let formSwitched: (ProcessItem)->() // proceeding or receeding to a different form
    let fillCompletionView: ()->()      // block for filling out the .final completion view
    let completion: ()->()              // all forms complete, current for is .final form
    
    public init(items: [ProcessItem], formChanged: @escaping (ProcessItem)->(),
         formSwitched: @escaping (ProcessItem)->(),
         fillCompletionView: @escaping ()->(),
         completion: @escaping ()->()) {
        self.items = items
        self.current = items[0]
        self.formChanged = formChanged
        self.formSwitched = formSwitched
        self.fillCompletionView = fillCompletionView
        self.completion = completion
        
        items.forEach {
            $0.process = self
        }
    }
    
    open func next() {
        let newIndex = current.index + 1
        
        if newIndex < items.count {
            current = items[newIndex]
            
            if current.type == .final {
                fillCompletionView()
            }
        } else {
            completion()
        }
    }
    
    open func previous() {
        let newIndex = current.index > 0 ? current.index - 1 : 0
        current = items[newIndex]
    }
    
    open func reset() {
        current = items.first ?? current
        items.forEach { $0.clearForm() }
    }
}
