//
//  ViewController.swift
//  hw3month4
//
//  Created by Nurjamal Mirbaizaeva on 18/4/23.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    var phones: [Phone] = []
    
    private lazy var phonesCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.register(PhoneCell.self, forCellWithReuseIdentifier: PhoneCell.reuseId)
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.backgroundColor = .cyan
        return collectionview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSubview()
        fetchPhoneList { result in
            self.phones = result
            DispatchQueue.main.async {
                self.phonesCollectionView.reloadData()
            }
        }
    }
    private func setupSubview(){
        view.addSubview(phonesCollectionView)
        phonesCollectionView.snp.makeConstraints {make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    
    func fetchPhoneList(completion: @escaping ([Phone]) -> ()){
        let url = URL(string: "https://api.punkapi.com/v2/beers/")
        
        let request = URLRequest(url: url!)
        
     let task = URLSession.shared.dataTask(with: request) {data, response, error in
            
            guard let data = data, error == nil else{
                return
            }
            do{
                let result = try JSONDecoder().decode([Phone].self, from: data)
                
                completion(result)
            }catch{
                print(error)
            }
        }
        task.resume()
    }
}
extension ViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return phones.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhoneCell.reuseId, for: indexPath) as! PhoneCell
        cell.fill(phone: phones[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "Alert title", message: "Alert message", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(action)
        let action2 = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(action2)
        
        let action3 = UIAlertAction(title: "Хотите перейти", style: .destructive) { [self] result in
            let vc = DetailViewController()
            vc.titleNameChangec = self.phones[indexPath.row].name
            vc.imagePhone.kf.setImage(with: URL(string: phones[indexPath.row].image_url))
            vc.descriptionChange = self.phones[indexPath.row].description
            self.present(vc, animated: true)
        }
        alert.addAction(action3)
        
        self.present(alert, animated: true)
    }
}
extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: 400)
    }
}
