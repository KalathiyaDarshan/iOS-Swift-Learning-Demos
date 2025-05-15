//
//  UserLocalData.swift
//  EvolutionTask
//
//  Created by mac on 04/07/24.
//

import Foundation

final class UserLocalData {
    
    private enum DataKey: String {
        
        case MainCatagory
        case productShopingList
    }
    
    static var mainCatagory: [MainCatagory] {
        get {
            if let data = UserDefaults.standard.data(forKey: DataKey.MainCatagory.rawValue) {
                do {
                    let decodedList = try JSONDecoder().decode([MainCatagory].self, from: data)
                    return decodedList
                } catch {
                    print("Failed to decode MainShopingList: \(error)")
                    return []
                }
            }
            return []
        }
        set {
            self.saveArrayToUserDefault(obj: newValue)
        }
    }
    
    static func saveArrayToUserDefault(obj: [MainCatagory])
    {
        do {
            let encodedData = try JSONEncoder().encode(obj)
            UserDefaults.standard.set(encodedData, forKey: DataKey.MainCatagory.rawValue)
            UserDefaults.standard.synchronize()
        } catch {
            print("Failed to encode MainShopingList: \(error)")
        }
    }
    
    static func updateMainShopingList(with updatedList: MainCatagory) {
        var list = mainCatagory
        if let index = list.firstIndex(where: { $0.id == updatedList.id }) {
            list[index] = updatedList
            mainCatagory = list
        } else {
            print("MainShopingList with id \(updatedList.id) not found")
        }
    }
   
   /* static func updateProductList(at index: Int, with newProductList: [ProductList]) {
        let shoppingList = mainShopingList
        if index >= 0 && index < shoppingList.count {
            shoppingList[index].arrProduct = newProductList
            mainShopingList = shoppingList
        } else {
            print("Index out of range")
        }
    }
    */
    
    static var productList: [ProductList] {
        get {
            if let data = UserDefaults.standard.data(forKey: DataKey.productShopingList.rawValue) {
                do {
                    let decodedList = try JSONDecoder().decode([ProductList].self, from: data)
                    return decodedList
                } catch {
                    print("Failed to decode productShopingList: \(error)")
                    return []
                }
            }
            return []
        }
        set {
            do {
                let encodedData = try JSONEncoder().encode(newValue)
                UserDefaults.standard.set(encodedData, forKey: DataKey.productShopingList.rawValue)
                UserDefaults.standard.synchronize()
            } catch {
                print("Failed to encode productShopingList: \(error)")
            }
        }
    }

}

