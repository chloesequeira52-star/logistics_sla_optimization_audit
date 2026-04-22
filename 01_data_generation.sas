            else Traffic_Base = 1.0; 
             
            Traffic_Index = rand('Normal', Traffic_Base, 0.5); 
 
            /* 4. PERFORMANCE DATA: Calculate Total Transit Time (Minutes) */ 
            /* Variables include base time, distance, traffic, and vehicle efficiency */ 
            Base_Time = 5;  
            Vehicle_Penalty = (Vehicle = 'Box Truck')*1.5 + (Vehicle = 'E-Bike')*1.1; 
             
            Transit_Time_Mins = Base_Time +  
                                (Distance_KM * 2.2 * Vehicle_Penalty) +  
                                (Traffic_Index * 8) +  
                                rand('Normal', 0, 2); 
 
            /* Data Cleaning: Ensure transit time is never logically impossible */ 
            Transit_Time_Mins = max(2, Transit_Time_Mins); 
             
            /* Derive Delivery Timestamp from calculated minutes */ 
            Delivery_Timestamp = intnx('second', Order_Timestamp, Transit_Time_Mins * 60); 
 
            /* Formatting for readability */ 
            format Order_Timestamp Delivery_Timestamp datetime20. Distance_KM 8.2; 
             
            output; 
        end; 
    end; 
run; 
 
/* Quick verification of data integrity */ 
proc contents data=logistics_raw; run; 
proc print data=logistics_raw(obs=10); run;
