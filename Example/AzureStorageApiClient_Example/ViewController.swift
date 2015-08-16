//
//  ViewController.swift
//  AzureStorageApiClient_Example
//
//  Created by Hiromasa Ohno on 8/11/15.
//  Copyright (c) 2015 CocoaPods. All rights reserved.
//

import UIKit
import AzureStorageApiClient

class ViewController: UIViewController {
    
    var blobClient : AzureBlob.Client?
    var queueClient : AzureQueue.Client?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        blobClient = AzureBlob.Client(accoutName: Config.Account, accessKey: Config.Key, accountDomain: Config.Domain, useHTTPS: true)
        queueClient = AzureQueue.Client(accoutName: Config.Account, accessKey: Config.Key, accountDomain: Config.Domain, useHTTPS: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleResponse<T>(response: Response<T>) {
        switch response {
        case .Success(let wrapper):
            println(wrapper.value)
        case .Failure(let wrapper):
            println(wrapper.value)
        }
    }
    
    // Blob
    func listContainers() {
        let request = AzureBlob.ListContainersRequest()
        blobClient?.call(request, handler: handleResponse)
    }
    
    func createContainer() {
        let request = AzureBlob.CreateContainerRequest(container: "containername")
        blobClient?.call(request, handler: handleResponse)
    }
    
    func deleteContainer() {
        let request = AzureBlob.DeleteContainerRequest(container: "containername")
        blobClient?.call(request, handler: handleResponse)
    }
    
    func putBlob() {
        if let url = NSURL(string: "https://avatars2.githubusercontent.com/u/3599510?v=3&s=10") {
            let data = NSData(contentsOfURL: url)!
            let request = AzureBlob.PutBlobRequest(container: "containername", name: "file.png", data: data, mimetype: "image/png")
            blobClient?.call(request, handler: handleResponse)
        }
    }
    
    func getBlob() {
        let request = AzureBlob.GetBlobRequest(container: "containername", name: "file.png", mimetype: "image/png")
        blobClient?.call(request, handler: handleResponse)
    }
    
    func getBlobProperties() {
        let request = AzureBlob.GetBlobPropertiesRequest(container: "containername", name: "file.png")
        blobClient?.call(request, handler: handleResponse)
    }
    
    // Queue
    func listQueues() {
        let request = AzureQueue.ListQueuesRequest()
        queueClient?.call(request, handler: handleResponse)
    }
    
    func createQueue() {
        let request = AzureQueue.CreateQueueRequest(queue: "queuename")
        queueClient?.call(request, handler: handleResponse)
    }
    
    func deleteQueue() {
        let request = AzureQueue.DeleteQueueRequest(queue: "queuename")
        queueClient?.call(request, handler: handleResponse)
    }
    
    func putMessage() {
        let request = AzureQueue.PutMessagesRequest(queue: "queuename", message: "a message", messageTTL: 3600, visibilityTimeout: 600)
        queueClient?.call(request, handler: handleResponse)
    }
    
    func getMessages() {
        let request = AzureQueue.GetMessagesRequest(queue: "queuename", visibilityTimeout: 600, numberOfMessages: 32)
        queueClient?.call(request, handler: handleResponse)
    }
    
    func peekMessage() {
        let request = AzureQueue.PeekMessagesRequest(queue: "queuename", numberOfMessages: 32)
        queueClient?.call(request, handler: handleResponse)
    }
    
    func deleteMessage() {
        let request = AzureQueue.DeleteMessageRequest(queue: "queuename", messageId: "message-id(UUID)", popReceipt: "pop-receipt")
        queueClient?.call(request, handler: handleResponse)
    }
    
    func clearMessage() {
        let request = AzureQueue.ClearMessagesRequest(queue: "queuename")
        queueClient?.call(request, handler: handleResponse)
    }
    
    func updateMessage() {
        let request = AzureQueue.UpdateMessageRequest(queue: "queuename", message: "new message", messageId: "message-id(UUID)", popReceipt: "pop-receipt", visibilityTimeout: 3600)
        queueClient?.call(request, handler: handleResponse)
    }
}

