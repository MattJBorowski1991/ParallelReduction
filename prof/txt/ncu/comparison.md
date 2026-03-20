N=1070M

1. atomic_global

atomic_global_step(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     13902433
    Memory Throughput                 %        67.89
    DRAM Throughput                   %        34.33
    Duration                         ms        23.76
    L1/TEX Cache Throughput           %        72.43
    L2 Cache Throughput               %        10.65
    SM Active Cycles              cycle  13901237.70
    Compute (SM) Throughput           %        67.89
    ----------------------- ----------- ------------

    INF   Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. 
          Check both the Compute Workload Analysis and Memory Workload Analysis sections.                               

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte         7.47
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         1.07
    Executed Ipc Elapsed  inst/cycle         1.07
    Issue Slots Busy               %        26.87
    Issued Ipc Active     inst/cycle         1.07
    SM Busy                        %        28.66
    -------------------- ----------- ------------

    OPT   Est. Local Speedup: 86.42%                                                                                    
          All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps 
          per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.             

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s       109.73
    Mem Busy                                         %        36.22
    Max Bandwidth                                    %        67.89
    L1/TEX Hit Rate                                  %         0.76
    L2 Hit Rate                                      %         2.70
    Mem Pipes Busy                                   %        67.89
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 63.38%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        26.88
    Issued Warp Per Scheduler                        0.27
    No Eligible                            %        73.12
    Active Warps Per Scheduler          warp         6.21
    Eligible Warps Per Scheduler        warp         0.37
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 32.11%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 3.7 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          6.21 active warps per scheduler, but only an average of 0.37 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, reduce the time the active warps are stalled by inspecting the top stall reasons on the Warp  
          State Statistics and Source Counters sections.                                                                

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        23.09
    Warp Cycles Per Executed Instruction           cycle        23.09
    Avg. Active Threads Per Warp                                31.46
    Avg. Not Predicated Off Threads Per Warp                    26.99
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 32.11%                                                                                          
          On average, each warp of this workload spends 7.8 cycles being stalled waiting for a scoreboard dependency on 
          a L1TEX (local, global, surface, texture) operation. Find the instruction producing the data being waited     
          upon to identify the culprit. To reduce the number of cycles waiting on L1TEX data accesses verify the        
          memory access patterns are optimal for the target architecture, attempt to increase cache hit rates by        
          increasing data locality (coalescing), or by changing the cache configuration. Consider moving frequently     
          used data to shared memory. This stall type represents about 33.6% of the total average of 23.1 cycles        
          between issuing two instructions.                                                                             
    ----- --------------------------------------------------------------------------------------------------------------
    INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on         
          sampling data. The Profiling Guide                                                                            
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#metrics-reference) provides more details    
          on each stall reason.                                                                                         

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst      3735552
    Executed Instructions                           inst    597688320
    Avg. Issued Instructions Per Scheduler          inst      3735584
    Issued Instructions                             inst    597693440
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        79.36
    Achieved Active Warps Per SM           warp        25.39
    ------------------------------- ----------- ------------

    OPT   Est. Speedup: 20.64%                                                                                          
          The difference between calculated theoretical (100.0%) and measured achieved occupancy (79.4%) can be the     
          result of warp scheduling overheads or workload imbalances during the kernel execution. Load imbalances can   
          occur between warps within a block as well as across blocks of the same kernel. See the CUDA Best Practices   
          Guide (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on     
          optimizing occupancy.                                                                                         

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle     40747437
    Total DRAM Elapsed Cycles        cycle    949680128
    Average L1 Active Cycles         cycle  13901237.70
    Total L1 Elapsed Cycles          cycle    556060784
    Average L2 Active Cycles         cycle  18550921.34
    Total L2 Elapsed Cycles          cycle    650205728
    Average SM Active Cycles         cycle  13901237.70
    Total SM Elapsed Cycles          cycle    556060784
    Average SMSP Active Cycles       cycle  13897871.24
    Total SMSP Elapsed Cycles        cycle   2224243136
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.12
    Branch Instructions              inst     69206016
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------





2. atomic_per_block


atomic_per_block_step(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     15719444
    Memory Throughput                 %        76.03
    DRAM Throughput                   %        30.61
    Duration                         ms        26.87
    L1/TEX Cache Throughput           %        82.05
    L2 Cache Throughput               %         9.41
    SM Active Cycles              cycle  15722142.70
    Compute (SM) Throughput           %        76.03
    ----------------------- ----------- ------------

    INF   Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. 
          Check both the Compute Workload Analysis and Memory Workload Analysis sections.                               

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte         7.47
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         1.03
    Executed Ipc Elapsed  inst/cycle         1.03
    Issue Slots Busy               %        25.76
    Issued Ipc Active     inst/cycle         1.03
    SM Busy                        %        32.46
    -------------------- ----------- ------------

    OPT   Est. Local Speedup: 89.33%                                                                                    
          All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps 
          per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.             

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        97.90
    Mem Busy                                         %        41.03
    Max Bandwidth                                    %        76.03
    L1/TEX Hit Rate                                  %         0.76
    L2 Hit Rate                                      %         2.66
    Mem Pipes Busy                                   %        76.03
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 71.8%                                                                                           
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        25.76
    Issued Warp Per Scheduler                        0.26
    No Eligible                            %        74.24
    Active Warps Per Scheduler          warp         6.34
    Eligible Warps Per Scheduler        warp         0.36
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 23.97%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 3.9 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          6.34 active warps per scheduler, but only an average of 0.36 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, reduce the time the active warps are stalled by inspecting the top stall reasons on the Warp  
          State Statistics and Source Counters sections.                                                                

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        24.62
    Warp Cycles Per Executed Instruction           cycle        24.62
    Avg. Active Threads Per Warp                                31.50
    Avg. Not Predicated Off Threads Per Warp                    26.55
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 23.97%                                                                                          
          On average, each warp of this workload spends 8.0 cycles being stalled waiting for a scoreboard dependency on 
          a L1TEX (local, global, surface, texture) operation. Find the instruction producing the data being waited     
          upon to identify the culprit. To reduce the number of cycles waiting on L1TEX data accesses verify the        
          memory access patterns are optimal for the target architecture, attempt to increase cache hit rates by        
          increasing data locality (coalescing), or by changing the cache configuration. Consider moving frequently     
          used data to shared memory. This stall type represents about 32.4% of the total average of 24.6 cycles        
          between issuing two instructions.                                                                             
    ----- --------------------------------------------------------------------------------------------------------------
    INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on         
          sampling data. The Profiling Guide                                                                            
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#metrics-reference) provides more details    
          on each stall reason.                                                                                         

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst   4050124.80
    Executed Instructions                           inst    648019968
    Avg. Issued Instructions Per Scheduler          inst   4050156.80
    Issued Instructions                             inst    648025088
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block              16
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           25
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        80.85
    Achieved Active Warps Per SM           warp        25.87
    ------------------------------- ----------- ------------

    OPT   Est. Speedup: 19.15%                                                                                          
          The difference between calculated theoretical (100.0%) and measured achieved occupancy (80.8%) can be the     
          result of warp scheduling overheads or workload imbalances during the kernel execution. Load imbalances can   
          occur between warps within a block as well as across blocks of the same kernel. See the CUDA Best Practices   
          Guide (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on     
          optimizing occupancy.                                                                                         

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle     41103667
    Total DRAM Elapsed Cycles        cycle   1074092032
    Average L1 Active Cycles         cycle  15722142.70
    Total L1 Elapsed Cycles          cycle    628878880
    Average L2 Active Cycles         cycle  20413513.94
    Total L2 Elapsed Cycles          cycle    735186016
    Average SM Active Cycles         cycle  15722142.70
    Total SM Elapsed Cycles          cycle    628878880
    Average SMSP Active Cycles       cycle  15722047.88
    Total SMSP Elapsed Cycles        cycle   2515515520
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.11
    Branch Instructions              inst     69206016
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------



    3. interleaved_addr_divergent_branches


      interleaved_addressing_1_step(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     51906057
    Memory Throughput                 %        45.65
    DRAM Throughput                   %        10.30
    Duration                         ms        88.73
    L1/TEX Cache Throughput           %        51.10
    L2 Cache Throughput               %         2.86
    SM Active Cycles              cycle  51908653.67
    Compute (SM) Throughput           %        58.90
    ----------------------- ----------- ------------

    OPT   This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak           
          performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak           
          typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential       
          reasons.                                                                                                      

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte        14.94
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         2.36
    Executed Ipc Elapsed  inst/cycle         2.36
    Issue Slots Busy               %        58.90
    Issued Ipc Active     inst/cycle         2.36
    SM Busy                        %        58.90
    -------------------- ----------- ------------

    INF   ALU is the highest-utilized pipeline (50.5%) based on elapsed cycles in the workload, taking into account the 
          rates of its different instructions. It executes integer and logic operations. It is well-utilized, but       
          should not be a bottleneck.                                                                                   

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        32.94
    Mem Busy                                         %        25.55
    Max Bandwidth                                    %        45.65
    L1/TEX Hit Rate                                  %         0.06
    L2 Hit Rate                                      %         2.71
    Mem Pipes Busy                                   %        45.65
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 44.72%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        58.92
    Issued Warp Per Scheduler                        0.59
    No Eligible                            %        41.08
    Active Warps Per Scheduler          warp         7.50
    Eligible Warps Per Scheduler        warp         1.29
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 41.08%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 1.7 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          7.50 active warps per scheduler, but only an average of 1.29 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, avoid possible load imbalances due to highly different execution durations per warp.          
          Reducing stalls indicated on the Warp State Statistics and Source Counters sections can help, too.            

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        12.74
    Warp Cycles Per Executed Instruction           cycle        12.74
    Avg. Active Threads Per Warp                                31.93
    Avg. Not Predicated Off Threads Per Warp                    24.36
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 30.12%                                                                                          
          On average, each warp of this workload spends 3.8 cycles being stalled waiting on a fixed latency execution   
          dependency. Typically, this stall reason should be very low and only shows up as a top contributor in         
          already highly optimized kernels. Try to hide the corresponding instruction latencies by increasing the       
          number of active warps, restructuring the code or unrolling loops. Furthermore, consider switching to         
          lower-latency instructions, e.g. by making use of fast math compiler options. This stall type represents      
          about 30.1% of the total average of 12.7 cycles between issuing two instructions.                             
    ----- --------------------------------------------------------------------------------------------------------------
    INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on         
          sampling data. The Profiling Guide                                                                            
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#metrics-reference) provides more details    
          on each stall reason.                                                                                         

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst  30579097.60
    Executed Instructions                           inst   4892655616
    Avg. Issued Instructions Per Scheduler          inst  30579121.60
    Issued Instructions                             inst   4892659456
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        94.29
    Achieved Active Warps Per SM           warp        30.17
    ------------------------------- ----------- ------------

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle  45661573.50
    Total DRAM Elapsed Cycles        cycle   3546660864
    Average L1 Active Cycles         cycle  51908653.67
    Total L1 Elapsed Cycles          cycle   2076508440
    Average L2 Active Cycles         cycle  38251265.09
    Total L2 Elapsed Cycles          cycle   2427605376
    Average SM Active Cycles         cycle  51908653.67
    Total SM Elapsed Cycles          cycle   2076508440
    Average SMSP Active Cycles       cycle     51903604
    Total SMSP Elapsed Cycles        cycle   8306033760
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.03
    Branch Instructions              inst    169869312
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------


   4. interleaved_addr_bank_conflicts


interleaved_addressing_2_step(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     38959465
    Memory Throughput                 %        60.83
    DRAM Throughput                   %        13.89
    Duration                         ms        66.60
    L1/TEX Cache Throughput           %        96.36
    L2 Cache Throughput               %         3.80
    SM Active Cycles              cycle  38958718.23
    Compute (SM) Throughput           %        60.83
    ----------------------- ----------- ------------

    INF   Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. 
          Check both the Compute Workload Analysis and Memory Workload Analysis sections.                               

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte        14.94
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         1.27
    Executed Ipc Elapsed  inst/cycle         1.27
    Issue Slots Busy               %        31.66
    Issued Ipc Active     inst/cycle         1.27
    SM Busy                        %        31.66
    -------------------- ----------- ------------

    OPT   Est. Local Speedup: 80.08%                                                                                    
          All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps 
          per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.             

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        44.42
    Mem Busy                                         %        48.18
    Max Bandwidth                                    %        60.83
    L1/TEX Hit Rate                                  %         0.13
    L2 Hit Rate                                      %         2.83
    Mem Pipes Busy                                   %        60.83
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 84.32%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     
    ----- --------------------------------------------------------------------------------------------------------------
    OPT   Est. Speedup: 71.01%                                                                                          
          The memory access pattern for shared loads might not be optimal and causes on average a 3.8 - way bank        
          conflict across all 52428800 shared load requests.This results in 146800640 bank conflicts,  which represent  
          73.68% of the overall 199229440 wavefronts for shared loads. Check the Source Counters section for            
          uncoalesced shared loads.                                                                                     
    ----- --------------------------------------------------------------------------------------------------------------
    OPT   Est. Speedup: 61.32%                                                                                          
          The memory access pattern for shared stores might not be optimal and causes on average a 2.8 - way bank       
          conflict across all 41943040 shared store requests.This results in 73400320 bank conflicts,  which represent  
          63.64% of the overall 115343360 wavefronts for shared stores. Check the Source Counters section for           
          uncoalesced shared stores.                                                                                    

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        31.66
    Issued Warp Per Scheduler                        0.32
    No Eligible                            %        68.34
    Active Warps Per Scheduler          warp         7.26
    Eligible Warps Per Scheduler        warp         0.53
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 39.17%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 3.2 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          7.26 active warps per scheduler, but only an average of 0.53 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, avoid possible load imbalances due to highly different execution durations per warp.          
          Reducing stalls indicated on the Warp State Statistics and Source Counters sections can help, too.            

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        22.94
    Warp Cycles Per Executed Instruction           cycle        22.94
    Avg. Active Threads Per Warp                                31.84
    Avg. Not Predicated Off Threads Per Warp                    21.22
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 20.49%                                                                                          
          Instructions are executed in warps, which are groups of 32 threads. Optimal instruction throughput is         
          achieved if all 32 threads of a warp execute the same instruction. The chosen launch configuration, early     
          thread completion, and divergent flow control can significantly lower the number of active threads in a warp  
          per cycle. This workload achieves an average of 31.8 threads being active per cycle. This is further reduced  
          to 21.2 threads per warp due to predication. The compiler may use predication to avoid an actual branch.      
          Instead, all instructions are scheduled, but a per-thread condition code or predicate controls which threads  
          execute the instructions. Try to avoid different execution paths within a warp when possible.                 

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst  12333875.20
    Executed Instructions                           inst   1973420032
    Avg. Issued Instructions Per Scheduler          inst  12333907.20
    Issued Instructions                             inst   1973425152
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        91.43
    Achieved Active Warps Per SM           warp        29.26
    ------------------------------- ----------- ------------

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle  46226667.50
    Total DRAM Elapsed Cycles        cycle   2661682176
    Average L1 Active Cycles         cycle  38958718.23
    Total L1 Elapsed Cycles          cycle   1558369576
    Average L2 Active Cycles         cycle  39542857.75
    Total L2 Elapsed Cycles          cycle   1822103776
    Average SM Active Cycles         cycle  38958718.23
    Total SM Elapsed Cycles          cycle   1558369576
    Average SMSP Active Cycles       cycle  38956775.49
    Total SMSP Elapsed Cycles        cycle   6233478304
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.10
    Branch Instructions              inst    203423744
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------

    OPT   Est. Speedup: 70%                                                                                             
          This kernel has uncoalesced shared accesses resulting in a total of 220200960 excessive wavefronts (70% of    
          the total 314572800 wavefronts). Check the L1 Wavefronts Shared Excessive table for the primary source        
          locations. The CUDA Best Practices Guide                                                                      
           (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#shared-memory-in-matrix-multiplication-c
          -ab) has an example on optimizing shared memory accesses.       


5. sequential_addressing

sequential_addressing_step(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     30369710
    Memory Throughput                 %        78.03
    DRAM Throughput                   %        17.83
    Duration                         ms        51.91
    L1/TEX Cache Throughput           %        87.37
    L2 Cache Throughput               %         4.88
    SM Active Cycles              cycle  30368401.82
    Compute (SM) Throughput           %        78.03
    ----------------------- ----------- ------------

    INF   Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. 
          Check both the Compute Workload Analysis and Memory Workload Analysis sections.                               

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte        14.94
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         1.38
    Executed Ipc Elapsed  inst/cycle         1.38
    Issue Slots Busy               %        34.40
    Issued Ipc Active     inst/cycle         1.38
    SM Busy                        %        35.22
    -------------------- ----------- ------------

    INF   ALU is the highest-utilized pipeline (24.9%) based on elapsed cycles in the workload, taking into account the 
          rates of its different instructions. It executes integer and logic operations. It is well-utilized, but       
          should not be a bottleneck.                                                                                   

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        57.01
    Mem Busy                                         %        43.69
    Max Bandwidth                                    %        78.03
    L1/TEX Hit Rate                                  %         0.11
    L2 Hit Rate                                      %         2.79
    Mem Pipes Busy                                   %        78.03
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 76.45%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        34.40
    Issued Warp Per Scheduler                        0.34
    No Eligible                            %        65.60
    Active Warps Per Scheduler          warp         7.17
    Eligible Warps Per Scheduler        warp         0.56
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 21.97%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 2.9 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          7.17 active warps per scheduler, but only an average of 0.56 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, avoid possible load imbalances due to highly different execution durations per warp.          
          Reducing stalls indicated on the Warp State Statistics and Source Counters sections can help, too.            

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        20.83
    Warp Cycles Per Executed Instruction           cycle        20.83
    Avg. Active Threads Per Warp                                31.81
    Avg. Not Predicated Off Threads Per Warp                    19.59
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 30.26%                                                                                          
          Instructions are executed in warps, which are groups of 32 threads. Optimal instruction throughput is         
          achieved if all 32 threads of a warp execute the same instruction. The chosen launch configuration, early     
          thread completion, and divergent flow control can significantly lower the number of active threads in a warp  
          per cycle. This workload achieves an average of 31.8 threads being active per cycle. This is further reduced  
          to 19.6 threads per warp due to predication. The compiler may use predication to avoid an actual branch.      
          Instead, all instructions are scheduled, but a per-thread condition code or predicate controls which threads  
          execute the instructions. Try to avoid different execution paths within a warp when possible.                 

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst  10446438.40
    Executed Instructions                           inst   1671430144
    Avg. Issued Instructions Per Scheduler          inst  10446462.40
    Issued Instructions                             inst   1671433984
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        90.40
    Achieved Active Warps Per SM           warp        28.93
    ------------------------------- ----------- ------------

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle  46246582.50
    Total DRAM Elapsed Cycles        cycle   2074893312
    Average L1 Active Cycles         cycle  30368401.82
    Total L1 Elapsed Cycles          cycle   1214764272
    Average L2 Active Cycles         cycle  36651407.34
    Total L2 Elapsed Cycles          cycle   1420367584
    Average SM Active Cycles         cycle  30368401.82
    Total SM Elapsed Cycles          cycle   1214764272
    Average SMSP Active Cycles       cycle  30368337.81
    Total SMSP Elapsed Cycles        cycle   4859057088
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.10
    Branch Instructions              inst    169869312
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------



    6. two_elems_per_thread


    two_elems_per_thread_step(const int *, int *, int) (1048576, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     16984455
    Memory Throughput                 %        77.18
    DRAM Throughput                   %        31.52
    Duration                         ms        29.03
    L1/TEX Cache Throughput           %        86.45
    L2 Cache Throughput               %         8.58
    SM Active Cycles              cycle  16981664.98
    Compute (SM) Throughput           %        77.18
    ----------------------- ----------- ------------

    INF   Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. 
          Check both the Compute Workload Analysis and Memory Workload Analysis sections.                               

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte         7.47
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         1.37
    Executed Ipc Elapsed  inst/cycle         1.37
    Issue Slots Busy               %        34.15
    Issued Ipc Active     inst/cycle         1.37
    SM Busy                        %        34.78
    -------------------- ----------- ------------

    INF   ALU is the highest-utilized pipeline (24.2%) based on elapsed cycles in the workload, taking into account the 
          rates of its different instructions. It executes integer and logic operations. It is well-utilized, but       
          should not be a bottleneck.                                                                                   

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s       100.77
    Mem Busy                                         %        43.23
    Max Bandwidth                                    %        77.18
    L1/TEX Hit Rate                                  %         0.08
    L2 Hit Rate                                      %         1.52
    Mem Pipes Busy                                   %        77.18
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 75.65%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        34.15
    Issued Warp Per Scheduler                        0.34
    No Eligible                            %        65.85
    Active Warps Per Scheduler          warp         7.24
    Eligible Warps Per Scheduler        warp         0.60
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 22.82%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 2.9 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          7.24 active warps per scheduler, but only an average of 0.60 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, avoid possible load imbalances due to highly different execution durations per warp.          
          Reducing stalls indicated on the Warp State Statistics and Source Counters sections can help, too.            

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        21.19
    Warp Cycles Per Executed Instruction           cycle        21.19
    Avg. Active Threads Per Warp                                31.82
    Avg. Not Predicated Off Threads Per Warp                    20.83
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 26.95%                                                                                          
          Instructions are executed in warps, which are groups of 32 threads. Optimal instruction throughput is         
          achieved if all 32 threads of a warp execute the same instruction. The chosen launch configuration, early     
          thread completion, and divergent flow control can significantly lower the number of active threads in a warp  
          per cycle. This workload achieves an average of 31.8 threads being active per cycle. This is further reduced  
          to 20.8 threads per warp due to predication. The compiler may use predication to avoid an actual branch.      
          Instead, all instructions are scheduled, but a per-thread condition code or predicate controls which threads  
          execute the instructions. Try to avoid different execution paths within a warp when possible.                 

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst      5799936
    Executed Instructions                           inst    927989760
    Avg. Issued Instructions Per Scheduler          inst      5799960
    Issued Instructions                             inst    927993600
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                1048576
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       268435456
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                             6553.60
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        91.22
    Achieved Active Warps Per SM           warp        29.19
    ------------------------------- ----------- ------------

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle     45714255
    Total DRAM Elapsed Cycles        cycle   1160269824
    Average L1 Active Cycles         cycle  16981664.98
    Total L1 Elapsed Cycles          cycle    679338240
    Average L2 Active Cycles         cycle  22845282.56
    Total L2 Elapsed Cycles          cycle    794349440
    Average SM Active Cycles         cycle  16981664.98
    Total SM Elapsed Cycles          cycle    679338240
    Average SMSP Active Cycles       cycle  16981517.77
    Total SMSP Elapsed Cycles        cycle   2717352960
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.10
    Branch Instructions              inst     93323264
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------


    7. two_elems_per_thread_grid_strided


    two_elems_per_thread_grid_strided_step(const int *, int *, int) (1048576, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     17638388
    Memory Throughput                 %        71.93
    DRAM Throughput                   %        30.17
    Duration                         ms        30.15
    L1/TEX Cache Throughput           %        80.85
    L2 Cache Throughput               %         8.27
    SM Active Cycles              cycle  17637795.27
    Compute (SM) Throughput           %        71.93
    ----------------------- ----------- ------------

    INF   Compute and Memory are well-balanced: To reduce runtime, both computation and memory traffic must be reduced. 
          Check both the Compute Workload Analysis and Memory Workload Analysis sections.                               

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte         7.47
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         2.04
    Executed Ipc Elapsed  inst/cycle         2.04
    Issue Slots Busy               %        51.01
    Issued Ipc Active     inst/cycle         2.04
    SM Busy                        %        51.01
    -------------------- ----------- ------------

    INF   ALU is the highest-utilized pipeline (36.3%) based on elapsed cycles in the workload, taking into account the 
          rates of its different instructions. It executes integer and logic operations. It is well-utilized, but       
          should not be a bottleneck.                                                                                   

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        96.46
    Mem Busy                                         %        40.43
    Max Bandwidth                                    %        71.93
    L1/TEX Hit Rate                                  %         0.04
    L2 Hit Rate                                      %         1.39
    Mem Pipes Busy                                   %        71.93
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 70.75%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        51.02
    Issued Warp Per Scheduler                        0.51
    No Eligible                            %        48.98
    Active Warps Per Scheduler          warp         7.29
    Eligible Warps Per Scheduler        warp         0.96
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 28.07%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 2.0 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          7.29 active warps per scheduler, but only an average of 0.96 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, avoid possible load imbalances due to highly different execution durations per warp.          
          Reducing stalls indicated on the Warp State Statistics and Source Counters sections can help, too.            

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        14.28
    Warp Cycles Per Executed Instruction           cycle        14.28
    Avg. Active Threads Per Warp                                31.89
    Avg. Not Predicated Off Threads Per Warp                    23.68
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 18.7%                                                                                           
          Instructions are executed in warps, which are groups of 32 threads. Optimal instruction throughput is         
          achieved if all 32 threads of a warp execute the same instruction. The chosen launch configuration, early     
          thread completion, and divergent flow control can significantly lower the number of active threads in a warp  
          per cycle. This workload achieves an average of 31.9 threads being active per cycle. This is further reduced  
          to 23.7 threads per warp due to predication. The compiler may use predication to avoid an actual branch.      
          Instead, all instructions are scheduled, but a per-thread condition code or predicate controls which threads  
          execute the instructions. Try to avoid different execution paths within a warp when possible.                 

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst   8998092.80
    Executed Instructions                           inst   1439694848
    Avg. Issued Instructions Per Scheduler          inst   8998124.80
    Issued Instructions                             inst   1439699968
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                1048576
    Registers Per Thread             register/thread              30
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       268435456
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                             6553.60
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block            8
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        91.78
    Achieved Active Warps Per SM           warp        29.37
    ------------------------------- ----------- ------------

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle  45443960.50
    Total DRAM Elapsed Cycles        cycle   1205083136
    Average L1 Active Cycles         cycle  17637795.27
    Total L1 Elapsed Cycles          cycle    705575240
    Average L2 Active Cycles         cycle  23668054.59
    Total L2 Elapsed Cycles          cycle    824932992
    Average SM Active Cycles         cycle  17637795.27
    Total SM Elapsed Cycles          cycle    705575240
    Average SMSP Active Cycles       cycle  17636299.94
    Total SMSP Elapsed Cycles        cycle   2822300960
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.10
    Branch Instructions              inst    143654912
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------


    8. unroll_last_warp
    
    unroll_last_warp_step(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     26272450
    Memory Throughput                 %        90.20
    DRAM Throughput                   %        20.96
    Duration                         ms        44.91
    L1/TEX Cache Throughput           %        93.80
    L2 Cache Throughput               %         5.63
    SM Active Cycles              cycle  26270287.57
    Compute (SM) Throughput           %        90.20
    ----------------------- ----------- ------------

    INF   This workload is utilizing greater than 80.0% of the available compute or memory performance of the device.   
          To further improve performance, work will likely need to be shifted from the most utilized to another unit.   
          Start by analyzing workloads in the Compute Workload Analysis section.                                        

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte         7.47
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         1.22
    Executed Ipc Elapsed  inst/cycle         1.22
    Issue Slots Busy               %        30.58
    Issued Ipc Active     inst/cycle         1.22
    SM Busy                        %        34.33
    -------------------- ----------- ------------

    OPT   Est. Local Speedup: 84.03%                                                                                    
          All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps 
          per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.             

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        67.00
    Mem Busy                                         %        46.90
    Max Bandwidth                                    %        90.20
    L1/TEX Hit Rate                                  %         0.19
    L2 Hit Rate                                      %         2.76
    Mem Pipes Busy                                   %        90.20
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 82.08%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        30.59
    Issued Warp Per Scheduler                        0.31
    No Eligible                            %        69.41
    Active Warps Per Scheduler          warp         6.97
    Eligible Warps Per Scheduler        warp         0.52
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 9.795%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 3.3 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          6.97 active warps per scheduler, but only an average of 0.52 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, avoid possible load imbalances due to highly different execution durations per warp.          
          Reducing stalls indicated on the Warp State Statistics and Source Counters sections can help, too.            

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        22.80
    Warp Cycles Per Executed Instruction           cycle        22.80
    Avg. Active Threads Per Warp                                31.75
    Avg. Not Predicated Off Threads Per Warp                    18.27
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 38.7%                                                                                           
          Instructions are executed in warps, which are groups of 32 threads. Optimal instruction throughput is         
          achieved if all 32 threads of a warp execute the same instruction. The chosen launch configuration, early     
          thread completion, and divergent flow control can significantly lower the number of active threads in a warp  
          per cycle. This workload achieves an average of 31.7 threads being active per cycle. This is further reduced  
          to 18.3 threads per warp due to predication. The compiler may use predication to avoid an actual branch.      
          Instead, all instructions are scheduled, but a per-thread condition code or predicate controls which threads  
          execute the instructions. Try to avoid different execution paths within a warp when possible.                 

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst   8034713.60
    Executed Instructions                           inst   1285554176
    Avg. Issued Instructions Per Scheduler          inst   8034737.60
    Issued Instructions                             inst   1285558016
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        88.11
    Achieved Active Warps Per SM           warp        28.19
    ------------------------------- ----------- ------------

    OPT   Est. Speedup: 9.795%                                                                                          
          The difference between calculated theoretical (100.0%) and measured achieved occupancy (88.1%) can be the     
          result of warp scheduling overheads or workload imbalances during the kernel execution. Load imbalances can   
          occur between warps within a block as well as across blocks of the same kernel. See the CUDA Best Practices   
          Guide (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on     
          optimizing occupancy.                                                                                         

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle  47016219.50
    Total DRAM Elapsed Cycles        cycle   1794921472
    Average L1 Active Cycles         cycle  26270287.57
    Total L1 Elapsed Cycles          cycle   1050845736
    Average L2 Active Cycles         cycle  33450780.19
    Total L2 Elapsed Cycles          cycle   1228741856
    Average SM Active Cycles         cycle  26270287.57
    Total SM Elapsed Cycles          cycle   1050845736
    Average SMSP Active Cycles       cycle  26270062.06
    Total SMSP Elapsed Cycles        cycle   4203382944
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.05
    Branch Instructions              inst     69206016
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------





    8. unroll_fully

    void unroll_fully_step_t<256>(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     18934552
    Memory Throughput                 %        55.38
    DRAM Throughput                   %        25.87
    Duration                         ms        32.37
    L1/TEX Cache Throughput           %        60.37
    L2 Cache Throughput               %         7.82
    SM Active Cycles              cycle  18930750.20
    Compute (SM) Throughput           %        55.38
    ----------------------- ----------- ------------

    OPT   This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak           
          performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak           
          typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential       
          reasons.                                                                                                      

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte         7.47
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         0.88
    Executed Ipc Elapsed  inst/cycle         0.88
    Issue Slots Busy               %        22.01
    Issued Ipc Active     inst/cycle         0.88
    SM Busy                        %        24.37
    -------------------- ----------- ------------

    OPT   Est. Local Speedup: 92.66%                                                                                    
          All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps 
          per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.             

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        82.73
    Mem Busy                                         %        30.18
    Max Bandwidth                                    %        55.38
    L1/TEX Hit Rate                                  %         1.44
    L2 Hit Rate                                      %         2.69
    Mem Pipes Busy                                   %        55.38
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 52.82%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        23.16
    Issued Warp Per Scheduler                        0.23
    No Eligible                            %        76.84
    Active Warps Per Scheduler          warp         5.36
    Eligible Warps Per Scheduler        warp         0.34
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 44.62%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 4.3 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          5.36 active warps per scheduler, but only an average of 0.34 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, reduce the time the active warps are stalled by inspecting the top stall reasons on the Warp  
          State Statistics and Source Counters sections.                                                                

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        23.14
    Warp Cycles Per Executed Instruction           cycle        23.15
    Avg. Active Threads Per Warp                                31.51
    Avg. Not Predicated Off Threads Per Warp                    24.15
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 33.39%                                                                                          
          On average, each warp of this workload spends 7.7 cycles being stalled waiting for a scoreboard dependency on 
          a L1TEX (local, global, surface, texture) operation. Find the instruction producing the data being waited     
          upon to identify the culprit. To reduce the number of cycles waiting on L1TEX data accesses verify the        
          memory access patterns are optimal for the target architecture, attempt to increase cache hit rates by        
          increasing data locality (coalescing), or by changing the cache configuration. Consider moving frequently     
          used data to shared memory. This stall type represents about 33.4% of the total average of 23.1 cycles        
          between issuing two instructions.                                                                             
    ----- --------------------------------------------------------------------------------------------------------------
    INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on         
          sampling data. The Profiling Guide                                                                            
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#metrics-reference) provides more details    
          on each stall reason.                                                                                         

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst   4168089.60
    Executed Instructions                           inst    666894336
    Avg. Issued Instructions Per Scheduler          inst   4168121.60
    Issued Instructions                             inst    666899456
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        65.01
    Achieved Active Warps Per SM           warp        20.80
    ------------------------------- ----------- ------------

    OPT   Est. Speedup: 34.99%                                                                                          
          The difference between calculated theoretical (100.0%) and measured achieved occupancy (65.0%) can be the     
          result of warp scheduling overheads or workload imbalances during the kernel execution. Load imbalances can   
          occur between warps within a block as well as across blocks of the same kernel. See the CUDA Best Practices   
          Guide (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on     
          optimizing occupancy.                                                                                         

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle     41837156
    Total DRAM Elapsed Cycles        cycle   1293925376
    Average L1 Active Cycles         cycle  18930750.20
    Total L1 Elapsed Cycles          cycle    757404424
    Average L2 Active Cycles         cycle     22149979
    Total L2 Elapsed Cycles          cycle    885553952
    Average SM Active Cycles         cycle  18930750.20
    Total SM Elapsed Cycles          cycle    757404424
    Average SMSP Active Cycles       cycle  17994724.79
    Total SMSP Elapsed Cycles        cycle   3029617696
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.15
    Branch Instructions              inst     98566144
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------

    10. shfl_down_sync


     warp_intrinsics_shfl_down_sync_step(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     16747339
    Memory Throughput                 %        55.73
    DRAM Throughput                   %        29.43
    Duration                         ms        28.63
    L1/TEX Cache Throughput           %        61.36
    L2 Cache Throughput               %         8.83
    SM Active Cycles              cycle  16742064.32
    Compute (SM) Throughput           %        55.73
    ----------------------- ----------- ------------

    OPT   This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak           
          performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak           
          typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential       
          reasons.                                                                                                      

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte         7.47
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         1.06
    Executed Ipc Elapsed  inst/cycle         1.06
    Issue Slots Busy               %        26.61
    Issued Ipc Active     inst/cycle         1.06
    SM Busy                        %        26.61
    -------------------- ----------- ------------

    OPT   Est. Local Speedup: 82.94%                                                                                    
          All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps 
          per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.             

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        94.09
    Mem Busy                                         %        30.68
    Max Bandwidth                                    %        55.73
    L1/TEX Hit Rate                                  %         1.35
    L2 Hit Rate                                      %         2.62
    Mem Pipes Busy                                   %        55.73
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 53.69%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        28.05
    Issued Warp Per Scheduler                        0.28
    No Eligible                            %        71.95
    Active Warps Per Scheduler          warp         5.93
    Eligible Warps Per Scheduler        warp         0.41
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 44.27%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 3.6 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          5.93 active warps per scheduler, but only an average of 0.41 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, reduce the time the active warps are stalled by inspecting the top stall reasons on the Warp  
          State Statistics and Source Counters sections.                                                                

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        21.16
    Warp Cycles Per Executed Instruction           cycle        21.16
    Avg. Active Threads Per Warp                                31.54
    Avg. Not Predicated Off Threads Per Warp                    24.48
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 33%                                                                                             
          On average, each warp of this workload spends 7.0 cycles being stalled waiting for a scoreboard dependency on 
          a L1TEX (local, global, surface, texture) operation. Find the instruction producing the data being waited     
          upon to identify the culprit. To reduce the number of cycles waiting on L1TEX data accesses verify the        
          memory access patterns are optimal for the target architecture, attempt to increase cache hit rates by        
          increasing data locality (coalescing), or by changing the cache configuration. Consider moving frequently     
          used data to shared memory. This stall type represents about 33.0% of the total average of 21.2 cycles        
          between issuing two instructions.                                                                             
    ----- --------------------------------------------------------------------------------------------------------------
    INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on         
          sampling data. The Profiling Guide                                                                            
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#metrics-reference) provides more details    
          on each stall reason.                                                                                         

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst      4456448
    Executed Instructions                           inst    713031680
    Avg. Issued Instructions Per Scheduler          inst      4456472
    Issued Instructions                             inst    713035520
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        71.89
    Achieved Active Warps Per SM           warp        23.01
    ------------------------------- ----------- ------------

    OPT   Est. Speedup: 28.11%                                                                                          
          The difference between calculated theoretical (100.0%) and measured achieved occupancy (71.9%) can be the     
          result of warp scheduling overheads or workload imbalances during the kernel execution. Load imbalances can   
          occur between warps within a block as well as across blocks of the same kernel. See the CUDA Best Practices   
          Guide (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on     
          optimizing occupancy.                                                                                         

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle     42088217
    Total DRAM Elapsed Cycles        cycle   1144071168
    Average L1 Active Cycles         cycle  16742064.32
    Total L1 Elapsed Cycles          cycle    669859824
    Average L2 Active Cycles         cycle  21468039.19
    Total L2 Elapsed Cycles          cycle    783259872
    Average SM Active Cycles         cycle  16742064.32
    Total SM Elapsed Cycles          cycle    669859824
    Average SMSP Active Cycles       cycle  15887153.43
    Total SMSP Elapsed Cycles        cycle   2679439296
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.10
    Branch Instructions              inst     71303168
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------


    11. shfl_up_sync


 warp_intrinsics_shfl_up_sync_step(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     16747077
    Memory Throughput                 %        55.73
    DRAM Throughput                   %        29.43
    Duration                         ms        28.63
    L1/TEX Cache Throughput           %        61.37
    L2 Cache Throughput               %         8.84
    SM Active Cycles              cycle  16745090.22
    Compute (SM) Throughput           %        55.73
    ----------------------- ----------- ------------

    OPT   This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak           
          performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak           
          typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential       
          reasons.                                                                                                      

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte         7.47
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         1.06
    Executed Ipc Elapsed  inst/cycle         1.06
    Issue Slots Busy               %        26.61
    Issued Ipc Active     inst/cycle         1.06
    SM Busy                        %        26.61
    -------------------- ----------- ------------

    OPT   Est. Local Speedup: 82.94%                                                                                    
          All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps 
          per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.             

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        94.09
    Mem Busy                                         %        30.68
    Max Bandwidth                                    %        55.73
    L1/TEX Hit Rate                                  %         1.35
    L2 Hit Rate                                      %         2.77
    Mem Pipes Busy                                   %        55.73
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 53.7%                                                                                           
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        28.05
    Issued Warp Per Scheduler                        0.28
    No Eligible                            %        71.95
    Active Warps Per Scheduler          warp         5.93
    Eligible Warps Per Scheduler        warp         0.41
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 44.27%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 3.6 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          5.93 active warps per scheduler, but only an average of 0.41 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, reduce the time the active warps are stalled by inspecting the top stall reasons on the Warp  
          State Statistics and Source Counters sections.                                                                

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        21.16
    Warp Cycles Per Executed Instruction           cycle        21.16
    Avg. Active Threads Per Warp                                31.54
    Avg. Not Predicated Off Threads Per Warp                    24.48
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 33%                                                                                             
          On average, each warp of this workload spends 7.0 cycles being stalled waiting for a scoreboard dependency on 
          a L1TEX (local, global, surface, texture) operation. Find the instruction producing the data being waited     
          upon to identify the culprit. To reduce the number of cycles waiting on L1TEX data accesses verify the        
          memory access patterns are optimal for the target architecture, attempt to increase cache hit rates by        
          increasing data locality (coalescing), or by changing the cache configuration. Consider moving frequently     
          used data to shared memory. This stall type represents about 33.0% of the total average of 21.2 cycles        
          between issuing two instructions.                                                                             
    ----- --------------------------------------------------------------------------------------------------------------
    INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on         
          sampling data. The Profiling Guide                                                                            
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#metrics-reference) provides more details    
          on each stall reason.                                                                                         

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst      4456448
    Executed Instructions                           inst    713031680
    Avg. Issued Instructions Per Scheduler          inst      4456472
    Issued Instructions                             inst    713035520
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        71.88
    Achieved Active Warps Per SM           warp        23.00
    ------------------------------- ----------- ------------

    OPT   Est. Speedup: 28.12%                                                                                          
          The difference between calculated theoretical (100.0%) and measured achieved occupancy (71.9%) can be the     
          result of warp scheduling overheads or workload imbalances during the kernel execution. Load imbalances can   
          occur between warps within a block as well as across blocks of the same kernel. See the CUDA Best Practices   
          Guide (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on     
          optimizing occupancy.                                                                                         

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle  42085528.50
    Total DRAM Elapsed Cycles        cycle   1144064000
    Average L1 Active Cycles         cycle  16745090.22
    Total L1 Elapsed Cycles          cycle    669781304
    Average L2 Active Cycles         cycle  21373383.22
    Total L2 Elapsed Cycles          cycle    783247488
    Average SM Active Cycles         cycle  16745090.22
    Total SM Elapsed Cycles          cycle    669781304
    Average SMSP Active Cycles       cycle  15887560.41
    Total SMSP Elapsed Cycles        cycle   2679125216
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.10
    Branch Instructions              inst     71303168
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------


    12. shfl_xor_sync



    warp_intrinsics_shfl_xor_sync_step(const int *, int *, int) (2097152, 1, 1)x(256, 1, 1), Context 1, Stream 7, Device 0, CC 7.5
    Section: GPU Speed Of Light Throughput
    ----------------------- ----------- ------------
    Metric Name             Metric Unit Metric Value
    ----------------------- ----------- ------------
    DRAM Frequency                  Ghz         5.00
    SM Frequency                    Mhz       585.00
    Elapsed Cycles                cycle     16746741
    Memory Throughput                 %        55.73
    DRAM Throughput                   %        29.43
    Duration                         ms        28.63
    L1/TEX Cache Throughput           %        61.36
    L2 Cache Throughput               %         8.83
    SM Active Cycles              cycle  16743481.05
    Compute (SM) Throughput           %        55.73
    ----------------------- ----------- ------------

    OPT   This workload exhibits low compute throughput and memory bandwidth utilization relative to the peak           
          performance of this device. Achieved compute throughput and/or memory bandwidth below 60.0% of peak           
          typically indicate latency issues. Look at Scheduler Statistics and Warp State Statistics for potential       
          reasons.                                                                                                      

    Section: GPU Speed Of Light Roofline Chart
    INF   The ratio of peak float (FP32) to double (FP64) performance on this device is 32:1. The workload achieved 0%  
          of this device's FP32 peak performance and 0% of its FP64 peak performance. See the Profiling Guide           
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#roofline) for more details on roofline      
          analysis.                                                                                                     

    Section: PM Sampling
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Maximum Buffer Size             Mbyte         7.47
    Maximum Sampling Interval       cycle        20000
    # Pass Groups                                    1
    ------------------------- ----------- ------------

    Section: Compute Workload Analysis
    -------------------- ----------- ------------
    Metric Name          Metric Unit Metric Value
    -------------------- ----------- ------------
    Executed Ipc Active   inst/cycle         1.06
    Executed Ipc Elapsed  inst/cycle         1.06
    Issue Slots Busy               %        26.61
    Issued Ipc Active     inst/cycle         1.06
    SM Busy                        %        26.61
    -------------------- ----------- ------------

    OPT   Est. Local Speedup: 82.94%                                                                                    
          All compute pipelines are under-utilized. Either this workload is very small or it doesn't issue enough warps 
          per scheduler. Check the Launch Statistics and Scheduler Statistics sections for further details.             

    Section: Memory Workload Analysis
    -------------------------------------- ----------- ------------
    Metric Name                            Metric Unit Metric Value
    -------------------------------------- ----------- ------------
    Local Memory Spilling Requests                                0
    Local Memory Spilling Request Overhead           %            0
    Memory Throughput                          Gbyte/s        94.09
    Mem Busy                                         %        30.68
    Max Bandwidth                                    %        55.73
    L1/TEX Hit Rate                                  %         1.34
    L2 Hit Rate                                      %         2.72
    Mem Pipes Busy                                   %        55.73
    -------------------------------------- ----------- ------------

    Section: Memory Workload Analysis Tables
    OPT   Est. Speedup: 53.69%                                                                                          
          The memory access pattern for global stores to L1TEX might not be optimal. On average, only 4.0 of the 32     
          bytes transmitted per sector are utilized by each thread. This could possibly be caused by a stride between   
          threads. Check the Source Counters section for uncoalesced global stores.                                     

    Section: Scheduler Statistics
    ---------------------------- ----------- ------------
    Metric Name                  Metric Unit Metric Value
    ---------------------------- ----------- ------------
    One or More Eligible                   %        28.05
    Issued Warp Per Scheduler                        0.28
    No Eligible                            %        71.95
    Active Warps Per Scheduler          warp         5.93
    Eligible Warps Per Scheduler        warp         0.41
    ---------------------------- ----------- ------------

    OPT   Est. Local Speedup: 44.27%                                                                                    
          Every scheduler is capable of issuing one instruction per cycle, but for this workload each scheduler only    
          issues an instruction every 3.6 cycles. This might leave hardware resources underutilized and may lead to     
          less optimal performance. Out of the maximum of 8 warps per scheduler, this workload allocates an average of  
          5.93 active warps per scheduler, but only an average of 0.41 warps were eligible per cycle. Eligible warps    
          are the subset of active warps that are ready to issue their next instruction. Every cycle with no eligible   
          warp results in no instruction being issued and the issue slot remains unused. To increase the number of      
          eligible warps, reduce the time the active warps are stalled by inspecting the top stall reasons on the Warp  
          State Statistics and Source Counters sections.                                                                

    Section: Warp State Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Warp Cycles Per Issued Instruction             cycle        21.16
    Warp Cycles Per Executed Instruction           cycle        21.16
    Avg. Active Threads Per Warp                                31.54
    Avg. Not Predicated Off Threads Per Warp                    24.48
    ---------------------------------------- ----------- ------------

    OPT   Est. Speedup: 33.01%                                                                                          
          On average, each warp of this workload spends 7.0 cycles being stalled waiting for a scoreboard dependency on 
          a L1TEX (local, global, surface, texture) operation. Find the instruction producing the data being waited     
          upon to identify the culprit. To reduce the number of cycles waiting on L1TEX data accesses verify the        
          memory access patterns are optimal for the target architecture, attempt to increase cache hit rates by        
          increasing data locality (coalescing), or by changing the cache configuration. Consider moving frequently     
          used data to shared memory. This stall type represents about 33.0% of the total average of 21.2 cycles        
          between issuing two instructions.                                                                             
    ----- --------------------------------------------------------------------------------------------------------------
    INF   Check the Warp Stall Sampling (All Samples) table for the top stall locations in your source based on         
          sampling data. The Profiling Guide                                                                            
          (https://docs.nvidia.com/nsight-compute/ProfilingGuide/index.html#metrics-reference) provides more details    
          on each stall reason.                                                                                         

    Section: Instruction Statistics
    ---------------------------------------- ----------- ------------
    Metric Name                              Metric Unit Metric Value
    ---------------------------------------- ----------- ------------
    Avg. Executed Instructions Per Scheduler        inst      4456448
    Executed Instructions                           inst    713031680
    Avg. Issued Instructions Per Scheduler          inst      4456472
    Issued Instructions                             inst    713035520
    ---------------------------------------- ----------- ------------

    Section: Launch Statistics
    -------------------------------- --------------- ---------------
    Metric Name                          Metric Unit    Metric Value
    -------------------------------- --------------- ---------------
    Block Size                                                   256
    Function Cache Configuration                     CachePreferNone
    Grid Size                                                2097152
    Registers Per Thread             register/thread              16
    Shared Memory Configuration Size           Kbyte           32.77
    Driver Shared Memory Per Block        byte/block               0
    Dynamic Shared Memory Per Block      Kbyte/block            1.02
    Static Shared Memory Per Block        byte/block               0
    # SMs                                         SM              40
    Stack Size                                                  1024
    Threads                                   thread       536870912
    # TPCs                                                        20
    Enabled TPC IDs                                              all
    Uses Green Context                                             0
    Waves Per SM                                            13107.20
    -------------------------------- --------------- ---------------

    Section: Occupancy
    ------------------------------- ----------- ------------
    Metric Name                     Metric Unit Metric Value
    ------------------------------- ----------- ------------
    Block Limit SM                        block           16
    Block Limit Registers                 block           16
    Block Limit Shared Mem                block           32
    Block Limit Warps                     block            4
    Theoretical Active Warps per SM        warp           32
    Theoretical Occupancy                     %          100
    Achieved Occupancy                        %        71.90
    Achieved Active Warps Per SM           warp        23.01
    ------------------------------- ----------- ------------

    OPT   Est. Speedup: 28.1%                                                                                           
          The difference between calculated theoretical (100.0%) and measured achieved occupancy (71.9%) can be the     
          result of warp scheduling overheads or workload imbalances during the kernel execution. Load imbalances can   
          occur between warps within a block as well as across blocks of the same kernel. See the CUDA Best Practices   
          Guide (https://docs.nvidia.com/cuda/cuda-c-best-practices-guide/index.html#occupancy) for more details on     
          optimizing occupancy.                                                                                         

    Section: GPU and Memory Workload Distribution
    -------------------------- ----------- ------------
    Metric Name                Metric Unit Metric Value
    -------------------------- ----------- ------------
    Average DRAM Active Cycles       cycle     42085191
    Total DRAM Elapsed Cycles        cycle   1144033280
    Average L1 Active Cycles         cycle  16743481.05
    Total L1 Elapsed Cycles          cycle    669853720
    Average L2 Active Cycles         cycle  21320952.75
    Total L2 Elapsed Cycles          cycle    783231904
    Average SM Active Cycles         cycle  16743481.05
    Total SM Elapsed Cycles          cycle    669853720
    Average SMSP Active Cycles       cycle  15887103.26
    Total SMSP Elapsed Cycles        cycle   2679414880
    -------------------------- ----------- ------------

    Section: Source Counters
    ------------------------- ----------- ------------
    Metric Name               Metric Unit Metric Value
    ------------------------- ----------- ------------
    Branch Instructions Ratio           %         0.10
    Branch Instructions              inst     71303168
    Branch Efficiency                   %          100
    Avg. Divergent Branches      branches            0
    ------------------------- ----------- ------------