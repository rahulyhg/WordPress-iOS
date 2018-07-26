import UIKit
import WordPressAuthenticator

class RegisterDomainDetailsViewController: NUXTableViewController {

    private enum Constants {
        static let estimatedRowHeight: CGFloat = 62
    }

    private enum Section: Int {
        case privacyProtection = 0
        case contactInfo
        case address
    }

    private var tableHandler: ImmuTableViewHandler!
    var domain: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    static func instance() -> RegisterDomainDetailsViewController {
        let storyboard = UIStoryboard(name: "Domains", bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: "RegisterDomainDetailsViewController") as! RegisterDomainDetailsViewController
        return controller
    }

    private func configure() {
        configureTableView()
        configureNavigationBar()
        WPStyleGuide.configureColors(for: view, andTableView: tableView)
    }

    private func configureTableView() {
        tableView.estimatedRowHeight = Constants.estimatedRowHeight
        WPStyleGuide.configureColors(for: view, andTableView: tableView)
        tableView.register(
            UINib(nibName: RegisterDomainSectionHeaderView.identifier, bundle: nil),
            forHeaderFooterViewReuseIdentifier: RegisterDomainSectionHeaderView.identifier
        )

        ImmuTable.registerRows([EditableNameValueRow.self,
                                CheckmarkRow.self],
                               tableView: tableView)
        tableHandler = ImmuTableViewHandler(takeOver: self)
        // remove empty cells
        tableView.tableFooterView = UIView()
        reloadViewModel()
    }

    private func reloadViewModel() {
        tableHandler.viewModel = tableViewModel()
    }

    private func configureNavigationBar() {
        title = NSLocalizedString("Register domain",
                                  comment: "Title for the Register domain screen")
    }
}

// MARK: - Rows

extension RegisterDomainDetailsViewController {

    private func tableViewModel() -> ImmuTable {
        return ImmuTable(
            sections: [
                privacySection(),
                domainContactInfo()
            ]
        )
    }

    private func privacySection() -> ImmuTableSection {
        var rows = [ImmuTableRow]()

        rows.append(
            CheckmarkRow(
                title: Localized.PrivacySection.registerPrivatelyRowText,
                checked: true,
                action: { (row) in
                    //TODO
                }
            )
        )
        rows.append(
            CheckmarkRow(
                title: Localized.PrivacySection.registerPubliclyRowText,
                checked: false,
                action: { (row) in
                    //TODO
                }
            )
        )

        return ImmuTableSection(rows: rows)
    }

    private func domainContactInfo() -> ImmuTableSection {
        var rows = [ImmuTableRow]()

        for fieldName in Localized.ContactInfo.fields {
            rows.append(EditableNameValueRow(name: fieldName,
                                             value: nil,
                                             action: nil))
        }

        return ImmuTableSection(rows: rows)
    }
}

// MARK: - Section Header Footer

extension RegisterDomainDetailsViewController {
    open override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return nil
    }

    open override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let sectionType = Section(rawValue: section) else {
            return nil
        }
        switch sectionType {
        case .privacyProtection:
            return privacyProtectionSectionHeader()
        case .contactInfo:
            return contactInformationSectionHeader()
        default:
            break
        }
        return nil
    }

    private func privacyProtectionSectionHeader() -> RegisterDomainSectionHeaderView? {
        return sectionHeader(title: Localized.PrivacySection.title,
                             description: Localized.PrivacySection.description)
    }

    private func contactInformationSectionHeader() -> RegisterDomainSectionHeaderView? {
        return sectionHeader(title: Localized.ContactInfo.title,
                             description: Localized.ContactInfo.description)
    }

    private func sectionHeader(title: String, description: String) -> RegisterDomainSectionHeaderView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: RegisterDomainSectionHeaderView.identifier
            ) as? RegisterDomainSectionHeaderView else {
            return nil
        }
        view.setTitle(title)
        view.setDescription(description)
        return view
    }
}
