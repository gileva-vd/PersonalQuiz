//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Vasichko Anna on 10.11.2022.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet var typeAnimalLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    var answers: [Answer]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.hidesBackButton = true

        getResultAnimal()
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        navigationController?.dismiss(animated: true)
    }
    
    deinit{
        print("ResultVC has been delocated")
    }
}

// MARK: - Private Methods
extension ResultViewController{
    
    private func updateUI(definition animal: Animal?) {
        typeAnimalLabel.text = "Вы - \(animal?.rawValue ?? "🐶" )!"
        descriptionLabel.text = animal?.definition ?? ""
    }
    
    private func getResultAnimal(){
        var counterOfAnimals: [Animal: Int] = [:]
        let animals = answers.map { $0.animal }

        for animal in animals {
            if let animalCount = counterOfAnimals[animal] {
                counterOfAnimals.updateValue(animalCount + 1, forKey: animal)
            } else {
                counterOfAnimals[animal] = 1
            }
        }
        
        for animal in animals {
            counterOfAnimals[animal] = (counterOfAnimals[animal] ?? 0) + 1
        }

        let sortedCounterOfAnimals = counterOfAnimals.sorted { $0.value > $1.value }
        guard let resultAnimal = sortedCounterOfAnimals.first?.key else { return }

        
        typeAnimalLabel.text = "Вы - \(resultAnimal.rawValue)!"
        descriptionLabel.text = resultAnimal.definition
    }
}
