import UIKit
import WordPressComStatsiOS

// MARK: - ImmuTableRow Structs

struct LatestPostSummaryRow: ImmuTableRow {

    typealias CellType = LatestPostSummaryCell

    static let cell: ImmuTableCell = {
        return ImmuTableCell.nib(CellType.defaultNib, CellType.self)
    }()

    let summaryData: StatsLatestPostSummary?
    let siteStatsInsightsDelegate: SiteStatsInsightsDelegate
    let action: ImmuTableAction? = nil

    func configureCell(_ cell: UITableViewCell) {

        guard let cell = cell as? CellType else {
            return
        }

        cell.configure(withData: summaryData, andDelegate: siteStatsInsightsDelegate)

    }
}

struct SimpleTotalsStatsRow: ImmuTableRow {

    typealias CellType = SimpleTotalsCell

    static let cell: ImmuTableCell = {
        return ImmuTableCell.nib(CellType.defaultNib, CellType.self)
    }()

    let dataRows: [StatsTotalRowData]
    let action: ImmuTableAction? = nil

    func configureCell(_ cell: UITableViewCell) {

        guard let cell = cell as? CellType else {
            return
        }

        cell.configure(dataRows: dataRows)
    }
}

struct SimpleTotalsStatsSubtitlesRow: ImmuTableRow {

    typealias CellType = SimpleTotalsCell

    static let cell: ImmuTableCell = {
        return ImmuTableCell.nib(CellType.defaultNib, CellType.self)
    }()

    let itemSubtitle: String
    let dataSubtitle: String
    let dataRows: [StatsTotalRowData]
    let action: ImmuTableAction? = nil

    func configureCell(_ cell: UITableViewCell) {

        guard let cell = cell as? CellType else {
            return
        }

        // Don't show the subtitles if there is no data
        let itemSubtitle = dataRows.count > 0 ? self.itemSubtitle : nil
        let dataSubtitle = dataRows.count > 0 ? self.dataSubtitle : nil

        cell.configure(dataRows: dataRows, itemSubtitle: itemSubtitle, dataSubtitle: dataSubtitle)
    }
}

struct CellHeaderRow: ImmuTableRow {

    typealias CellType = StatsCellHeader

    static let cell: ImmuTableCell = {
        return ImmuTableCell.nib(CellType.defaultNib, CellType.self)
    }()

    let title: String
    let action: ImmuTableAction? = nil

    func configureCell(_ cell: UITableViewCell) {

        guard let cell = cell as? CellType else {
            return
        }

        cell.configure(withTitle: title)
    }
}
