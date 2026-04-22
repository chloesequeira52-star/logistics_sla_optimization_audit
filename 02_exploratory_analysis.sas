    yaxis label="Minutes in Transit"; 
    xaxis label="Hour of Day (24h)"; 
    title "System Latency: The Impact of Peak Traffic on Delivery Speed"; 
run; 
 
 
/* 3. SEGMENTATION ANALYSIS: Performance by Zone & Vehicle */ 
/* Creating a summary table for cross-categorical performance */ 
proc means data=delivery_audit nway noprint; 
    class Zone Vehicle; 
    var Transit_Time_Mins Refund_Cost; 
    output out=zone_performance  
           mean(Transit_Time_Mins)=Avg_Time 
           sum(Refund_Cost)=Total_Refund_Loss 
           mean(Refund_Cost)=Loss_Per_Delivery; 
run; 
 
/* GRAPH 2: Operational Inefficiency Bar Chart */ 
proc sgplot data=zone_performance; 
    vbar Zone / response=Loss_Per_Delivery group=Vehicle groupdisplay=cluster; 
    yaxis label="Average Refund Cost ($) per Delivery"; 
    title "Operational Inefficiency by Zone and Vehicle Type"; 
run; 
 
 
/* 4. KEY SUMMARY STATISTICS */ 
title "Global SLA Performance Summary"; 
proc freq data=delivery_audit; 
    tables SLA_Status Vehicle*SLA_Status / nopercent norow nocol; 
run; 
title;
