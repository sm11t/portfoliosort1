//
//  ViewController.swift
//  portofliosort
//
//  Created by Asmit Datta on 11/5/26.
//

import UIKit

class ViewController: UIViewController {

    private let totalLabel = UILabel()
    private let stocksTable = UITableView()

    private var Stocks: [Stock] = [
        Stock(symbol: "AAPL", price: 10, shares: 0),
        Stock(symbol: "TSLA", price: 20, shares: 0),
        Stock(symbol: "SNAP", price: 15, shares: 0),
    ] 

    private var portfolioTotal: Decimal {
        Stocks.reduce(.zero) { $0 + $1.holdingValue }
    }

    private func sortStocks() {
        Stocks.sort { $0.holdingValue > $1.holdingValue }
    }

    private func changeShares(for symbol: String, by Change: Int) {
        guard let index = Stocks.firstIndex(where: { $0.symbol == symbol }) else { return }
        Stocks[index].shares = max(Stocks[index].shares + Change, 0)
        sortStocks()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        totalLabel.text = "Portfolio: \(portfolioTotal)"

        let stack = UIStackView(arrangedSubviews: [totalLabel, stocksTable])
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)

        stocksTable.dataSource = self

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            stack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            stack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
        ])
    }
}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Stocks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "StockCell")
            ?? UITableViewCell(style: .subtitle, reuseIdentifier: "StockCell")
        let stock = Stocks[indexPath.row]
        cell.textLabel?.text = "\(stock.symbol) . $\(stock.price)"
        cell.detailTextLabel?.text = "Shares: \(stock.shares) . Value: $\(stock.holdingValue)"
        return cell
    }
}

#Preview {
    ViewController()
}
