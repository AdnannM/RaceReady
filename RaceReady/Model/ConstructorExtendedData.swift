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
    
    @Published var constructorExtendedData: [ConstructorExtendedData] = [
        ConstructorExtendedData(
            teamLogoImage: "redBullLogo", teamCarImage: "redBull", teamDriverOne: "Max Verstappen", teamDriverTwo: "Sergio Perez"
        ),
        ConstructorExtendedData(
            teamLogoImage: "ferrariLogo", teamCarImage: "ferrari", teamDriverOne: "Charles Leclerc", teamDriverTwo: "Carlos Sainz"
        ),
        ConstructorExtendedData(
            teamLogoImage: "mclarenLogo", teamCarImage: "mclaren", teamDriverOne: "Lando Norris", teamDriverTwo: "Oscar Piastri"
        ),
        ConstructorExtendedData(
            teamLogoImage: "mercedesLogo", teamCarImage: "mercedes", teamDriverOne: "George Russell", teamDriverTwo: "Lewis Hamilton"
        ),
        ConstructorExtendedData(
            teamLogoImage: "astonMartinLogo", teamCarImage: "astonMartin", teamDriverOne: "Fernando Alonso", teamDriverTwo: "Lance Stroll"
        ),
        ConstructorExtendedData(
            teamLogoImage: "haasLogo", teamCarImage: "haas", teamDriverOne: "Nico Hulkenberg", teamDriverTwo: "Kevin Magnussen"
        ),
        ConstructorExtendedData(
            teamLogoImage: "rbLogo", teamCarImage: "rb", teamDriverOne: "Yuki Tsunoda", teamDriverTwo: "Daniel Ricciardo"
        ),
        ConstructorExtendedData(
            teamLogoImage: "alphineLogo", teamCarImage: "alphine", teamDriverOne: "Pierre Gasly", teamDriverTwo: "Esteban Ocon"
        ),
        ConstructorExtendedData(
            teamLogoImage: "williamsLogo", teamCarImage: "williams", teamDriverOne: "Alexander Albon", teamDriverTwo: "Logan Sargeant"
        ),
        ConstructorExtendedData(
            teamLogoImage: "sauberLogo", teamCarImage: "sauber", teamDriverOne: "Zhou Guanyu", teamDriverTwo: "Valtteri Bottas"
        ),
    ]
}
