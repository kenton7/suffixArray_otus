//
//  JobScheduler.swift
//  SuffixArray
//
//  Created by Илья Кузнецов on 29.04.2024.
//

import Foundation

actor JobScheduler {
    var jobQueue = JobQueue()
    
    func newSearch(text: String) async -> [String: String] {
        let job = Job(searchText: text, jobScheduler: self)
        jobQueue.add(job: job)
        return await job.searchSuffixes(text: text)
    }
    
    func start() {
        Task {
            await executeJobs()
        }
    }
    
    private func executeJobs() async {
        for var job in jobQueue.jobs {
            await job.performTask()
        }
    }
}
