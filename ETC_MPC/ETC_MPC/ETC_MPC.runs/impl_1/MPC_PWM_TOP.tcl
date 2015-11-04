proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param gui.test TreeTableDev
  debug::add_scope template.lib 1
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir E:/ETC_MPC/ETC_MPC/ETC_MPC.cache/wt [current_project]
  set_property parent.project_path E:/ETC_MPC/ETC_MPC/ETC_MPC.xpr [current_project]
  set_property ip_repo_paths e:/ETC_MPC/ETC_MPC/ETC_MPC.cache/ip [current_project]
  set_property ip_output_repo e:/ETC_MPC/ETC_MPC/ETC_MPC.cache/ip [current_project]
  add_files -quiet E:/ETC_MPC/ETC_MPC/ETC_MPC.runs/synth_1/MPC_PWM_TOP.dcp
  read_xdc E:/ETC_MPC/ETC_MPC/ETC_MPC.srcs/constrs_1/new/MPC.xdc
  link_design -top MPC_PWM_TOP -part xc7z010clg400-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force MPC_PWM_TOP_opt.dcp
  catch {report_drc -file MPC_PWM_TOP_drc_opted.rpt}
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  place_design 
  write_checkpoint -force MPC_PWM_TOP_placed.dcp
  catch { report_io -file MPC_PWM_TOP_io_placed.rpt }
  catch { report_clock_utilization -file MPC_PWM_TOP_clock_utilization_placed.rpt }
  catch { report_utilization -file MPC_PWM_TOP_utilization_placed.rpt -pb MPC_PWM_TOP_utilization_placed.pb }
  catch { report_control_sets -verbose -file MPC_PWM_TOP_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force MPC_PWM_TOP_routed.dcp
  catch { report_drc -file MPC_PWM_TOP_drc_routed.rpt -pb MPC_PWM_TOP_drc_routed.pb }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file MPC_PWM_TOP_timing_summary_routed.rpt -rpx MPC_PWM_TOP_timing_summary_routed.rpx }
  catch { report_power -file MPC_PWM_TOP_power_routed.rpt -pb MPC_PWM_TOP_power_summary_routed.pb }
  catch { report_route_status -file MPC_PWM_TOP_route_status.rpt -pb MPC_PWM_TOP_route_status.pb }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

