//
//  DaoManager.swift
//
//  Copyright © Paco Pulido. All rights reserved.
//

import UIKit
import SQLite3

let sharedInstance = DaoManager()

class DaoManager: NSObject {

    var database: OpaquePointer? = nil
    
    class func getInstance() -> DaoManager {
        
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent("metro.bd.sqlite")
        
        if sqlite3_open(fileURL.path, &sharedInstance.database) != SQLITE_OK {
            print("error opening database")
        }

        return sharedInstance
    }
    
    func getLineas() -> [Line] {
        
        var stmt:OpaquePointer?
        var stmtinifin:OpaquePointer?
        
        var queryString = "select id, n, c from l"
        if sqlite3_prepare(database, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(database)!)
            print("error preparing insert: \(errmsg)")
        }
        var lines : [Line] = [Line]()
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let line : Line = Line()
            line.id = sqlite3_column_int(stmt, 0)
            line.name = String(cString: sqlite3_column_text(stmt, 1))
            line.color = String(cString: sqlite3_column_text(stmt, 2))
            queryString = "select inicio, fin from (select nb inicio from e where ne=(SELECT min(ne) FROM e where l1=\(line.id))),(select nb fin from e where ne=(SELECT max(ne) FROM e where l1=\(line.id)))"
            if sqlite3_prepare(database, queryString, -1, &stmtinifin, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(database)!)
                print("error preparing insert: \(errmsg)")
            }
            if(sqlite3_step(stmtinifin) == SQLITE_ROW){
                let start = String(cString: sqlite3_column_text(stmtinifin, 0))
                let end = String(cString: sqlite3_column_text(stmtinifin, 1))
                line.startEnd = "\(start) - \(end)"
            }
            lines.append(line)
        }
        return lines
    }
    
    func getEstaciones(with linea:Int32) -> [Station] {
        var stmt:OpaquePointer?
        var stmte:OpaquePointer?
        
        var queryString = "select ne, nb from e where l1=\(linea)"
        if sqlite3_prepare(database, queryString, -1, &stmt, nil) != SQLITE_OK{
            let errmsg = String(cString: sqlite3_errmsg(database)!)
            print("error preparing insert: \(errmsg)")
        }
        var stations : [Station] = [Station]()
        while(sqlite3_step(stmt) == SQLITE_ROW){
            let station : Station = Station()
            station.id = sqlite3_column_int(stmt, 0)
            station.name = String(cString: sqlite3_column_text(stmt, 1))
            queryString = "select l1 from e where nb='\(station.name)' and l1!=\(linea)"
            if sqlite3_prepare(database, queryString, -1, &stmte, nil) != SQLITE_OK{
                let errmsg = String(cString: sqlite3_errmsg(database)!)
                print("error preparing insert: \(errmsg)")
            }
            var relations = [Int32]()
            while(sqlite3_step(stmte) == SQLITE_ROW){
                let cor = sqlite3_column_int(stmte, 0)
                relations.append(cor)
            }
        
            station.relations = relations
            stations.append(station)
        }
        
        return stations
    }
}
