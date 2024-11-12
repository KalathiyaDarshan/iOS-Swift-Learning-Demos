var Employ:[String:Any]=["Name":"Darshan","Age":19,"City":"Junagadh"]
print(Employ)

let name = Employ["Name"]
print(name)

Employ["Strime"]="BCA"
print(Employ)

for (key, value) in Employ {
    print("Key: \(key), Value: \(value)")
}
