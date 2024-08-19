//
//  dbmanager.swift
//  Diary
//
//  Created by Shafay on 13/08/2023.
//
import Foundation
import SQLite3
class dbmanager{
    func initDatabase() -> OpaquePointer? {
        let filepath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("Dairy.db").path
        
        var dbpointer: OpaquePointer?
        if sqlite3_open(filepath, &dbpointer) == SQLITE_OK {
            print("Successfully opened connection to database at \(filepath)")
        } else {
            print("Unable to open database. Verify that you created the directory described in the Getting Started section.")
            return nil
        }
        
        return dbpointer
    }
    
    func CreateInsertUpdateDelete(query: String, audioURL: URL?) -> Bool {
        var dbpointer = self.initDatabase()
        if dbpointer != nil {
            var prepare_stmt: OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &prepare_stmt, nil) == SQLITE_OK {
                
                if let url = audioURL {
                    // Read audio data from the URL
                    let audioData = try? Data(contentsOf: url)
                    if let data = audioData {
                        // Bind the audio data to the prepared statement
                        let dataSize = Int32(data.count)
                        sqlite3_bind_blob(prepare_stmt, 1, (data as NSData).bytes, dataSize, nil)
                    }
                }
                if sqlite3_step(prepare_stmt) == SQLITE_DONE {
                    sqlite3_finalize(prepare_stmt)
                    return true
                }
            }
            let msg = String(cString: sqlite3_errmsg(dbpointer))
            print(msg)
            sqlite3_finalize(prepare_stmt)
        }
        return false
    }
    
    
    func CreateInsertUpdateDelete(query: String) -> Bool {
        let dbpointer = self.initDatabase() //database open krny k lie
        if dbpointer != nil{
            //database open hogy
            var prepare_stmt : OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &prepare_stmt, nil) == SQLITE_OK{
                //query check kr k deta hai or table confirm krta hai pr execute ni krta
                if sqlite3_step(prepare_stmt) == SQLITE_DONE{
                    return true;
                }
                
            }
            let msg = String(cString: sqlite3_errmsg(dbpointer))
            print(msg)
            sqlite3_finalize(prepare_stmt)
            
        }
        
        return false
    }
    ///// getchainEventTitle
    func getAllChainInfo() -> [ChainTitle] {
        var tasbeehs = [ChainTitle]()
        let dbpointer = self.initDatabase()
        if(dbpointer != nil){
            let query = "select DISTINCT ChainTitle from AddChainEvent"
            var stmpointer : OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK{
                while sqlite3_step(stmpointer) == SQLITE_ROW {
//                    let chaintitleid = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    
                    let chainTitle = String(cString: sqlite3_column_text(stmpointer, 0))
                    
//                    let did = Int(String(cString: sqlite3_column_text(stmpointer, 2)))
                    
                    let event = ChainTitle(ChainTitle:chainTitle)
                    tasbeehs.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        return tasbeehs
    }
    /////all chain details
    func getAllInfo(ChainTitle: String) -> [DairyInfomation] {
        var tasbeehs = [DairyInfomation]()
        
        guard let dbpointer = self.initDatabase() else {
            return tasbeehs
        }
        
        let query = "SELECT * FROM AddEvent a INNER JOIN AddChainEvent v ON a.did = v.did WHERE v.ChainTitle = ?"
        var stmpointer: OpaquePointer?
        
        if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK {
            sqlite3_bind_text(stmpointer, 1, (ChainTitle as NSString).utf8String, -1, nil)
            
            while sqlite3_step(stmpointer) == SQLITE_ROW {
                let did = Int(sqlite3_column_int(stmpointer, 0))
                let title = String(cString: sqlite3_column_text(stmpointer, 1))
                let venue = String(cString: sqlite3_column_text(stmpointer, 2))
                let events = String(cString: sqlite3_column_text(stmpointer, 3))
                let date = String(cString: sqlite3_column_text(stmpointer, 4))
                let time = String(cString: sqlite3_column_text(stmpointer, 5))
                let description = String(cString: sqlite3_column_text(stmpointer, 6))
                
                let event = DairyInfomation(
                    did: did,
                    Title: title,
                    Venue: venue,
                    Events: events,
                    Date: date,
                    Time: time,
                    Description: description
                )
                
                tasbeehs.append(event)
            }
            
            sqlite3_finalize(stmpointer)
        }
        
        sqlite3_close(dbpointer)
        
        return tasbeehs
    }

    func getAllInfoRepeat() -> [DairyInfomation] {
        var tasbeehs = [DairyInfomation]()
        let dbpointer = self.initDatabase()
        if(dbpointer != nil){
            let query = "select * from AddEvent where Repeat = \(1)"
            var stmpointer : OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK{
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let did = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    
                    let Title = String(cString: sqlite3_column_text(stmpointer, 1))
                    
                    let Venue = String(cString: sqlite3_column_text(stmpointer, 2))
                    
                    let Events = String(cString: sqlite3_column_text(stmpointer, 3))
                    let Date = String(cString: sqlite3_column_text(stmpointer, 4))
                    let Time = String(cString: sqlite3_column_text(stmpointer, 5))
                    let Description = String(cString: sqlite3_column_text(stmpointer, 6))
                    let event = DairyInfomation(did:did!,Title:Title,Venue:Venue,Events:Events,Date:Date,Time:Time,Description:Description)
                    tasbeehs.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        return tasbeehs
    }
    ///////testdisplay
    func getAllInfo() -> [gettest] {
        var Events = [gettest]()
        let dbpointer = self.initDatabase()
        if(dbpointer != nil){
            let query = "select * from Test"
            var stmpointer : OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK{
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let tid = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    
                    let Name = String(cString: sqlite3_column_text(stmpointer, 1))
                    
                    let Date = String(cString: sqlite3_column_text(stmpointer, 2))
                   
                    let event = gettest(tid:tid!,Name:Name,Date:Date)
                    Events.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        return Events
    }
    func getAddAllInfo1() -> [Addform1] {
        var Events = [Addform1]()
        let dbpointer = self.initDatabase()
        if(dbpointer != nil){
            let query = "select * from Example"
            var stmpointer : OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK{
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let tid = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    
                    let Name = String(cString: sqlite3_column_text(stmpointer, 1))
                    
                    let Date = String(cString: sqlite3_column_text(stmpointer, 2))
                     let Event = String(cString: sqlite3_column_text(stmpointer, 3))
                    
                    let event = Addform1(tid:tid!,Name:Name,Time:Date,description:Event)
                    Events.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        return Events
    }
    func getAllInfo() -> [gettest1] {
        var Events = [gettest1]()
        let dbpointer = self.initDatabase()
        if(dbpointer != nil){
            let query = "select * from Test1"
            var stmpointer : OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK{
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let tid = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    
                    let Name = String(cString: sqlite3_column_text(stmpointer, 1))
                    
                    let Time = String(cString: sqlite3_column_text(stmpointer, 2))
                    
                    let event = gettest1(tid:tid!,Name:Name,Time:Time)
                    Events.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        return Events
    }
    
    func getAllAddInfo() -> [DairyInfomation] {
        var tasbeehs = [DairyInfomation]()
        let dbpointer = self.initDatabase()
        if(dbpointer != nil){
            let query = "select * from AddEvent"
            var stmpointer : OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK{
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let did = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    
                    let Title = String(cString: sqlite3_column_text(stmpointer, 1))
                    
                    let Venue = String(cString: sqlite3_column_text(stmpointer, 2))
                    
                    let Events = String(cString: sqlite3_column_text(stmpointer, 3))
                    let Date = String(cString: sqlite3_column_text(stmpointer, 4))
                    let Time = String(cString: sqlite3_column_text(stmpointer, 5))
                    let Description = String(cString: sqlite3_column_text(stmpointer, 6))
                    let event = DairyInfomation(did:did!,Title:Title,Venue:Venue,Events:Events,Date:Date,Time:Time,Description:Description)
                    tasbeehs.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        return tasbeehs
    }
    
    func getAllInfo() -> [DairyInfomation] {
        var tasbeehs = [DairyInfomation]()
        let dbpointer = self.initDatabase()
        if(dbpointer != nil){
            let query = "select * from AddEvent"
            var stmpointer : OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK{
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let did = Int(String(cString: sqlite3_column_text(stmpointer, 0)))

                    let Title = String(cString: sqlite3_column_text(stmpointer, 1))
                    
                    let Venue = String(cString: sqlite3_column_text(stmpointer, 2))
                    
                    let Events = String(cString: sqlite3_column_text(stmpointer, 3))
                    let Date = String(cString: sqlite3_column_text(stmpointer, 4))
                    let Time = String(cString: sqlite3_column_text(stmpointer, 5))
                    let Description = String(cString: sqlite3_column_text(stmpointer, 6))
                    let event = DairyInfomation(did:did!,Title:Title,Venue:Venue,Events:Events,Date:Date,Time:Time,Description:Description)
                    tasbeehs.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        return tasbeehs
    }
    ///// repetaed evnt
    func getAllInforRepeated(search:String) -> [DairyInfomation] {
        var tasbeehs = [DairyInfomation]()
        let dbpointer = self.initDatabase()
        
        if dbpointer != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = dateFormatter.string(from: Date()) // Get the current date in the required format
            
            let query = "SELECT * FROM AddEvent WHERE Repeat = '\(1)' AND Date = '\(search)'"
            
            var stmpointer: OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK {
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let did = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    let Title = String(cString: sqlite3_column_text(stmpointer, 1))
                    let Venue = String(cString: sqlite3_column_text(stmpointer, 2))
                    let Events = String(cString: sqlite3_column_text(stmpointer, 3))
                    let OldDateStr = String(cString: sqlite3_column_text(stmpointer, 4))
                    let Time = String(cString: sqlite3_column_text(stmpointer, 5))
                    let Description = String(cString: sqlite3_column_text(stmpointer, 6))
                    
                    // Convert the OldDateStr to a Date
                    if let oldDate = dateFormatter.date(from: OldDateStr) {
                        // Create a Calendar and DateComponents to increment the year
                        var calendar = Calendar.current
                        calendar.locale = Locale(identifier: "en_US_POSIX")
                        if let newDate = calendar.date(byAdding: .year, value: 1, to: oldDate) {
                            // Format the new date as required
                            let newDateStr = dateFormatter.string(from: newDate)
                            let event = DairyInfomation(did: did!, Title: Title, Venue: Venue, Events: Events, Date: newDateStr, Time: Time, Description: Description)
                            tasbeehs.append(event)
                        }
                    }
                }
                sqlite3_finalize(stmpointer)
            }
        }
        
        return tasbeehs
    }

    
    
    
    /////
    
    
    
    func getAllInfoSearch(search:String) -> [DairyInfomation] {
        var tasbeehs = [DairyInfomation]()
        let dbpointer = self.initDatabase()
        
        if dbpointer != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = dateFormatter.string(from: Date()) // Get the current date in the required format
            
            let query = "SELECT * FROM AddEvent WHERE Date = '\(search)'"
            
            var stmpointer: OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK {
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let did = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    let Title = String(cString: sqlite3_column_text(stmpointer, 1))
                    let Venue = String(cString: sqlite3_column_text(stmpointer, 2))
                    let Events = String(cString: sqlite3_column_text(stmpointer, 3))
                    let Date = String(cString: sqlite3_column_text(stmpointer, 4))
                    let Time = String(cString: sqlite3_column_text(stmpointer, 5))
                    let Description = String(cString: sqlite3_column_text(stmpointer, 6))
                    let event = DairyInfomation(did: did!, Title: Title, Venue: Venue, Events: Events, Date: Date, Time: Time, Description: Description)
                    tasbeehs.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        
        return tasbeehs
    }
    func getAllInfoForToday() -> [DairyInfomation] {
        var tasbeehs = [DairyInfomation]()
        let dbpointer = self.initDatabase()
        
        if dbpointer != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let currentDate = dateFormatter.string(from: Date()) // Get the current date in the required format
            
            let query = "SELECT * FROM AddEvent WHERE Date = '\(currentDate)'"
            
            var stmpointer: OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK {
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let did = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    let Title = String(cString: sqlite3_column_text(stmpointer, 1))
                    let Venue = String(cString: sqlite3_column_text(stmpointer, 2))
                    let Events = String(cString: sqlite3_column_text(stmpointer, 3))
                    let Date = String(cString: sqlite3_column_text(stmpointer, 4))
                    let Time = String(cString: sqlite3_column_text(stmpointer, 5))
                    let Description = String(cString: sqlite3_column_text(stmpointer, 6))
                    let event = DairyInfomation(did: did!, Title: Title, Venue: Venue, Events: Events, Date: Date, Time: Time, Description: Description)
                    tasbeehs.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        
        return tasbeehs
    }
////holiday
    func getAllInfoForPublic() -> [DairyInfomation] {
        var tasbeehs = [DairyInfomation]()
        let dbpointer = self.initDatabase()
        
        if dbpointer != nil {
            
            
            let query = "SELECT * FROM AddEvent WHERE Event = 'Public Holidays'"
            
            var stmpointer: OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK {
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let did = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    let Title = String(cString: sqlite3_column_text(stmpointer, 1))
                    let Venue = String(cString: sqlite3_column_text(stmpointer, 2))
                    let Events = String(cString: sqlite3_column_text(stmpointer, 3))
                    let Date = String(cString: sqlite3_column_text(stmpointer, 4))
                    let Time = String(cString: sqlite3_column_text(stmpointer, 5))
                    let Description = String(cString: sqlite3_column_text(stmpointer, 6))
                    let event = DairyInfomation(did: did!, Title: Title, Venue: Venue, Events: Events, Date: Date, Time: Time, Description: Description)
                    tasbeehs.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        
        return tasbeehs
    }
    
    
    
    
    func getAllInfoForBirthday() -> [DairyInfomation] {
        var tasbeehs = [DairyInfomation]()
        let dbpointer = self.initDatabase()
        
        if dbpointer != nil {
            
            
            let query = "SELECT * FROM AddEvent WHERE Event = 'Birthday'"
            
            var stmpointer: OpaquePointer?
            if sqlite3_prepare_v2(dbpointer, query, -1, &stmpointer, nil) == SQLITE_OK {
                while sqlite3_step(stmpointer) == SQLITE_ROW {
                    let did = Int(String(cString: sqlite3_column_text(stmpointer, 0)))
                    let Title = String(cString: sqlite3_column_text(stmpointer, 1))
                    let Venue = String(cString: sqlite3_column_text(stmpointer, 2))
                    let Events = String(cString: sqlite3_column_text(stmpointer, 3))
                    let Date = String(cString: sqlite3_column_text(stmpointer, 4))
                    let Time = String(cString: sqlite3_column_text(stmpointer, 5))
                    let Description = String(cString: sqlite3_column_text(stmpointer, 6))
                    let event = DairyInfomation(did: did!, Title: Title, Venue: Venue, Events: Events, Date: Date, Time: Time, Description: Description)
                    tasbeehs.append(event)
                }
                sqlite3_finalize(stmpointer)
            }
        }
        
        return tasbeehs
    }

    
    func checkTables() {
        guard let db = initDatabase() else {
            print("Unable to open database.")
            return
        }
        
        var statement: OpaquePointer?
        let query = "SELECT name FROM sqlite_master WHERE type='table';"
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                if let tableName = sqlite3_column_text(statement, 0) {
                    print("Table name: \(String(cString: tableName))")
                }
            }
        } else {
            print("Unable to execute query.")
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(db)
    }
    func checksurahcolumn() {
        guard let db = initDatabase() else {
            print("Unable to open database.")
            return
        }
        
        var statement: OpaquePointer?
        let query = "SELECT * FROM Surah;"
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            while sqlite3_step(statement) == SQLITE_ROW {
                if let tableName = sqlite3_column_text(statement, 0) {
                    print("Column name: \(String(cString: tableName))")
                }
            }
        } else {
            print("Unable to execute query.")
        }
        
        sqlite3_finalize(statement)
        sqlite3_close(db)
    }
}
