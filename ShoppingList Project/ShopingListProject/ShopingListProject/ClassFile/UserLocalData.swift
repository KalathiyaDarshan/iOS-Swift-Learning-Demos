//
//  UserLocalData.swift
//  ShopingListProject
//
//  Created by mac on 18/06/24.
//

import Foundation

final class UserLocalData {
    
    private enum DataKey: String {
        
        case needToSkipIntroScreen
        case mainShopingList
        case productShopingList
        case sortingOrder
        case sortingCriteria
    }
    
    // Intro Screen
    static var needToSkipIntroScreen: Bool {
        get {
            return UserDefaults.standard.bool(forKey: DataKey.needToSkipIntroScreen.rawValue)
        }
        set {
            let defaults = UserDefaults.standard
            defaults.set(newValue, forKey: DataKey.needToSkipIntroScreen.rawValue)
            defaults.synchronize()
        }
    }
    
    static var mainShopingList: [MainShopingList] {
        get {
            if let data = UserDefaults.standard.data(forKey: DataKey.mainShopingList.rawValue) {
                do {
                    let decodedList = try JSONDecoder().decode([MainShopingList].self, from: data)
                    return decodedList
                } catch {
                    print("Failed to decode MainShopingList: \(error)")
                    return []
                }
            }
            return []
        }
        set {
            self.saveArrayToUserDefault(arrData: newValue)
        }
    }
    
    static func saveArrayToUserDefault(arrData: [MainShopingList])
    {
        do {
            let encodedData = try JSONEncoder().encode(arrData)
            UserDefaults.standard.set(encodedData, forKey: DataKey.mainShopingList.rawValue)
            UserDefaults.standard.synchronize()
        } catch {
            print("Failed to encode MainShopingList: \(error)")
        }
    }
    
    static func updateMainShopingList(with updatedList: MainShopingList) {
        var list = mainShopingList
        if let index = list.firstIndex(where: { $0.id == updatedList.id }) {
            list[index] = updatedList
            mainShopingList = list
        } else {
            print("MainShopingList with id \(updatedList.id) not found")
        }
    }
    
    static func updateProductList(at index: Int, with newProductList: [ProductList]) {
        let shoppingList = mainShopingList
        if index >= 0 && index < shoppingList.count {
            shoppingList[index].arrProduct = newProductList
            mainShopingList = shoppingList
        } else {
            print("Index out of range")
        }
    }
    
    static var productShopingList: [ProductList] {
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
    
    static func clearAllUserData() {
        
        let defaults = UserDefaults.standard
        
        let keysToRemove: [String] = [
            DataKey.needToSkipIntroScreen.rawValue,DataKey.mainShopingList.rawValue,DataKey.productShopingList.rawValue
        ]
        
        for key in keysToRemove {
            defaults.removeObject(forKey: key)
        }
        defaults.synchronize()
    }
    
    static func removeMainShopingList(at index: Int) {
        var shoppingList = mainShopingList
        if index >= 0 && index < shoppingList.count {
            shoppingList.remove(at: index)
            mainShopingList = shoppingList
        } else {
            print("Index out of range")
        }
    }
    
    static func removeProduct(from shoppingListIndex: Int, productIndex: Int) {
        let shoppingList = mainShopingList
        if shoppingListIndex >= 0 && shoppingListIndex < shoppingList.count {
            shoppingList[shoppingListIndex].removeProduct(at: productIndex)
            mainShopingList = shoppingList
        } else {
            print("Shopping list index out of range")
        }
    }
    
   static func updateProductInShoppingList(productId: String, updatedProduct: ProductList, shoppingListId: String) {
        var shoppingLists = UserLocalData.mainShopingList
        
        // Find the shopping list that contains the product
        if let shoppingListIndex = shoppingLists.firstIndex(where: { $0.id == shoppingListId }) {
            let shoppingList = shoppingLists[shoppingListIndex]
            
            // Find the index of the product in the arrProduct array
            if let productIndex = shoppingList.arrProduct.firstIndex(where: { $0.id == productId }) {
                // Update the product at the found index
                shoppingList.arrProduct[productIndex] = updatedProduct
                
                // Save the updated shopping list back to UserDefaults
                shoppingLists[shoppingListIndex] = shoppingList
                UserLocalData.mainShopingList = shoppingLists
            } else {
                print("Product with id \(productId) not found in shopping list with id \(shoppingListId)")
            }
        } else {
            print("Shopping list with id \(shoppingListId) not found")
        }
    }
    
    static var sortingOrder: SortingOrder? {
            get {
                if let orderString = UserDefaults.standard.string(forKey: DataKey.sortingOrder.rawValue) {
                    return SortingOrder(rawValue: orderString)
                }
                return nil
            }
            set {
                let defaults = UserDefaults.standard
                defaults.set(newValue?.rawValue, forKey: DataKey.sortingOrder.rawValue)
                defaults.synchronize()
            }
        }
    
    static var sortingCriteria: SortingCriteria? {
           get {
               if let criteriaString = UserDefaults.standard.string(forKey: DataKey.sortingCriteria.rawValue) {
                   return SortingCriteria(rawValue: criteriaString)
               }
               return nil
           }
           set {
               let defaults = UserDefaults.standard
               defaults.set(newValue?.rawValue, forKey: DataKey.sortingCriteria.rawValue)
               defaults.synchronize()
           }
       }

}

