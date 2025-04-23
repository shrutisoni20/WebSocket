//
//  Untitled.swift
//  WebSocket
//
//  Created by shruti's macbook on 21/04/25.

struct Post:  Identifiable , Decodable , Hashable {
    var id: Int {instrument_token}
    let instrument_token: Int
    let exchange_token: Int
    let tradingsymbol: String
    let name: String
    let last_price : Double
    let tick_size: Double
    let instrument_type: String
    let segment: String
    let exchange : String
    let strike: String
    let lot_size: Int
    let expiry: String
}

