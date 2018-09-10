import Foundation

final class SampleData {
    
    static func generatePlayersData() -> [BusLine] {
        return [
            BusLine(number: 1, departure:"Gare", arrival:"Hopital"),
            BusLine(number: 2, departure:"Port à Carreaux ", arrival:" C.C. Jaux Venette"),
            BusLine(number: 3, departure:"Marronniers", arrival:"  Ferdinand de Lesseps "),
            BusLine(number: 4, departure:"Palais", arrival:" CC Jaux Venette"),
            BusLine(number: 5, departure:"Gare", arrival:"Hopital"),
	
        ]
    }
}
