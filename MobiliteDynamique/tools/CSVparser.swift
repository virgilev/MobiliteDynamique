//
//  CSVparser.swift
//  MobiliteDynamique
//
//  Created by Pierre Bathellier on 18/10/2017.
//  Copyright © 2017 Pierre Bathellier. All rights reserved.
//

import Foundation

class CSVparser {
    
    var  data:[[String:String]] = []
    var  columnTitles:[String] = []
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                print("File Open Errot for file \(fileName)")
                return nil
        }
        do {
            var contents = try String(contentsOfFile: filepath, encoding: .utf8)
            contents = cleanRows(file: contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }
    
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";;", with: "")
        //        cleanFile = cleanFile.replacingOccurrences(of: ";\n", with: "")
        return cleanFile
    }


    func convertCSV(file:String){
        let rows = cleanRows(file: file).components(separatedBy: "\n")
        if rows.count > 0 {
            data = []
            columnTitles = getStringFieldsForRow(row: rows.first!,delimiter:",")
            for row in rows{
                let fields = getStringFieldsForRow(row: row,delimiter: ",")
                if fields.count != columnTitles.count {continue}
                var dataRow = [String:String]()
                for (index,field) in fields.enumerated(){
                    let fieldName = columnTitles[index]
                    dataRow[fieldName] = field
                }
                data += [dataRow]
            }
        } else {
            print("No data in file")
        }
        
    }
    
    func printData(file:String){
        convertCSV(file: file)
        var tableString = ""
        var rowString = ""
        print("data: \(data)")
        for row in data{
            rowString = ""
            for fieldName in columnTitles{
                guard let field = row[fieldName] else{
                    print("field not found: \(fieldName)")
                    continue
                }
                rowString += String(format:"%@     ",field)
            }
            tableString += rowString + "\n"
        }
        print(tableString)
    }
    
        func getStringFieldsForRow(row:String, delimiter:String)-> [String]{
        return row.components(separatedBy: delimiter)
    }
    
}


