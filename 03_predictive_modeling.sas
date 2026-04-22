/* 1. PREDICTIVE MODELING: Drivers of SLA Failure */ 
/* We model the probability of a 'FAIL' event to isolate variable impact */ 
proc logistic data=delivery_audit; 
    /* Reference levels: Comparing against 'D' zone and 'Sedan' fleet */ 
    class Zone Vehicle (ref='Sedan') / param=ref; 
    model SLA_Status(event='FAIL') = Distance_KM Traffic_Index Zone Vehicle; 
    title "Predictive Model: Multivariate Drivers of Delivery Failure"; 
run; 
 
 
/* 2. COUNTERFACTUAL FINANCIAL AUDIT: The 'What-If' Scenario */ 
/* Comparing current E-Bike losses against a optimized Sedan-led strategy */ 
proc sql; 
    title "Operational Optimization: Projected Annual Savings"; 
    create table savings_audit as 
    select  
        /* Current state for E-Bikes */ 
        sum(case when Vehicle = 'E-Bike' then Refund_Cost else 0 end) as Actual_EBike_Loss format=dollar12.2, 
         
        /* Projected state if E-Bikes performed at Sedan efficiency levels */ 
        (select avg(Refund_Cost) from delivery_audit where Vehicle = 'Sedan') * (select count(*) from delivery_audit where Vehicle = 'E-Bike') as Projected_Loss_Optimized format=dollar12.2, 
         
        /* The Bottom Line: Total Monthly Savings */ 
        calculated Actual_EBike_Loss - calculated Projected_Loss_Optimized as Potential_Monthly_Savings format=dollar12.2, 
         
        /* Annualized projection for the Portfolio */ 
        (calculated Potential_Monthly_Savings * 12) as Annualized_ROI format=dollar14.2 
    from delivery_audit; 
 
    select * from savings_audit; 
    quit; 
 
 
/* 3. DECISION LOGIC: Identifying the 'E-Bike Breakpoint' */ 
/* Finding the exact distance where E-Bikes become a financial liability */ 
proc means data=delivery_audit nway noprint; 
    where Vehicle = 'E-Bike'; 
    class Distance_KM; 
    format Distance_KM 2.0; /* Grouping by whole kilometers */ 
    var Refund_Cost; 
    output out=ebike_threshold mean(Refund_Cost)=Avg_Loss; 
run; 
 
proc sgplot data=ebike_threshold; 
    series x=Distance_KM y=Avg_Loss / lineattrs=(thickness=2 color=blue); 
    refline 0.5 / axis=y label="SLA Risk Threshold" lineattrs=(pattern=dash); 
    title "The E-Bike Breakpoint: Average Loss by Distance"; 
    xaxis label="Distance (KM)"; 
    yaxis label="Average Refund Cost per Delivery ($)"; 
run; 
title;
