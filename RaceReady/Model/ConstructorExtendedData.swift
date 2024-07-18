//
//  ConstructorExtendadData.swift
//  RaceReady
//
//  Created by Adnann Muratovic on 17.07.24.
//

import Foundation

struct ConstructorExtendedData {
    var teamLogoImage: String
    var teamCarImage: String
    var teamDriverOne: String
    var teamDriverTwo: String
}



class ConstructorExtendedModel: ObservableObject {
    @Published var constructorExtendedData: [String: ConstructorExtendedData] = [
        "Red Bull Racing": ConstructorExtendedData(
            teamLogoImage: "redBullLogo", teamCarImage: "redBull", teamDriverOne: "Max Verstappen", teamDriverTwo: "Sergio Perez"
        ),
        "Ferrari": ConstructorExtendedData(
            teamLogoImage: "ferrariLogo", teamCarImage: "ferrari", teamDriverOne: "Charles Leclerc", teamDriverTwo: "Carlos Sainz"
        ),
        "McLaren": ConstructorExtendedData(
            teamLogoImage: "mclarenLogo", teamCarImage: "mclaren", teamDriverOne: "Lando Norris", teamDriverTwo: "Oscar Piastri"
        ),
        "Mercedes": ConstructorExtendedData(
            teamLogoImage: "mercedesLogo", teamCarImage: "mercedes", teamDriverOne: "George Russell", teamDriverTwo: "Lewis Hamilton"
        ),
        "Aston Martin": ConstructorExtendedData(
            teamLogoImage: "astonMartinLogo", teamCarImage: "astonMartin", teamDriverOne: "Fernando Alonso", teamDriverTwo: "Lance Stroll"
        ),
        "Haas": ConstructorExtendedData(
            teamLogoImage: "haasLogo", teamCarImage: "haas", teamDriverOne: "Nico Hulkenberg", teamDriverTwo: "Kevin Magnussen"
        ),
        "RB F1 Team": ConstructorExtendedData(
            teamLogoImage: "rbLogo", teamCarImage: "rb", teamDriverOne: "Yuki Tsunoda", teamDriverTwo: "Daniel Ricciardo"
        ),
        "Alpine": ConstructorExtendedData(
            teamLogoImage: "alpineLogo", teamCarImage: "alpine", teamDriverOne: "Pierre Gasly", teamDriverTwo: "Esteban Ocon"
        ),
        "Williams": ConstructorExtendedData(
            teamLogoImage: "williamsLogo", teamCarImage: "williams", teamDriverOne: "Alexander Albon", teamDriverTwo: "Logan Sargeant"
        ),
        "Sauber": ConstructorExtendedData(
            teamLogoImage: "sauberLogo", teamCarImage: "sauber", teamDriverOne: "Valtteri Bottas", teamDriverTwo: "Zhou Guanyu"
        )
    ]
}
