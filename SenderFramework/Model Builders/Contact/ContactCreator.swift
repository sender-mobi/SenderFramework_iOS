//
// Created by Roman Serga on 10/2/17.
// Copyright (c) 2017 Middleware Inc. All rights reserved.
//

import Foundation

@objc(MWContactCreator)
public class ContactCreator: NSObject, ContactCreatorProtocol {

    public func createContact() -> Contact {
        let contact = CoreDataFacade.sharedInstance().getNewObject(withName:"Contact") as! Contact
        CoreDataFacade.sharedInstance().getOwner().addContactsObject(contact)
        return contact
    }

    public func userWith(userID: String) -> Contact? {
        return CoreDataFacade.sharedInstance().selectContact(byId: userID)
    }

    public func contactWith(localID: String) -> Contact? {
        return CoreDataFacade.sharedInstance().contact(withLocalID: localID)
    }

    public func getOwnerContact() -> Contact? {
        let owner = self.getOwner()
        guard let ownerID = owner.uid else { return nil }
        return self.userWith(userID: ownerID)
    }

    public func getOwner() -> Owner {
        return CoreDataFacade.sharedInstance().getOwner()
    }

    public func deleteContact(_ contact: Contact) {
        CoreDataFacade.sharedInstance().delete(contact)
        if let p2pChat = contact.p2pChat {
            CoreDataFacade.sharedInstance().delete(p2pChat)
        }
    }
}
