//
//  TickerDetailsUpcomingViewCell.swift
//  Gainy
//
//  Created by Anton Gubarenko on 19.08.2021.
//

import UIKit

final class TickerDetailsUpcomingViewCell: TickerDetailsViewCell {
    
    static let cellHeight: CGFloat = 253.0
    
    @IBOutlet weak var innerTableView: UITableView! {
        didSet {
            innerTableView.dataSource = self
            innerTableView.delegate = self
        }
    }
    
    override func updateFromTickerData() {
        innerTableView.reloadData()
    }
}

extension TickerDetailsUpcomingViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tickerInfo?.upcomingEvents.count ?? 0 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TickerDetailsInnerUpcomingViewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.upcomingEvent = tickerInfo?.upcomingEvents[indexPath.row]
        return cell
    }
}

extension TickerDetailsUpcomingViewCell: UITableViewDelegate {
    
}

final class TickerDetailsInnerUpcomingViewCell: UITableViewCell {
    
    //MARK: - Outlets
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var enabledSwitch: UISwitch!
    
    var upcomingEvent: RemoteTicker.TickerEvent? {
        didSet {
            guard let event = upcomingEvent else {return}
            nameLbl.text = event.description
            dateLbl.text = ""
            enabledSwitch.setOn(CalendarEventsManager.shared.isScheduled(event: event), animated: true)
        }
    }
    
    @IBAction func switchChanged (sender: UISwitch) {
        guard let event = upcomingEvent else {return}
        if sender.isOn {
            CalendarEventsManager.shared.addEventToCalendar(event: event)
        } else {
            CalendarEventsManager.shared.deleteEvent(event: event)
        }
     }
}
