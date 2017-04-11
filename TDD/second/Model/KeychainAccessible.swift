//
//  KeychainAccessible.swift
//  TDD
//
//  Created by tangyuhua on 2017/4/11.
//  Copyright © 2017年 tangyuhua. All rights reserved.
//

import Foundation



protocol KeychainAccessible {
    func setPassword(password: String,
                     account: String)
    func deletePasswortForAccount(account: String)
    func passwordForAccount(account: String) -> String?
}

