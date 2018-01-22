rrdtool create cpu_mem_proc_uptime_temp.rrd \
    DS:run_proc:GAUGE:600:U:U \
    DS:tot_proc:GAUGE:600:U:U \
    DS:loadavg_1min:GAUGE:600:U:U \
    DS:loadavg_5min:GAUGE:600:U:U \
    DS:cpu_user:GAUGE:600:U:U \
    DS:cpu_sys:GAUGE:600:U:U \
    DS:mem_tot:GAUGE:600:U:U \
    DS:mem_used:GAUGE:600:U:U \
    DS:uptime:GAUGE:600:U:U \
    DS:chasis_temp:GAUGE:600:U:U \
    RRA:AVERAGE:0.5:5:105120 \
    RRA:AVERAGE:0.5:30:17520 \
    RRA:AVERAGE:0.5:60:8760 \
    RRA:MIN:0.5:15:105120 \
    RRA:MIN:0.5:30:17520 \
    RRA:MIN:0.5:60:8760 \
    RRA:MAX:0.5:15:105120 \
    RRA:MAX:0.5:30:17520 \
    RRA:MAX:0.5:60:8760 \
    RRA:LAST:0.5:15:105120 \
    RRA:LAST:0.5:30:17520 \
    RRA:LAST:0.5:60:8760


rrdtool create net_disk.rrd \
    DS:net_estab:GAUGE:600:U:U \
    DS:net_close:GAUGE:600:U:U \
    DS:net_giga_rx:GAUGE:600:U:U \
    DS:net_giga_tx:GAUGE:600:U:U \
    DS:trans_down:GAUGE:600:U:U \
    DS:trans_upl:GAUGE:600:U:U \
    DS:disk_used:GAUGE:600:U:U \
    DS:disk_avail:GAUGE:600:U:U \
    RRA:AVERAGE:0.5:5:105120 \
    RRA:AVERAGE:0.5:30:17520 \
    RRA:AVERAGE:0.5:60:8760 \
    RRA:MIN:0.5:15:105120 \
    RRA:MIN:0.5:30:17520 \
    RRA:MIN:0.5:60:8760 \
    RRA:MAX:0.5:15:105120 \
    RRA:MAX:0.5:30:17520 \
    RRA:MAX:0.5:60:8760

rrdtool create temp.rrd \
    DS:ULMM:GAUGE:600:U:U \
    DS:ULLI:GAUGE:600:U:U \
    RRA:AVERAGE:0.5:5:105120 \
    RRA:AVERAGE:0.5:30:17520 \
    RRA:AVERAGE:0.5:60:8760 \
    RRA:MIN:0.5:15:105120 \
    RRA:MIN:0.5:30:17520 \
    RRA:MIN:0.5:60:8760 \
    RRA:MAX:0.5:15:105120 \
    RRA:MAX:0.5:30:17520 \
    RRA:MAX:0.5:60:8760



