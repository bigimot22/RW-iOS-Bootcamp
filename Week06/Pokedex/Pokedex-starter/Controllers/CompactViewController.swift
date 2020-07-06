/// Copyright (c) 2020 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit

class CompactViewController: UIViewController {

  @IBOutlet private weak var collectionView: UICollectionView!
  private lazy var dataSource: DataSource = makeDataSource()
  private var dataFactory = DataFactory()
  var pokemons = [Pokemon]()

  private var searchController = UISearchController(searchResultsController: nil)

  override func viewDidLoad() {
    super.viewDidLoad()
    self.title = "PokeDex Compact"
    self.navigationController?.navigationBar.backgroundColor = .clear
    pokemons = PokemonGenerator.shared.generatePokemons()
configureSearchController()
    collectionView.collectionViewLayout = dataFactory.makeLayout(for: .compact)
    applySnapshot(animatingDifferences: false)
  }

  func applySnapshot(animatingDifferences: Bool = true) {
    var initialSnapshot = Snapshot()
    initialSnapshot.appendSections([.main])
    initialSnapshot.appendItems(pokemons, toSection: .main)
    dataSource.apply(initialSnapshot, animatingDifferences: animatingDifferences)
  }

  private func makeDataSource() -> DataSource {
    return dataFactory.makeDataSource(collectionView: self.collectionView, cellIdentifier: CompactPokemonCell.reuseIdentifier)
  }


}


extension CompactViewController: UISearchResultsUpdating {
  func updateSearchResults(for searchController: UISearchController) {
    pokemons = filteredPokemons(for: searchController.searchBar.text)
    applySnapshot()
  }

  func filteredPokemons(for queryOrNil: String?) -> [Pokemon] {
    let allPokemons = PokemonGenerator.shared.generatePokemons()
    guard
      let query = queryOrNil,
      !query.isEmpty
      else {
        return allPokemons
    }
    return allPokemons.filter {
      return $0.pokemonName.lowercased().contains(query.lowercased())
    }
  }

  func configureSearchController() {
    searchController.searchResultsUpdater = self
    searchController.obscuresBackgroundDuringPresentation = false
    searchController.searchBar.searchTextField.backgroundColor = .white
    searchController.searchBar.placeholder = "Search Pokemons"
    navigationItem.searchController = searchController
    definesPresentationContext = true
  }
}


extension CompactViewController {
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    coordinator.animate(alongsideTransition: { context in
      self.collectionView.collectionViewLayout.invalidateLayout()
    }, completion: nil)
  }
}
