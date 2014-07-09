LogSummary.countForProject null, {project_id: project._id, hidden: false, type: "log"}, (totalLogsNumber)->
  LogSummary.countForProject Date.yesterday(), {project_id: project._id, hidden: false, type: "log"}, (logsNumberSinceYesterday)->
    LogSummary.countForProject null, {project_id: project._id, hidden: false, type: "event"}, (totalEventsNumber)->
      LogSummary.countForProject Date.yesterday(), {project_id: project._id, hidden: false, type: "event"}, (eventsNumberSinceYesterday)->
        LogSummary.find({project_id: project._id, hidden: false, type: "log"}).sort({"updated": "desc"}).limit(3).exec (err, lastLogs = [])->
          LogSummary.find({project_id: project._id, hidden: false, type: "event"}).sort({"updated": "desc"}).limit(3).exec (err, lastEvents = [])->

            # SEND AN EMAIL HERE!
