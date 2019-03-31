//
//  ListCustomerViewController.swift
//  KLDataTable
//
//  Created by Tien Pham on 03/30/2019.
//  Copyright (c) 2019 Tien Pham. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Material
import DRPLoadingSpinner
import FontAwesomeKit
import ObjectMapper
import KLDataTable

class ListCustomerViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    /// The main table
    let table = KLDataTable<Customer, Customer>()
    let columns = BehaviorRelay<[KLDataTableColumn<Customer>]>(value: [])
    
    let summaryCells = BehaviorRelay<[KLDataTableSummaryCell<Customer>]>(value: [])
    
    let data = BehaviorRelay<[Customer]>(value: [
        Customer(name: "Brendan Langley", email: "Integer.aliquam@sed.org", phone: "(01046) 652322", address: "697-5077 Mus. Avenue"),
        Customer(name: "Hasad Kennedy", email: "magnis.dis@aptenttaciti.com", phone: "90898 953 0410", address: "P.O. Box 494, 8813 Ante St."),
        Customer(name: "Stewart Carroll", email: "ornare.In.faucibus@et.org", phone: "(015838) 84804", address: "717-2270 In St."),
        Customer(name: "Caldwell Rush", email: "cursus.Integer.mollis@Nam.net", phone: "07624 431960", address: "542-4356 Cras Av."),
        Customer(name: "David Cox", email: "aliquet.lobortis.nisi@Sedeueros.edu", phone: "0800 421649", address: "4203 Mauris Avenue"),
        Customer(name: "Randall Leonard", email: "velit.justo@Donectincidunt.edu", phone: "070 4946 1838", address: "Ap #541-9197 Libero Avenue"),
        Customer(name: "Dylan Dennis", email: "netus.et.malesuada@nonummyutmolestie.net", phone: "0983 635 9972", address: "Ap #228-2746 Lorem Rd."),
        Customer(name: "Thor Allison", email: "nisi.a.odio@eratEtiamvestibulum.com", phone: "(01648) 03010", address: "P.O. Box 927, 4478 Ac St."),
        Customer(name: "Ferdinand Hartman", email: "mi@Proin.com", phone: "(0111) 449 9977", address: "P.O. Box 813, 9179 Iaculis St."),
        Customer(name: "Wing Fitzgerald", email: "elit.Curabitur.sed@nisl.org", phone: "0800 355 6449", address: "7576 Aenean Road")])

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Material.Color.blueGrey.darken3
        self.view.addSubview(table)
        table.table.backgroundColor = .clear
        table.snp.makeConstraints { make in
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
                make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
                make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
            } else {
                make.top.equalTo(self.view.snp.top)
                make.bottom.equalTo(self.view.snp.bottom)
                make.leading.equalTo(self.view.snp.leading)
                make.trailing.equalTo(self.view.snp.trailing)
            }
        }
        // Binding data around
        columns.accept([KLDataTableColumn<Customer>(name: "NAME", type: .name, value: { $0.name }),
                        KLDataTableColumn<Customer>(name: "ADDRESS", type: .leftFlex, value: { $0.address }),
                        KLDataTableColumn<Customer>(name: "EMAIL", type: .leftFlex, value: { $0.email }),
                        KLDataTableColumn<Customer>(name: "PHONE", type: .leftFlex, value: { $0.phone }) ])
        summaryCells.accept([KLDataTableSummaryCell(type: .name, value: { _ in "TOTAL" })])
        
        columns
            .asDriver()
            .drive(onNext: { columns in self.table.columns = columns })
            .disposed(by: disposeBag)
        
        summaryCells
            .asDriver()
            .drive(onNext: { summaryCells in self.table.summaryCells = summaryCells })
            .disposed(by: disposeBag)
        
        data
            .asDriver()
            .map { $0 }
            .drive(table.table.rx.items) { (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! KLDataTableRow<Customer>
                cell.columns = self.columns.value
                cell.item = item
                return cell
            }
            .disposed(by: disposeBag)
        // Pagination
        data
            .asDriver()
            .map { $0.count }
            .drive(table.pagination.total)
            .disposed(by: disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}

