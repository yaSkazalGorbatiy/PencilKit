//
//  ViewController.swift
//  PencilKit
//
//  Created by Сергей Горбачёв on 02.08.2021.
//

import UIKit
import PhotosUI

class ViewController: UIViewController {
    
    private let undoButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        button.addTarget(
            self,
            action: #selector(undoActionCanvasField),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let clearButton: UIButton = {
        let button = UIButton()
        button.setTitle("Очистить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        button.addTarget(
            self,
            action: #selector(clearCanvasField),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let redButton = UIButton(color: #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1))
    private let orangeButton = UIButton(color: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    private let yellowButton = UIButton(color: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1))
    private let greenButton = UIButton(color: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1))
    private let blueButton = UIButton(color: #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1))
    
    private var colorsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 1
        slider.maximumValue = 10
        slider.translatesAutoresizingMaskIntoConstraints = false
        return slider
    }()
    
    private let saveImageButton: UIButton = {
        let button = UIButton()
        button.setTitle("Сохранить", for: .normal)
        button.setTitleColor(#colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1), for: .normal)
        button.addTarget(
            self,
            action: #selector(saveImage),
            for: .touchUpInside
        )
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let canvas = Canvas()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        canvas.backgroundColor = .white
        setupViews()
        setContraints()
        
        canvas.translatesAutoresizingMaskIntoConstraints = false

        slider.addTarget(
            self,
            action: #selector(sliderChangeValue),
            for: .valueChanged
        )
        redButton.addTarget(
            self,
            action: #selector(changeColor(button:)),
            for: .touchUpInside
        )
        orangeButton.addTarget(
            self,
            action: #selector(changeColor(button:)),
            for: .touchUpInside
        )
        yellowButton.addTarget(
            self,
            action: #selector(changeColor(button:)),
            for: .touchUpInside
        )
        greenButton.addTarget(
            self,
            action: #selector(changeColor(button:)),
            for: .touchUpInside
        )
        blueButton.addTarget(
            self,
            action: #selector(changeColor(button:)),
            for: .touchUpInside
        )
    }
    
    @objc private func clearCanvasField() {
        canvas.clear()
    }
    
    @objc private func undoActionCanvasField() {
        canvas.undo()
    }
    
    private func setupViews() {
        view.addSubview(canvas)
        view.addSubview(slider)
        view.addSubview(undoButton)
        view.addSubview(clearButton)
        view.addSubview(colorsStackView)
        view.addSubview(saveImageButton)
        
        colorsStackView.addArrangedSubview(redButton)
        colorsStackView.addArrangedSubview(orangeButton)
        colorsStackView.addArrangedSubview(yellowButton)
        colorsStackView.addArrangedSubview(greenButton)
        colorsStackView.addArrangedSubview(blueButton)
    }
    
    @objc private func sliderChangeValue() {
        canvas.setStrokeWidth(width: slider.value)
    }

    @objc private func changeColor(button: UIButton) {
        canvas.setStrokeColor(color: button.backgroundColor ?? .black)
        slider.tintColor = button.backgroundColor ?? .black
        slider.thumbTintColor = button.backgroundColor ?? .black
    }
    
    @objc func saveImage() {
        StorageManager().saveImage(canvasView: canvas)
    }
    
    private func setContraints() {
        
        NSLayoutConstraint.activate([
            canvas.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            canvas.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            canvas.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            canvas.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -200)
        ])
        
        NSLayoutConstraint.activate([
            saveImageButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            saveImageButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            saveImageButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30),
            saveImageButton.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            slider.bottomAnchor.constraint(equalTo: saveImageButton.topAnchor, constant: 0),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            slider.heightAnchor.constraint(equalToConstant: 42)
        ])

        NSLayoutConstraint.activate([
            undoButton.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -10),
            undoButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            undoButton.widthAnchor.constraint(equalToConstant: 100),
            undoButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        NSLayoutConstraint.activate([
            clearButton.bottomAnchor.constraint(equalTo: slider.topAnchor, constant: -10),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            clearButton.widthAnchor.constraint(equalToConstant: 100),
            clearButton.heightAnchor.constraint(equalToConstant: 40)
        ])

        NSLayoutConstraint.activate([
            colorsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100),
            colorsStackView.trailingAnchor.constraint(equalTo: clearButton.leadingAnchor, constant: -5),
            colorsStackView.leadingAnchor.constraint(equalTo: undoButton.trailingAnchor, constant: 5),
            colorsStackView.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
}

