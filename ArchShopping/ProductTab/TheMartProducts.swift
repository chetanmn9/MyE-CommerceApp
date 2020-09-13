//
//  ArchMartProducts.swift
//  ArchShopping
//
//  Created by Chetan on 1/3/20.
//  Copyright © 2020 Chetan M Nagaraj. All rights reserved.
//  The below are substitute to back end database
//  The products and categories can be maintained in the database and retrived as JSON object and parsed.

import Foundation

struct products {
    
    enum Categories: Int {
        case Fruits
        case Vegetables
        case Bakery
        case Dairy
        case Snacks
        case International
        case Drinks
        case HealthFoods
        case Home
        case Baby
        case Cleaning
        
        static let all = [Categories.Fruits, .Vegetables, .Bakery, .Dairy, .Snacks, .Drinks, .International, .HealthFoods, .Home, .Baby, .Cleaning]
        
    }
    
    enum Fruits: String, CaseIterable {
        case Apple
        case Mango
        case Watermelon
        case Rockmelon
        case Strawberries
        case Mandarin
        case Orange
        case Kiwi
        case Grapes
        case Passionfruit
        case Lime
        case Peach
        case Blueberries
        case Papaya
        
        static let allFruits = [Fruits.Apple, .Mango, .Watermelon, .Rockmelon, .Strawberries, .Mandarin, .Orange, .Kiwi, .Grapes, .Passionfruit, .Lime, .Peach, .Blueberries, .Papaya]
        
        var fruitsPrice: Double {
            switch self {
            case Fruits.Apple: return 2.50
            case .Mango: return 4.10
            case .Watermelon: return 3.65
            case .Rockmelon: return 9.20
            case .Strawberries: return 11.20
            case .Mandarin: return 5.69
            case .Orange: return 6.60
            case .Kiwi: return 2.15
            case .Grapes: return 1.99
            case .Passionfruit: return 7.25
            case .Lime: return 0.99
            case .Peach: return 8.45
            case .Blueberries: return 9.50
            case .Papaya: return 12.40
                
            }
        }
        var description: String { return rawValue }
    }
    
    enum Vegetables: String, CaseIterable {
        case Carrot
        case Cucumber
        case Beans
        case Eggplant
        case Corn
        case Beetroot
        case Brocolli
        case Cauliflower
        case Cabbage
        case Lettuce
        case Capsicum
        case Potatoes
        case Onions
        case Radish
        
        static let allVegetables = [Vegetables.Carrot, .Cucumber, .Beans, .Eggplant, .Corn, .Beetroot, .Brocolli, .Cauliflower, .Cabbage, .Lettuce, .Capsicum, .Potatoes, .Onions, .Radish]
        
        var vegetablesPrice: Double {
            switch self {
            case .Carrot: return 3.45
            case .Cucumber: return 5.45
            case .Beans: return 6.45
            case .Eggplant: return 7.45
            case .Corn: return 1.45
            case .Beetroot: return 4.45
            case .Brocolli: return 8.45
            case .Cauliflower: return 3.45
            case .Cabbage: return 6.45
            case .Lettuce: return 2.45
            case .Capsicum: return 9.45
            case .Potatoes: return 8.45
            case .Onions: return 1.45
            case .Radish: return 8.45
            }
        }
        var description: String { return rawValue }
    }
    
    enum Bakery: String, CaseIterable {
        case Bread
        case Scones
        case Cupcakes
        case Rolls
        case Biscuits
        case Cookies
        case Cakes
        case Muffins
        case Tortillas
        case Buns
        case Bagels
        case Pizza
        case Doughnuts
        case Waffles
        case Croissants
        
        static let allBakery = [Bakery.Bread, .Scones, .Cupcakes, .Rolls, .Biscuits, .Cookies, .Cakes, .Muffins, .Tortillas, .Buns, .Bagels, .Pizza, .Doughnuts, .Waffles, .Croissants]
        
        var bakeryPrice: Double {
            switch self {
            case .Bread: return 3.45
            case .Scones: return 5.45
            case .Cupcakes: return 6.45
            case .Rolls: return 7.45
            case .Biscuits: return 1.45
            case .Cookies: return 4.45
            case .Cakes: return 8.45
            case .Muffins: return 3.45
            case .Tortillas: return 6.45
            case .Buns: return 2.45
            case .Bagels: return 9.45
            case .Pizza: return 8.45
            case .Doughnuts: return 1.45
            case .Waffles: return 8.45
            case .Croissants: return 8.45
            }
        }
        var description: String { return rawValue }
    }
    
    enum Dairy: String, CaseIterable {
        case Milk
        case Yogurt
        case Cheese
        case Butter
        case Cream
        case Custard
        case IceCream
        case WhippedCream
        case Margarine
        case Eggs
        case ColdCoffee
        case Buttermilk
        case MilkChocolate
        case Shakes
        case Sorbet
        case GoatMilk
        
        static let allDairy = [Dairy.Milk, .Yogurt, .Cheese, .Butter, .Cream, .Custard, .IceCream, .WhippedCream, .Margarine, .Eggs, .ColdCoffee, .Buttermilk, .MilkChocolate, .Shakes, .Sorbet, .GoatMilk]
        
        var dairyPrice: Double {
            switch self {
            case .Milk: return 3.45
            case .Yogurt: return 7.75
            case .Cheese: return 8.50
            case .Butter: return 2.45
            case .Cream: return 4.25
            case .Custard: return 6.90
            case .IceCream: return 4.95
            case .WhippedCream: return 5.50
            case .Margarine: return 3.45
            case .Eggs: return 3.45
            case .ColdCoffee: return 3.45
            case .Buttermilk: return 3.45
            case .MilkChocolate: return 3.45
            case .Shakes: return 3.45
            case .Sorbet: return 3.45
            case .GoatMilk: return 3.45
            }
        }
        var description: String { return rawValue }
    }
    
    enum Snacks: String, CaseIterable {
        case Chips
        case Nachos
        case Savoury
        case Popcorn
        case Lollies
        case CrispBread
        case TrailMix
        case Crackers
        case RiceCakes
        case MuesliBars
        case Sweets
        case Chocolates
        case Pretzels
        case Nuts
        case Mixtures
        case Shapes
        
        static let allSnacks = [Snacks.Chips, .Nachos, .Savoury, .Popcorn, .Lollies, .CrispBread, .TrailMix, .Crackers, .RiceCakes, .MuesliBars, .Sweets, .Chocolates, .Pretzels, .Nuts, .Mixtures, .Shapes]
        
        var snacksPrice: Double {
            switch self {
            case .Chips: return 3.45
            case .Nachos: return 3.45
            case .Savoury: return 3.45
            case .Popcorn: return 3.45
            case .Lollies: return 3.45
            case .CrispBread: return 3.45
            case .TrailMix: return 3.45
            case .Crackers: return 3.45
            case .RiceCakes: return 3.45
            case .MuesliBars: return 3.45
            case .Sweets: return 3.45
            case .Chocolates: return 3.45
            case .Pretzels: return 3.45
            case .Nuts: return 3.45
            case .Mixtures: return 3.45
            case .Shapes: return 3.45
            }
        }
        var description: String { return rawValue }
    }
    
    enum International: String, CaseIterable {
        case Pasta
        case Noodles
        case MeiGoreng
        case NasiGoreng
        case Sauce
        case CurryPaste
        case BasmatiRice
        case Dal
        case Ghee
        case MisoPaste
        case ThaiCurryPaste
        case Masala
        case WholeSpice
        case CoconutMilk
        case Flour
        case Dumplings
        
        static let allInternational = [International.Pasta, .Noodles, .MeiGoreng, .NasiGoreng, .Sauce, .CurryPaste, .BasmatiRice, .Dal, .Ghee, .MisoPaste, .ThaiCurryPaste, .Masala, .WholeSpice, .CoconutMilk, .Flour, .Dumplings]
        
        var internationalPrice: Double {
            switch self {
            case .Pasta: return 3.45
            case .Noodles: return 3.45
            case .MeiGoreng: return 3.45
            case .NasiGoreng: return 3.45
            case .Sauce: return 3.45
            case .CurryPaste: return 3.45
            case .BasmatiRice: return 3.45
            case .Dal: return 3.45
            case .Ghee: return 3.45
            case .MisoPaste: return 3.45
            case .ThaiCurryPaste: return 3.45
            case .Masala: return 3.45
            case .WholeSpice: return 3.45
            case .CoconutMilk: return 3.45
            case .Flour: return 3.45
            case .Dumplings: return 3.45
            }
        }
        var description: String { return rawValue }
    }
    
    enum Drinks: String, CaseIterable {
        case Coke
        case Sprite
        case Lemonade
        case SparklingWater
        case Soda
        case MineralWater
        case TonicWater
        case Beer
        case Wine
        case Fanta
        case EnergyDrink
        case MountainDew
        case OrangeJuice
        case Pepsi
        case FruitJuice
        case VitaminWater
        
        static let allDrinks = [Drinks.Coke, .Sprite, .Lemonade, .SparklingWater, .Soda, .MineralWater, .TonicWater, .Beer, .Wine, .Fanta, .EnergyDrink, .MountainDew, .OrangeJuice, .Pepsi, .FruitJuice, .VitaminWater]
        
        var drinksPrice: Double {
            switch self {
            case .Coke: return 3.45
            case .Sprite: return 3.45
            case .Lemonade: return 3.45
            case .SparklingWater: return 3.45
            case .Soda: return 3.45
            case .MineralWater: return 3.45
            case .TonicWater: return 3.45
            case .Beer: return 3.45
            case .Wine: return 3.45
            case .Fanta: return 3.45
            case .EnergyDrink: return 3.45
            case .MountainDew: return 3.45
            case .OrangeJuice: return 3.45
            case .Pepsi: return 3.45
            case .FruitJuice: return 3.45
            case .VitaminWater: return 3.45
            }
        }
        var description: String { return rawValue }
    }
    
    enum HealthFoods: String, CaseIterable {
        case Quinoa
        case PumpkinSeeds
        case ChiaSeeds
        case Flaxseeds
        case BrownRice
        case Almonds
        case Pistachios
        case Cashew
        case Kale
        case Tumeric
        case Chickpea
        case Lentils
        case Sultanas
        case ProtienBar
        case DarkChocolate
        case Dill
        
        static let allHealthFoods = [HealthFoods.Quinoa, .PumpkinSeeds, .ChiaSeeds, .Flaxseeds, .BrownRice, .Almonds, .Pistachios, .Cashew, .Kale, .Tumeric, .Chickpea, .Lentils, .Sultanas, .ProtienBar, .DarkChocolate, .Dill]
        
        var healthFoodsPrice: Double {
            switch self {
            case .Quinoa: return 3.45
            case .PumpkinSeeds: return 3.45
            case .ChiaSeeds: return 3.45
            case .Flaxseeds: return 3.45
            case .BrownRice: return 3.45
            case .Almonds: return 3.45
            case .Pistachios: return 3.45
            case .Cashew: return 3.45
            case .Kale: return 3.45
            case .Tumeric: return 3.45
            case .Chickpea: return 3.45
            case .Lentils: return 3.45
            case .Sultanas: return 3.45
            case .ProtienBar: return 3.45
            case .DarkChocolate: return 3.45
            case .Dill: return 3.45
            }
        }
        var description: String { return rawValue }
    }
    
    enum Home: String, CaseIterable {
        case Bulbs
        case Battery
        case Cutlery
        case Cookware
        case Magazines
        case Books
        case Decoration
        case ToiletRoll
        case Tissues
        case Wraps
        case Hangers
        case Towels
        case BBQ
        case Clothes
        case Cables
        case Hooks
        
        static let allHome = [Home.Bulbs, .Battery, .Cutlery, .Cookware, .Magazines, .Books, .Decoration, .ToiletRoll, .Tissues, .Wraps, .Hangers, .Towels, .BBQ, .Clothes, .Cables, .Hooks]
        
        var homePrice: Double {
            switch self {
            case .Bulbs: return 3.45
            case .Battery: return 3.45
            case .Cutlery: return 3.45
            case .Cookware: return 3.45
            case .Magazines: return 3.45
            case .Books: return 3.45
            case .Decoration: return 3.45
            case .ToiletRoll: return 3.45
            case .Tissues: return 3.45
            case .Wraps: return 3.45
            case .Hangers: return 3.45
            case .Towels: return 3.45
            case .BBQ: return 3.45
            case .Clothes: return 3.45
            case .Cables: return 3.45
            case .Hooks: return 3.45
            }
        }
        var description: String { return rawValue }
    }
    
    enum Baby: String, CaseIterable {
        case Nappy
        case Powder
        case Moisturiser
        case Oil
        case Soap
        case Wipes
        case Formula
        case Cerelac
        case FeedingBottles
        case SippyCups
        case Toys
        case Bib
        case FirstAid
        case Shampoo
        case Cream
        case ChangePads
        
        static let allBaby = [Baby.Nappy, .Powder, .Moisturiser, .Oil, .Soap, .Wipes, .Formula, .Cerelac, .FeedingBottles, .SippyCups, .Toys, .Bib, .FirstAid, .Shampoo, .Cream, .ChangePads]
        
        var babyPrice: Double {
            switch self {
            case .Nappy: return 3.45
            case .Powder: return 3.45
            case .Moisturiser: return 3.45
            case .Oil: return 3.45
            case .Soap: return 3.45
            case .Wipes: return 3.45
            case .Formula: return 3.45
            case .Cerelac: return 3.45
            case .FeedingBottles: return 3.45
            case .SippyCups: return 3.45
            case .Toys: return 3.45
            case .Bib: return 3.45
            case .FirstAid: return 3.45
            case .Shampoo: return 3.45
            case .Cream: return 3.45
            case .ChangePads: return 3.45
            }
        }
        var description: String { return rawValue }
    }
    
    enum Cleaning: String, CaseIterable {
        case Detergent
        case Brush
        case Mop
        case FloorCleaner
        case SurfaceCleaner
        case Bleach
        case Broom
        case Wipes
        case Disinfectants
        case ScumRemover
        case DustPan
        case DustBin
        case BinLiner
        case Scrub
        case Diswashing
        case Duster
        
        static let allCleaning = [Cleaning.Detergent, .Brush, .Mop, .FloorCleaner, .SurfaceCleaner, .Bleach, .Broom, .Wipes, .Disinfectants, .ScumRemover, .DustPan, .DustBin, .BinLiner, .Scrub, .Diswashing, .Duster]
        
        var cleaningPrice: Double {
            switch self {
            case .Detergent: return 3.45
            case .Brush: return 3.45
            case .Mop: return 3.45
            case .FloorCleaner: return 3.45
            case .SurfaceCleaner: return 3.45
            case .Bleach: return 3.45
            case .Broom: return 3.45
            case .Wipes: return 3.45
            case .Disinfectants: return 3.45
            case .ScumRemover: return 3.45
            case .DustPan: return 3.45
            case .DustBin: return 3.45
            case .BinLiner: return 3.45
            case .Scrub: return 3.45
            case .Diswashing: return 3.45
            case .Duster: return 3.45
            }
        }
        var description: String { return rawValue }
    }
    
}



