

import UIKit
import Foundation

// MARK: - OTMParseClient (Convenient Resource Methods)

extension OTMParseClient {
    
   
     func getAllDataFormUsers(_ completionHandlerForUserID: @escaping (_ success: Bool,_ usersData: [Any]?, _ errorString: String?) -> Void) {
        
        
        
        let parameters =  [OTMParseClient.ParameterKeys.Limit:OTMParseClient.ParameterValues.Limit,OTMParseClient.ParameterKeys.Order:OTMParseClient.ParameterValues.Order]


        
        
        /* 2. Make the request */
        
        _ = taskForGETMethod( OTMParseClient.Methods.StudentLocation, parameters: parameters as [String : AnyObject] , decode: StudentLocations.self) { (result, error) in
            
            
            if let error = error {
                
                completionHandlerForUserID(false ,nil ,"\(error.localizedDescription)")
            }else {
                let newResult = result as! StudentLocations
                if let usersData = newResult.results  {
                    self.usersData = usersData
                    completionHandlerForUserID(true ,usersData,nil)
                    
                }else {
                    completionHandlerForUserID(false ,nil ,"\( error!.localizedDescription)")
                    
                }
                
                
            }
      }
        
    }
  
    
    
    
    
}


