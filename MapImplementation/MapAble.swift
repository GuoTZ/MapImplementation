//
//  MapAble.swift
//  MapImplementation
//
//  Created by DingYD on 2019/5/14.
//  Copyright © 2019 GuoTZ. All rights reserved.
//

import Cocoa

protocol  MapAble {
    associatedtype K
    associatedtype V
    func add(key:K,Value:V)         // 添加key、value
    func contains(key:K) ->Bool     // 检查是否存在key
    func remove(key:K) -> V?        // 移除key
    func getSize() ->Int            // 获取字典的大小
    func isEmpty() -> Bool          // 判断字典是否为空
    func get(key:K) -> V?           // 根据key获取value 不存在key返回nill
    func set(key:K,value:V) throws  // 更新key对应的value 不存在key抛出异常
}
