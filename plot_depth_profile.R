

require(ggplot2)



theme_set(theme_bw())


get_depth_trace <- function(andes_db_connection, start_dt, end_dt) {
  start_str <- strftime(start_dt-60, format = '%Y-%m-%d %H:%M:%S', tz='UTC')
  end_str <- strftime(end_dt+60, format = '%Y-%m-%d %H:%M:%S', tz='UTC')
  query <- sprintf("SELECT created_at 'time', value 'true_depth' FROM shared_models_sensordatum WHERE `type` ='true_depth' AND `created_at` Between '%s' AND '%s'", start_str, end_str)
  result <-dbSendQuery(andes_db_connection, query)
  depth <- fetch(result)
  print(depth)
  dbClearResult(result)
  depth$time <- as.POSIXct( depth$time, tz="UTC")
  attr(depth$time, 'tzone') <- "Canada/Eastern"
  return (depth)
}


get_set_times <- function(andes_db_connection, mission_id = 0, set_number = 0) {
  query <- sprintf('SELECT start_date, end_date FROM shared_models_sample WHERE mission_id=%d AND sample_number=%d', mission_id, set_number)
  result <-dbSendQuery(andes_db_connection, query)
  dates <- fetch(result)
  dbClearResult(result)
  start_dt <- as.POSIXct(strptime(dates$start_date,format='%Y-%m-%d %H:%M:%S', tz='UTC') )
  end_dt <- as.POSIXct(strptime(dates$end_date,format='%Y-%m-%d %H:%M:%S', tz='UTC') )
  attr(start_dt, 'tzone') <- "Canada/Eastern"
  attr(end_dt, 'tzone') <- "Canada/Eastern"

  return (c(start_dt,end_dt))
}



plot_depth_profile <- function(andes_db_connection, mission_id = 0, set_number = 0) {
  set_times = get_set_times(andes_db_connection, mission_id, set_number)
  depth <-get_depth_trace(andes_db_connection, set_times[1], set_times[2])
  during_set<-depth$time>set_times[1] & depth$time<set_times[2]
  min_d <- min(depth$true_depth[during_set])
  min_t <- depth$time[during_set][which.min(depth$true_depth[during_set])]

  max_d <- max(depth$true_depth[during_set])
  max_t <- depth$time[during_set][which.max(depth$true_depth[during_set])]

  start_d <- depth$true_depth[during_set][1]
  end_d <- depth$true_depth[during_set][length(depth$true_depth[during_set])]
  subtitle = sprintf("start = %.2fm \t end=%.2fm \t min = %.2fm \t max = %.2fm", start_d, end_d, min_d, max_d)

  # make depth negative
  depth$true_depth <- depth$true_depth*-1
  p <-ggplot(aes(x = time, y = true_depth), data = depth) + geom_line() + geom_point()

  p <- p + labs(title=sprintf("set: %03d", set_number), subtitle=subtitle) + scale_x_datetime(date_labels = "%m/%d %H:%M", timezone = 'Canada/Eastern')

  p <- p + geom_vline(aes(xintercept=time),
                      data=data.frame(time=set_times),
                      linetype="dotted")
  #p <- p + geom_text(aes(time, true_depth, label=label, vjust = -1),
  #                   data=data.frame(time=set_times, true_depth=c(-1*max_d,-1*max_d), label=c('start','end')))

  # min/max annotations
  p <- p + geom_text(aes(time, true_depth, label=label, vjust=-1),
                     data=data.frame(time=c(min_t, max_t),
                                     true_depth=c(-1*min_d, -1*max_d),
                                     label=c(sprintf('min=%.2fm', min_d), sprintf('max=%.2fm', max_d))))

  # start/end annotations
  p <- p + geom_text(aes(time, true_depth, label=label, vjust=1),
                     data=data.frame(time=set_times,
                                     true_depth=c(-1*start_d, -1*end_d),
                                     label=c(sprintf('start=%.2fm', start_d), sprintf('end=%.2fm', end_d))))



  return (p)

}


#########################################################



# voir le profile de profondeur du trait 33
plot_depth_profile(andes_db_connection, mission_id = 68, set_number = 1)

