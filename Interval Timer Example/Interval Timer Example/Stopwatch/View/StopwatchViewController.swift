//
//  StopWatchViewController.swift
//  Interval Timer Example
//
//  Created by 김명유 on 2019/11/10.
//  Copyright © 2019 myungyu Kim. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class StopwatchViewController: UIViewController {

    //MARK: - Properties
    let viewModel = StopwatchViewModel()
    let disposeBag = DisposeBag()
    
    //MARK: IBOutlet
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = UIFont.monospacedDigitSystemFont(ofSize: timeLabel.font.pointSize, weight: .thin)
        }
    }
    @IBOutlet weak var lapResetButton: UIButton!
    @IBOutlet weak var startStopButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        updateButtonState(.stopped)
        
        viewModel.delegate = self
        
        setupViewModel()
    }
    
    //MARK: - onClick Event
    private func onClickLapResetButton(_ sender: UIButton) {
        switch viewModel.stopwatchState.value {
        case .stopped: // 비활성화 상태로 누를 수 없음
            break
        case .running: // 랩타임을 기록한다.
            viewModel.insertLap()
        case .paused: // 리셋시킨다. -> stopped
            viewModel.reset()
        }
    }
    
    private func onClickStartStopButton(_ sender: UIButton) {
        switch viewModel.stopwatchState.value {
        case .stopped: // 시작한다. -> running
            viewModel.insertLap()
            viewModel.run()
        case .running: // 포즈한다. -> puased
            viewModel.pause()
        case .paused: // 재시작한다. -> running
            viewModel.run()
        }
    }
    
    //MARK: - Private Methods
    private func setupViewModel() {
        // Event Handling
        lapResetButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.onClickLapResetButton(self!.lapResetButton) })
            .disposed(by: disposeBag)
        
        startStopButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.onClickStartStopButton(self!.startStopButton) })
            .disposed(by: disposeBag)
        
        // for Stopwatch state change
        viewModel.stopwatchState
            .subscribe(onNext: { [weak self] stopwatchState in self?.updateButtonState(stopwatchState) })
            .disposed(by: disposeBag)
    }
    
    private func updateButtonState(_ state: StopwatchState) {
        switch state {
        case .stopped:
            lapResetButton.isEnabled = false
            lapResetButton.setTitle("랩", for: .normal)
            
            startStopButton.isEnabled = true
            startStopButton.tintColor = #colorLiteral(red: 0, green: 0.8188403845, blue: 0.3101151586, alpha: 0.2031517551)
            startStopButton.setTitle("시작", for: .normal)
            startStopButton.setTitleColor(#colorLiteral(red: 0.1953718066, green: 0.8167234063, blue: 0.3457654119, alpha: 1), for: .normal)
        case .running:
            lapResetButton.isEnabled = true
            lapResetButton.setTitle("랩", for: .normal)
            
            startStopButton.isEnabled = true
            startStopButton.tintColor = #colorLiteral(red: 0.7554287314, green: 0.2796246409, blue: 0.2439345419, alpha: 0.1989511986)
            startStopButton.setTitle("중단", for: .normal)
            startStopButton.setTitleColor(#colorLiteral(red: 0.9620538354, green: 0.2590582371, blue: 0.2211914957, alpha: 1), for: .normal)
            
        case .paused:
            lapResetButton.isEnabled = true
            lapResetButton.setTitle("재설정", for: .normal)
            
            startStopButton.isEnabled = true
            startStopButton.tintColor = #colorLiteral(red: 0, green: 0.8188403845, blue: 0.3101151586, alpha: 0.2031517551)
            startStopButton.setTitle("시작", for: .normal)
            startStopButton.setTitleColor(#colorLiteral(red: 0.1953718066, green: 0.8167234063, blue: 0.3457654119, alpha: 1), for: .normal)
        }
    }
}

extension StopwatchViewController: UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.lapList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.detailTextLabel?.font = UIFont.monospacedDigitSystemFont(ofSize: cell.detailTextLabel?.font.pointSize ?? 17, weight: .regular)
        cell.textLabel?.text = "랩 \(viewModel.lapList.count - indexPath.row)"
        cell.detailTextLabel?.text = viewModel.lapList[indexPath.row].timeString;
        
        return cell
    }
}

extension StopwatchViewController: StopwatchViewModelDelegate {
    
    //MARK: - StopwatchViewModelDelegate
    func didUpdateTimer(mainTimeString: String?, lapTimeString: String?) {
        timeLabel.text = mainTimeString
        
        let cell = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        cell?.detailTextLabel?.text = lapTimeString
    }
    
    func didInsertLap(at indexPath: IndexPath?) {
        self.tableView.beginUpdates()
        self.tableView.insertRows(at: [indexPath!], with: .automatic)
        self.tableView.endUpdates()
    }
    
    func didReset(state: StopwatchState, mainTimeString: String?) {
        timeLabel.text = mainTimeString
        tableView.reloadData()
    }
}
